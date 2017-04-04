# GHDL Jenkins swarm slave

[`tivalii/ghdl-jenkins-swarm-slave`](https://registry.hub.docker.com/u/tivalii/ghdl-jenkins-swarm-slave/)

A [Jenkins swarm](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin) slave with [GHDL](https://github.com/tgingold/ghdl) software.


GHDL is an open-source simulator for the VHDL language.

`ghdl-jenkins-swarm-slave` allows you to compile and execute VHDL code directly in docker container.
Can be used as a part of CI (Continuous Integration) infrastructure ([Gerrit + Jenkins](https://github.com/tivaliy/ci-infra)) for VHDL-like projects, e.g. VHDL code syntax checking job, unit testing job and so on.
For more information about GHDL see [https://github.com/tgingold/ghdl](https://github.com/tgingold/ghdl)

## Running

To run a Docker container passing [any parameters](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin#SwarmPlugin-AvailableOptions) to the slave

    docker run tivalii/ghdl-jenkins-swarm-slave -master http://jenkins:8080 -username jenkins -password jenkins -executors 1

## Building

    docker build -t tivalii/ghdl-jenkins-swarm-slave .

## Use-Cases

### Using VUnit framework with GHDL

[VUnit](http://vunit.github.io/) is an open source unit testing framework for VHDL/SystemVerilog.
It can be easily installed and used in `ghdl-jenkins-swarm-slave` to perform unit testing jobs of VHDL source code in Jenkins.

#### Create `vunit-vhdl-code-check` Job in Jenkins (out-of-the-box)

1. Configure `jenkins_jobs.ini` file (for more details please refer to [JJB configuration file](https://docs.openstack.org/infra/jenkins-job-builder/execution.html#configuration-file))
2. Configure `vunit-vhdl-code-check.yaml` file to meet your Jenkins configuration.
3. Run `create-job.sh` script

#### Create `vunit-vhdl-code-check` Job in Jenkins (manually)
Add the following code to `Build` &#8594; `Execute shell` section of newly created job in Jenkins:

```bash
    cat > run.py << EOF
    from vunit import VUnit

    vu = VUnit.from_argv()
    lib = vu.add_library("lib")
    lib.add_source_files("*.vhd")
    vu.main()

    EOF

    virtualenv vunit
    . vunit/bin/activate

    pip install vunit-hdl

    python run.py -v --no-color
```
