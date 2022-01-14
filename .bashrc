alias htop='docker run --rm -it --pid=host tehbilly/htop'

export BASH_SILENCE_DEPRECATION_WARNING=1

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export JAVA_HOME=/Library/Java/Home
export HADOOP_HOME=/usr/local/Cellar/hadoop/2.7.3/libexec
export ANDROID_HOME=/Volumes/Transcend/Experiment/android/tools

export YARN_PATH=$HOME/.yarn/bin
export CONDA_PATH=$HOME/anaconda/bin
export ITERM2_PATH=$HOME/Home/scripts/iTerm2
export OW_PATH=$HOME/Environment/OpenWhisk/bin

# Tensorflow
#export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:/usr/local/cuda/extras/CUPTI/lib:$DYLD_LIBRARY_PATH
#export LD_LIBRARY_PATH=$DYLD_LIBRARY_PATH
#export PATH=$DYLD_LIBRARY_PATH:/usr/local/cude/bin:$PATH

PATH=$PATH:/usr/local/bin:/usr/local/sbin:/Users/tangrui/Environment/webp:/Users/tangrui/go/bin:/Users/tangrui/Environment/dotnet-sdk-2.2.402:/Users/tangrui/Library/Python/3.7/bin

export PATH=$PATH:$YARN_PATH:$CONDA_PATH:$ITERM2_PATH:$OW_PATH
