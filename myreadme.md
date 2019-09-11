# Commands
    ### Build Staging
    docker build --build-arg CONFIG=staging -t msuzoagu/portfolio_ddw .
    docker tag msuzoagu/portfolio_ddw:latest msuzoagu/portfolio_ddw:staging
    docker push msuzoagu/portfolio_ddw:staging

    ### Build Production
    docker build --build-arg CONFIG=master -t msuzoagu/portfolio_ddw .
    docker tag msuzoagu/portfolio_ddw:latest msuzoagu/portfolio_ddw:master
    docker push msuzoagu/portfolio_ddw:master
