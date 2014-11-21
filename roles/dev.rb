default_attributes(
  "java" => {
    "install_flavor" => "oracle",
    "jdk_version" => "7",
    "oracle" => {
      "accept_oracle_download_terms" => true
    },
    "accept_license_agreement" => true
  },
  "elasticsearch" => {
    "version" => "1.4.0.Beta1",
    "cluster" => {
      "name" => "elastic391"
    }
  },
  "kibana" => {
    "version" => 3
  }
)
