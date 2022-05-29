#!/bin/bash


commit_and_push(){
        echo "      cap[ f ] => Inner 'commit_and_push'";
        git add .
        read -p "        Commit comment: " comment
        git commit -q -m "$comment"
        git push -q
        echo "      cap[ f ] => Pushed";
}

stash_commit(){
    git stash -q
    echo "      sc [ f ] => Stashed";
    git pull -q
    git stash apply -q
    echo "      sc [ f ] => Stash applied";
    commit_and_push
}

compare_and_commit(){
    rem="$(git log --remotes -1 --format=%ct )"
    loc="$(git log -1 --format=%ct )"
    if [ $rem -gt $loc ];
        then
            if [ -z "$(git status -s)" ];
            then
                echo "    1[ > ] => Call commit_and_push"
                commit_and_push
            else
                echo "    2[ > ] => Call stash_commit"
                stash_commit
            fi
    elif [ $rem -eq $loc ];
        then
            if [ -z "$(git status -s)" ];
                then
                    echo "    3[ = ] => Pull ";
                    git pull -q
                    return

            else
                echo "    4[ = ] => Call stash_commit"
                stash_commit
            fi
    else
        echo "    5[ < ] => Call commit_and_push";
        commit_and_push
    fi
    return
}



compare_and_commit