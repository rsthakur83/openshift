node {
   
   	stage 'Stage 1'
   		echo 'Hello Deploying Docker App'
   	stage 'Checkout'
   		git url: 'https://github.com/rsthakur83/terraform-orchstration-'
      stage 'Execute'
         sh 'chmod +x docker.sh'
      stage 'Deploy'
         sh './docker.sh'
      stage 'app release'
         sh 'release=cat app_version'
      stage 'show app release '
         sh 'echo $release'
   
 }
