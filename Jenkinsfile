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
         sh 'export release=`cat docker.yaml |grep app_version|awk '{print $2}'|head -1`'
      stage 'Supply app version'
         sh 'echo "git clone --depth 1 --branch $release git://github.com/rsthakur83/release.git" >> userdata.sh'
      stage 'Web Directory'
         sh  'echo "rm -rf /usr/share/httpd/noindex/index.html" >> userdata.sh'
         sh  'echo "mv release/* /usr/share/httpd/noindex" >> userdata.sh'

   
      stage 'Terraform Plan'
         sh 'sudo terraform plan'
      stage ' Creating Green Prod Env'
         sh  'sudo terraform apply'
   
      stage 'Changing Env'
         sh 'chmod +x scaling.sh'
      stage 'Swaping Blue with Green'
         sh './scaling.sh'
   
 }
