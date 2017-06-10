node {
   
   	stage 'Stage 1'
   		echo 'Hello Deploying Docker App'
   	stage 'Checkout'
   		git url: 'https://github.com/rsthakur83/openshift'
   
      stage 'Execute'
         sh 'chmod +x docker.sh'
      stage 'Deploy in Test Env'
         sh './docker.sh'
 
      stage 'Deploy to Prod approval'
        input "Deploy to prod?"

      stage 'app release'
         sh 'release=`cat release`'
      stage 'Supply app version'
         sh 'release=`cat release`'
         sh 'echo "git clone --depth 1 --branch `cat release` git://github.com/rsthakur83/release.git" >> userdata.sh'
      stage 'Web Directory'
         sh 'echo "mv release/* /var/www/html" >> userdata.sh'
   
      stage 'Terraform Creating Green Prod Env'
         sh 'terraform apply'
   
 }
