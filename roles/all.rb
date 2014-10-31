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
    "plugins" => {
      "karmi/elasticsearch-paramedic" => {
        "url" => "https://github.com/karmi/elasticsearch-paramedic/archive/master.zip"
      },
      "marvel" => {
        "url" => "http://download.elasticsearch.org/elasticsearch/marvel/marvel-latest.zip"
      },
      "kibana" => {
        "url" => "https://download.elasticsearch.org/kibana/kibana/kibana-4.0.0-BETA1.1.zip"
      }
    }
  }
)
