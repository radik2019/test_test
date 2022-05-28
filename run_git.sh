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




# else
#     echo "nothing to commit"
# fi



rem="$(git log --remotes -1 --format=%ct )"
loc="$(git log -1 --format=%ct )"  


# SE LA DATA DELL'ultimo commit remoto e` piu` grande di quello locale


push_commit(){
    if [ $rem -ge $loc ];
    then
        echo ""
        echo ""
        echo ""
        echo ""
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

push_commit

