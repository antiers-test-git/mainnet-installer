#!/bin/bash
if [ "$(id -u)" != "0" ]; then  
   echo "This script must be run as root or with sudo cmd" 1>&2  
   exit 1  
   else
   URS=$(echo $HOME)
    installcmd() {
        
        if ! which git > /dev/null 2>&1; then
        cd $URS
        brew update -y && brew install git -y
        fi

URS=$(echo $HOME)
cd $URS
        if [ ! -d $URS/Mainnet-binary ]
            then
                git clone https://github.com/PEER-Inc/Mainnet-binary.git
 		cd  $URS/Mainnet-binary 
		git checkout mac_binary
        fi 

        if [ ! -d $URS/.peer_mainnet ]
            then
                mkdir $URS/.peer_mainnet
                cd $URS/Mainnet-binary
                cp  customSpecRaw.json $URS/.peer_mainnet/customSpecRaw.json
                chmod +x peer
                 if [ -d /usr/local/bin/ ]
       	        then
                    cp peer /usr/local/bin/
                else
                    mkdir -p /usr/local/bin/
                    cp peer /usr/local/bin/
                fi
            else
		echo $PWD
                    if [ ! -f $URS/.peer_mainnet/customSpecRaw.json ]
                        then
                            cd $URS/Mainnet-binary
                            mv  customSpecRaw.json $URS/.peer_mainnet/customSpecRaw.json
                            chmod +x peer
                            if [ -d /usr/local/bin/ ]
       	                        then
                                    cp peer /usr/local/bin/
                            else
                                    mkdir -p /usr/local/bin/
                                    cp peer /usr/local/bin/
                            fi
                            
                    fi      
        fi
 }
 
peercmd(){
    if [ -x /usr/bin/peer ]
       	        then
       	        cd $URS/                
                cd $URS/Mainnet-binary
                chmod +x peer
                if [ -d /usr/local/bin/ ]
       	        then
                    cp peer /usr/local/bin/
                else
                    mkdir -p /usr/local/bin/
                    cp peer /usr/local/bin/
                echo "peer is ready to run"
            else
                cd $URS/                
                cd $URS/Mainnet-binary
                chmod +x peer
                if [ -d /usr/local/bin/ ]
       	        then
                    cp peer /usr/local/bin/
                else
                    mkdir -p /usr/local/bin/
                    cp peer /usr/local/bin/
                fi
     fi
    
}
    checkdir(){
       mkdir /data
        }

    listdir(){
        cd /opt
        for i in $(find /opt -name chains -type d |cut -f3 -d '/'); do echo "Last Dir. \n ${i}" ; done
       # find /opt -name chains -type d |cut -f3 -d '/'
}

    peerconnect(){
        while [ -z $x ]
            do
                echo "Enter Your Node Name: "
                read x

            if [ -z "$x" ]
            then
                 echo "Please enter your node name it can't be null"
            fi
            done
        num=$(( $RANDOM % 5 + 1 ))
case $num in
	1)
	peer --base-path /opt/"${x}" --chain $URS/.peer_mainnet/customSpecRaw.json --port 30333 --ws-external --rpc-external --rpc-cors all --no-telemetry --validator --rpc-methods Unsafe --name "${x}" --bootnodes /ip4/52.202.60.27/tcp/30333/p2p/12D3KooWJSTcGcgqnWnkPHgp734ckfKaHJ1R8eidCv2MJdqjkUnz	
		;;
	2)
	peer --base-path /opt/"${x}" --chain $URS/.peer_mainnet/customSpecRaw.json --port 30333 --ws-external --rpc-external --rpc-cors all --no-telemetry --validator --rpc-methods Unsafe --name "${x}" --bootnodes /ip4/54.151.75.198/tcp/30333/p2p/12D3KooWT2YpBQpowttM27qn1rDNqfFxZse18hQrE4PF97nFah6C
		;;
	3)
	peer --base-path /opt/"${x}" --chain $URS/.peer_mainnet/customSpecRaw.json --port 30333 --ws-external --rpc-external --rpc-cors all --no-telemetry --validator --rpc-methods Unsafe  --name "${x}" --bootnodes /ip4/13.71.104.102/tcp/30333/p2p/12D3KooWP7Vp8KCDQd55Jk86fagtSp58cBZbnk8BNrH4fmi2Qaj4
		;;
	4)
	peer --base-path /opt/"${x}" --chain $URS/.peer_mainnet/customSpecRaw.json  --port 30333 --ws-external --rpc-external --rpc-cors all --no-telemetry --validator --rpc-methods Unsafe --name "${x}" --bootnodes /ip4/20.98.202.26/tcp/30333/p2p/12D3KooWEVSQiY9WNzTzXjgx2SAA8XjsFt4TCyfLNxKcTsuL4wFD
		;;
	5)
	peer --base-path /opt/"${x}" --chain $URS/.peer_mainnet/customSpecRaw.json --port 30333 --ws-external --rpc-external --rpc-cors all --no-telemetry --validator --rpc-methods Unsafe --name "${x}" --bootnodes /ip4/34.89.242.29/tcp/30333/p2p/12D3KooWAS3YCVXWkUXR2EbogeW8qo7DAbMtYPJdRGbGCeeMyVtM
		;;
esac
}

dir=/opt

    if [ ! -d  $dir ]
        then
	        checkdir
            if [ -x /usr/local/bin/peer ]
       	        then
                echo "peer is ready to run"
            else
                installcmd
                peercmd
            fi
                peerconnect 
                exit 1 
    else
            #installcmd	
            if [ -x /usr/local/bin/peer ]
       	        then
                echo "peer is ready to run"
            else
                installcmd
                peercmd
            fi
            peercmd
            listdir
            peerconnect 
            exit 1        
    fi
 fi

