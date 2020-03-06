FROM openshift/origin-base
COPY --from=builder /go/src/github.com/openshift-psap/special-resource-operator/special-resource-operator /usr/bin/
RUN yum update --disablerepo=* --enablerepo=ubi-8-appstream --enablerepo=ubi-8-baseos -y && rm -rf /var/cache/yum
RUN yum install --disablerepo=* --enablerepo=ubi-8-appstream --enablerepo=ubi-8-baseos httpd -y && rm -rf /var/cache/yum
RUN mkdir -p /etc/kubernetes/special-resource/nvidia-gpu
COPY assets/ /etc/kubernetes/special-resource/nvidia-gpu

RUN useradd special-resource-operator
USER special-resource-operator
ENTRYPOINT ["/usr/bin/special-resource-operator"]
LABEL io.k8s.display-name="OpenShift Special Resource Operator" \
      io.k8s.description="This is a component of OpenShift and manages special resources." \
      io.openshift.release.operator=true
