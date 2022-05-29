#!/bin/bash


commit_and_push(){
        git status
        git add .
        git status
        read -p 'Commit comment: ' comment
        git commit -m "$comment"
        git push
}

stash_commit(){
    git stash
    git pull
    git stash apply
    commit_and_push
}

compare_and_commit(){
    rem="$(git log --remotes -1 --format=%ct )"
    loc="$(git log -1 --format=%ct )"
    if [ $rem -gt $loc ];
        then
            if [ -z "$(git status -s)" ];
            then
                echo "1[ > ] pull commit push"
                commit_and_push
            else
                echo "2[ > ] stash pull commit push"
                stash_commit
            fi
    elif [ $rem -eq $loc ];
        then
            if [ -z "$(git status -s)" ];
                then
                    echo "3[ = ] ==========>>  PULL !!!!!!!!!!!!!!!!!!!!!!";
                    return

            else
                echo "4[ = ] commit_and_push"
                stash_commit
            fi
    else
        echo "5[ < ] push";
        commit_and_push
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
        compare_and_commit
    fi

}

compare_and_commit