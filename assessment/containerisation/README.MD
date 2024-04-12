# Containerations/Orchestration Challenge

## Pods 
Q. Create a single Pod named `pod1` in Namespace default of image `busybox:1.31.0`. The Pod should have a readiness-probe executing cat `/tmp/ready`. It should initially wait 5 and periodically wait 10 seconds. This will set the container ready only if the file `/tmp/ready` exists.

The Pod should run the command touch `/tmp/ready && sleep 1d`, which will create the necessary file to be ready and then idles. Create the Pod and confirm it starts. And, save the YAML under `/resources/k8s/pod1.yaml`.

## Secret-Volume
You need to make changes on an existing Pod in Namespace `moon` called `secret-handler`. Create a new Secret `secret1` which contains `user=test` and `pass=pwd`. The Secret's content should be available in Pod secret-handler as environment variables `SECRET1_USER` and `SECRET1_PASS`. The yaml for Pod secret-handler is available at `/resources/k8s/secret-handler.yaml`.

There is existing yaml for another Secret at `/resources/k8s/secret2.yaml`, create this Secret and mount it inside the same Pod at `/tmp/secret2`. Your changes should be saved under `/resources/k8s/secret-handler-new.yaml`. Both Secrets should only be available in Namespace moon.
