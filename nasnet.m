r=exist("NASNET_TRAIN_DATA","dir");
if r~=7
    unzip("train","NASNET_TRAIN_DATA");
end





%-------
data=imageDatastore("NASNET_TRAIN_DATA","IncludeSubfolders",true,"LabelSource","foldernames");
[trainImgs,testImgs] = splitEachLabel(data,0.7);
net=nasnetlarge;
class_num_data=numel(categories(trainImgs.Labels));
full_repleace=fullyConnectedLayer(class_num_data,"Name","replace_fulcon_layer");
out_repleace = classificationLayer("Name","repleace_out_layer");

layer_Graph=layerGraph(net);
be_replace_fullayer_name=net.Layers(1241).Name;
be_replace_outlayer_name=net.Layers(1243).Name;


layer_Graph=replaceLayer(layer_Graph,be_replace_fullayer_name,full_repleace);
layer_Graph=replaceLayer(layer_Graph,be_replace_outlayer_name,out_repleace);

%analyzeNetwork(layer_Graph);
r_s=[0.5 4];
rr=[-45 45];
xt=[-5 5];
rs=[0 45];

image_au=imageDataAugmenter("RandXReflection",true,"RandXTranslation",xt,"RandRotation",rr,"RandScale",r_s,"RandYTranslation",xt,"RandYReflection",true,"RandYShear",rs,"RandXShear",rs);

au_img_train=augmentedImageDatastore([331,331],trainImgs,"DataAugmentation",image_au);
img_test=augmentedImageDatastore([331,331],testImgs);

options=trainingOptions("sgdm",MiniBatchSize=8,InitialLearnRate=0.005,ValidationData=img_test,Shuffle="every-epoch",Plots="training-progress",MaxEpochs=30,LearnRateSchedule="piecewise",ValidationFrequency=10,OutputNetwork="best-validation-loss");
[trained_net,trained_info]=trainNetwork(au_img_train,layer_Graph,options);

save("nasnet.mat","trained_net","trained_info");


close all hidden;








