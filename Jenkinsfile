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
         sh 'echo release'
      stage 'Supply app version'
         sh 'chmod +x release;./release'
      stage 'Web Directory'
         sh  'echo "sudo cp -rf release/* /usr/share/httpd/noindex/" >> userdata.sh'
         sh  'echo "sudo cp -rf release/* /var/www/html/" >> userdata.sh'

   
      stage 'Terraform Plan'
         sh 'sudo terraform plan'
      stage ' Creating Green Prod Env'
         sh  'sudo terraform apply'
   
      stage ' Wait for Online Service'
         sh  'sleep 240'
   
      stage 'Changing Env'
         sh 'chmod +x scaling.sh'
      stage 'Swaping Blue with Green'
         sh './scaling.sh'
   
 }
