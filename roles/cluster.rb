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
    },
    "path" => {
      "data" => "/data/elasticsearch"
    },
    "discovery" => {
      "type" => "zen",
      "zen" => {
        "ping" => {
          "unicast" => {
            "hosts" => [
              "10.1.0.247:9300", "10.1.0.249:9300", "10.1.1.41:9300", "10.1.1.44:9300"
            ]
          },
          "multicast" => {
            "enabled" => false
          }
        }
      }
    }
  },
  "kibana" => {
    "es_server" => "10.1.0.247"
  }
)
