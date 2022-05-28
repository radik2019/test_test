#!/bin/bash
# Ask the user for login details
# loc="$(git log --remotes -1)"
# rem="$(git -1)"

# remote="$(git log --remotes -1 --format=%cd )"
# locale="$(git log -1 --format=%cd )"  

# if $rem -eq $loc 
# then echo "-------------------------------\n"

#     git status
#     git add .
#     git status
#     read -p 'Commit comment: ' comment
#     git commit -m "$comment"
#     git push
#     echo "\n\n"
#     echo "Your commit has been pushed to GitHub"



# fffffff




# SE LA DATA DELL'ultimo commit remoto e` piu` grande di quello locale


push_commit(){

    rem="$(git log --remotes -1 --format=%ct )"
    loc="$(git log -1 --format=%ct )"  

    
    if [ $rem -le $loc ];
        then
        echo '---------------------------\n\n\n\n'

        git status
        git add .
        git status
        read -p 'Commit comment: ' comment
        git commit -m "$comment"
        git push
        echo "\n\n"
        echo "------------PUSH---------"

    else
        git pull
        echo "-----------PULL----------"
    fi
    return
}

check_status(){

    a=[ git status -s ]
    echo $a

    if [ -z "$(git status -s)" ];
        then
            echo "non si fa nulla";
            
    else
        echo "bisogna fare il push";
        push_commit
    fi

}

push_commit