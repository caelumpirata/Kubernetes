# Git Workflow


### Initial setup [initial setup](#1-create-a-new-branch-to-work-with)
### 1.  Git clone your repo to your local machine.
   <img width="330" alt="image" src="https://github.com/caelumpirata/Kubernetes/assets/85424262/f4183aa3-985a-44c5-9462-f2c67fb5b007">
   
   ```
    git clone https://github.com/<username>/<repo_name>.git
   ```

### 2. enter your repo directory

  ```
  cd repo_name
  ```
currently you are in `main` branch

<img width="295" alt="image" src="https://github.com/caelumpirata/Kubernetes/assets/85424262/3588e8d8-da3b-4fc5-aeb8-17db55b1fc8f">


### 3. create a new branch to work with

  Basically `main` branch codes are used in production, that's why we will create new branch to do changes from our side.
   
   this will clone all your content of your `main` branch to `new` branch.
   
    
    git branch new_branch_name

    git checkout new_branch_name
    


### 4 . update  image `tag` name in `.gitlab-ci.yml` file
  ```
  nano .gitlab-ci.yml
  ```
change the tag name as today's date or whatever name you want to give.

eg. `caelumpirata/my_image:march_30`

  ```
image: docker:20.10.16
services:
  - docker:20.10.8-dind


variables:
    DOCKER_HOST: tcp://docker:2375
    DOCKER_DRIVER: overlay
    APP_IMAGE: <USERNAME/IMAGE_NAME>:<TAG> 

  ```

save the changes using  `ctrl + x` and then press `y` to save, then press  `enter`.

### 5 . Put your updated files which you want to upload in this directory (just copy and paste).
### 6. after your files are copied, then run these commands
   ```
   git add .
   ```
   ```
   git commit -m "enter your desired comment for future reference"
   ```
   ```
   git push origin branch_name
   ```


## for those who have already setup their local env

>> make sure to run command `git pull origin main` before you make changes in local and push your local changes to git.
>> 
>> why??
>> 
>> answer is to make your local code match with the `main` brach in the git,
>>
>>  your another colleagues might have made some changes while working in same project while you were away !
>> 
>>  and this is mandatory step for smooth workflow
