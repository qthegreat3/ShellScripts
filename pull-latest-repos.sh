
git -C ./aardvark-poms checkout master
git -C ./aardvark-poms pull

git -C ./aardvark-base checkout dev
git -C ./aardvark-base pull

git -C ./aardvark-apps checkout dev
git -C ./aardvark-apps pull

git -C ./asae-base checkout dev
git -C ./asae-base pull

git -C ./asae-apps checkout dev
git -C ./asae-apps pull
