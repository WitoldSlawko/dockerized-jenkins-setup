import jenkins.model.*

println "--> setting location configuration"

jlc = JenkinsLocationConfiguration.get()

String ec2_public_ip = "curl http://169.254.169.254/latest/meta-data/public-ipv4".execute().text
String port = "8080"

jlc.setUrl("http://" + ec2_public_ip + ":" + port) 

jlc.save() 