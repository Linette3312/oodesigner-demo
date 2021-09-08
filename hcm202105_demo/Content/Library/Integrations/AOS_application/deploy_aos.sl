namespace: Integrations.AOS_application
flow:
  name: deploy_aos
  inputs:
    - target_host: 172.16.239.122
    - target_host_username: root
    - target_host_password:
        default: Cloud_1234
        sensitive: true
  workflow:
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_java:
        do:
          Integrations.demo.aos.software.install_java:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos_application
    - install_aos_application:
        do:
          Integrations.demo.aos.application.install_aos_application:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_postgres:
        x: 150
        'y': 77
      install_java:
        x: 293
        'y': 78
      install_tomcat:
        x: 433
        'y': 78
      install_aos_application:
        x: 568
        'y': 74
        navigate:
          679bbbc1-381c-f650-46f3-5a5b60e0752e:
            targetId: bed7bb07-b0d3-f709-4036-bb65c592f859
            port: SUCCESS
    results:
      SUCCESS:
        bed7bb07-b0d3-f709-4036-bb65c592f859:
          x: 731
          'y': 82
