node {
   
   	stage 'Stage 1'
   		echo 'Hello Deploying Docker App'
   	stage 'Checkout'
   		git url: 'https://github.com/rsthakur83/openshift'
      stage 'app release'
         sh 'export "release=`cat release`"'
      stage 'show app release '
         sh 'echo $release'
      stage 'Supply app version'
         sh 'echo "git clone --depth 1 --branch $release git://github.com/rsthakur83/release.git" >> userdata.sh'
      stage 'Web Directory'
         sh 'echo "mv release/* /var/www/html" >> userdata.sh'
   
 }
