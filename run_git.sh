#!/bin/bash


commit_and_push(){
        echo "    3[ = ] ====>>  Inner 'commit_and_push'";
        git add .
        read -p 'Commit comment: ' comment
        git commit -m "$comment"
        git push
        echo "    3[ = ] ====>>  Pushed";
}

stash_commit(){
    git stash
    echo "    3[ = ] ====>>  Stashed";
    git pull
    git stash apply
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