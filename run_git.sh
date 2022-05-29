#!/bin/bash


commit_and_push(){
        echo "    3[ = ] ====>>  Inner 'commit_and_push'";
        git add .
        read -p 'Commit comment: ' comment
        git commit -m "$comment"
        git push -q
        echo "    3[ = ] ====>>  Pushed";
}

stash_commit(){
    git stash -q
    echo "    3[ = ] ====>>  Stashed";
    git pull -q
    git stash apply -q
    echo "    3[ = ] ====>>  Stash applied";
    commit_and_push
}

compare_and_commit(){
    rem="$(git log --remotes -1 --format=%ct )"
    loc="$(git log -1 --format=%ct )"
    if [ $rem -gt $loc ];
        then
            if [ -z "$(git status -s)" ];
            then
                echo "    1[ > ] pull commit push"
                commit_and_push
            else
                echo "    2[ > ] stash pull commit push"
                stash_commit
            fi
    elif [ $rem -eq $loc ];
        then
            if [ -z "$(git status -s)" ];
                then
                    echo "    3[ = ] ==========>>  PULL !!!!!!!!!!!!!!!!!!!!!! ";
                    return

            else
                echo "    4[ = ] commit_and_push"
                stash_commit
            fi
    else
        echo "    5[ < ] push";
        commit_and_push
    fi
    return
}



compare_and_commit