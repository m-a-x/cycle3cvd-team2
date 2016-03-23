import cv2
import numpy as np
import pandas as pd
from sklearn.cluster import KMeans
from sklearn.cluster import MiniBatchKMeans
from sklearn.utils import shuffle
from multiprocessing import Pool
from matplotlib import pyplot as plt
import time
import os
import cPickle as pickle
import glob
from PIL import Image
from resizeimage import resizeimage

TRAINING_FOLDER = '/home/max/CVD/data_train/'
   
def load_cluster_centers(fn):	
    cluster_centers = pickle.load(open(fn, 'rb'))
    return cluster_centers
    
def get_imp(fn):
	return fn.split('/')[-1]
	
def get_ufilenames(path):
    dog_paths = glob.glob(os.path.join(path, '*.[jJ][pP][gG]'))
    return dog_paths

def get_filenames(path):
    cat_paths = glob.glob(os.path.join(path, 'c/*.[jJ][pP][gG]'))
    dog_paths = glob.glob(os.path.join(path, 'd/*.[jJ][pP][gG]'))
    return cat_paths, dog_paths

def create_dic(paths):
	d = {}
	for path in paths:
		imp = get_imp(path)
		d[imp] = path
	return d

def extract_desc_pts(fn):
	try:
		img = Image.open(fn).convert('RGB')
	except IOError:
		print fn
		return None
	cv_img = np.array(img)
	cv_img = cv_img[:, :, ::-1].copy() 
	cv_img = cv2.resize(cv_img, (100,100))
	gray = cv2.cvtColor(cv_img, cv2.COLOR_BGR2GRAY)
	orb = cv2.ORB_create(nfeatures=200)
	key_pts, desc_pts = orb.detectAndCompute(gray, None)
	return desc_pts
	
	
	
def start_svm(train_features, train_labels):
	mod = cv2.SVM(train_features, train_labels)
	return clf
	return Y_predicted


def load_ims():
	c_c = load_cluster_centers('/home/max/CVD/c_o200c200s400.pickle')
	d_c = load_cluster_centers('/home/max/CVD/d_o200c200s400.pickle')
	test_fns = get_ufilenames('/home/max/CVD/data_test')
	train_data = np.concatenate((c_c, d_c), axis = 0)
	train_labels = np.concatenate( (np.ones(len(c_c)), np.zeros(len(d_c)) ) )
	test_data = []
	for i in range(0,20):
		test_desc = extract_desc_pts(test_fns[i])
		test_data.append(test_desc)
	pred = start_svm(train_data, train_labels)
	test_fns = get_ufilenames('/home/max/CVD/data_test')
print load_ims()
def read_and_compute_SIFT(fn):
	try:
		img = Image.open(fn).convert('RGB')
	except IOError:
		print fn
		return None
	cv_img = np.array(img)
	cv_img = cv_img[:, :, ::-1].copy() 
	cv_img = cv2.resize(cv_img, (100,100))
	gray = cv2.cvtColor(cv_img, cv2.COLOR_BGR2GRAY)
	sift = cv2.xfeatures2d.SIFT_create(nfeatures=100, sigma = 1.7)
	(key_pts, desc_pts) = sift.detectAndCompute(gray, None)
	return desc_pts

def import_images():
	#IMPLEMENT TIMER CUTOFF FR+OR IF FEAT EXT TAKES TOO LONG
	d_feats = {'orb': []}
	c_feats = {'orb': []}
	(cat_paths, dog_paths) = get_filenames(TRAINING_FOLDER)
	cat_train_pts = []
	dog_train_pts = []
	for image_fn in shuffle(dog_paths, n_samples = 400, random_state=0):
		odesc_pts = extract_desc_pts(image_fn)
		try:
			for pt in odesc_pts:
				c_feats['orb'].append(pt)
		except TypeError:
			print image_fn
			continue
	for image_fn in shuffle(cat_paths, n_samples = 400, random_state=0):
		odesc_pts = extract_desc_pts(image_fn)
		try:
			for pt in odesc_pts:
				d_feats['orb'].append(pt)
		except TypeError:
			print image_fn
			continue
	cat_k_means = KMeans(n_jobs=-1, n_clusters=200)
	cat_k_means.fit(c_feats['orb'])
	print 'dog calc'
	dog_k_means = KMeans(n_jobs=-1, n_clusters=200)
	dog_k_means.fit(d_feats['orb'])
	print 'saving....'
	with open('/home/max/CVD/d_o200c200s400.pickle', 'wb') as handle:
		pickle.dump(dog_k_means.cluster_centers_, handle)
	with open('/home/max/CVD/c_o200c200s400.pickle', 'wb') as handle:
		pickle.dump(cat_k_means.cluster_centers_, handle)
	return '\n\n\n DONE   '	

