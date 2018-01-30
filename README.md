# Human Action Recognition from Depth Data

This projects implements a system for human action recognition, using depth sensors from devices such as Microsoft Kinect. Recognition is performed based on the location of joints in the skeleton, during the action sequence. The system can be tested on datasets such as MSR Action3D, which are publically available.

Each set of four joints, i.e. skeletal quads, in every frame, is represented by its local coordinates. The coordinate system is rotated, shifted, and scaled such that the two joints farthest apart are assigned coordinates (0, 0, 0) and (1, 1, 1), respectively [1][2]. The quad is represented by the coordinates of the other two points with respect to this coordinate system, thus leading to a 6D descriptor.

The Skeletal Quad encoding part of the code does not belong to me. It can be found at https://team.inria.fr/perception/research/skeletalquads/#Code.

The entire procedure can be divided into the following steps:
1) Quads are extracted from all files of the training set, and used to generate a Gaussian Mixture Model.

2) Fisher vectors are generated from the training data, based on the generated GMM, and used to train an SVM classifier. Six FVs are used to represent each action sequence, as explained in [1].

3) Similarly, FVs are generated for each action in the testing data, and tested on the classifier trained above.

To run the system, begin by running the ReadFile script which generates the GMM and stores its parameters as global variables. Then, training action sequences are passed to the ComputeFisherVector function, which returns 6 FVs for each action sequence passed to it. The FVs obtained are passed to the Train_SVM function in the next step, along with their labels. This function returns the parameters of the trained SVM model. This model, along with the testing action sequences, are passed to the TestAction function, which returns the predicted labels.

At the moment, the system is in prototype stage.


[1] G. Evangelidis, G. Singh, R. Horaud, "Skeletal Quads: Human action 
recognition using joint quadruples", ICPR, 2014.


[2] G. Evangelidis, G. Singh, R. Horaud, "Continuous Gesture Recognition 
from articulated Poses", ChalearnLAP2014 Workshop, ECCV, 2014.