#import_images()
def mod():
	cat, dog = get_filenames(TRAINING_FOLDER)
	new = get_ufilenames('home/max/CVD/data_train/')
	c = create_dic(cat)
	d = create_dic(dog)
	n = create_dic(new)
	good_cat = []
	good_dog = []
	for im in c.keys():
		print im
		try:
			good_cat.append(n[im])
		except KeyError:
			continue
	for im in d.keys():
		try:
			good_dog.append(n[im])
		except KeyError:
			continue
	return (good_cat, good_dog)

def read_and_compute_SURF(fn):
    img = cv2.imread(fn)
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    surf = cv2.xfeatures2d.SURF_create()
    kp, desc = surf.detect(gray, None, useProvidedKeypoints = False)
    return desc






'''
def online_mbk(sift_features):
    n = sift_features.shape[0]
    rng = np.random.RandomState(0)
    kmeans = MiniBatchKMeans(n_clusters = 400, batch_size = 400, max_iter = 100, random_state = rng, verbose = True)
    index = 0
    for _ in range(3):
        sift_features = shuffle(sift_features, n_samples = int(round(n*0.1)), random_state = rng)
        i = iter(sift_features)
        while True:
            index += 1
            print index*2500
            sublist = list(islice(i, 2500))
            if len(sublist) > 0:
                sublist = np.vstack(sublist)
                kmeans.partial_fit(sublist)
            else:
                break

    print "finished training"
    predicted_labels = kmeans.predict(sift_features)
    return predicted_labels

def get_hist_feature(sift_features, predicted_labels):
    feature_num = [f.shape[0] for f in sift_features]
    hist = np.zeros(shape = (len(feature_num), 400))
    for i, num in enumerate(feature_num):
        labels = predicted_labels[:num]
        for label in labels:
            hist[i, label] = hist[i, label] + 1
        predicted_labels = predicted_labels[num:]
    return hist


def main():
    n_cpu = 2
    p = Pool(n_cpu)

    dog_images, cat_images = import_files(TRAINING_FOLDER)
    n_dog = len(dog_images)
    n_cat = len(cat_images)
    n_all = n_dog + n_cat
    all_images = np.concatenate((dog_images, cat_images), axis = 0)
    all_labels = np.concatenate((np.ones(n_dog), np.zeros(n_cat)), axis = 0)
    print "begin sift feature extraction"
    sift_start = time.time()
    sift_features = p.map(map_sift_desc, all_images)
    sift_end = time.time()
    print (sift_end - sift_start)
    print "stacking features"
    stack_start = time.time()
    all_sift_features = np.vstack(sift_features)
    stack_end = time.time()
    print (stack_end - stack_start)
    print "begin mini batch kmeans"
    kmeans_start = time.time()
    all_predicted_labels = online_mbk(all_sift_features)
    kmeans_end = time.time()
    print (kmeans_end - kmeans_start)
    print "begin histogram of features"
    hist_start = time.time()
    all_hist_features = get_hist_feature(sift_features,
            all_predicted_labels)
    hist_end = time.time()
    print (hist_end - hist_start)

    X_train, X_test, Y_train, Y_test = train_test_split(all_hist_features, all_labels, test_size = 0.2, random_state = 50)
    tuned_parameters = [{'kernel': ['rbf'], 'gamma': [1e-3, 1e-4],'C': [1, 10, 100]},
            {'kernel': ['linear'], 'C': [0.001, 0.01, 0.1, 1, 10, 100]}]
    svc = svm.SVC()
    print "begin grid search with cross validation"
    grid_start = time.time()
    clf = grid_search.GridSearchCV(svc, tuned_parameters, cv = 5, n_jobs = n_cpu)
    clf.fit(X_train, Y_train)
    grid_end = time.time()
    print (grid_end - grid_start)
    print clf.best_estimator_
    print clf.best_score_
    print clf.best_params_
    print "begin fitting test data"
    fit_start = time.time()
    clf_best = svm.SVC(C = 1, gamma = 0.0001, kernel = 'rbf')
    clf_best.fit(X_train, Y_train)
    Y_pred1 = clf_best.predict(X_train)
    Y_pred2 = clf_best.predict(X_test)
    fit_end = time.time()
    print (fit_end - fit_start)
    print classification_report(Y_train, Y_pred1)
    print classification_report(Y_test, Y_pred2)
    print clf_best.score(X_train, Y_train)
    print clf_best.score(X_test, Y_test)

#print main()
'''
