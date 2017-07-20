From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v2 0/2] Introduce on-chip interconnect API
Date: Thu, 20 Jul 2017 22:52:48 +0300
Message-ID: <20170720195250.13462-1-georgi.djakov@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, khilman@baylibre.com, mturquette@baylibre.com, gregkh@linuxfoundation.org, vincent.guittot@linaro.org, skannan@codeaurora.org, sboyd@codeaurora.org, andy.gross@linaro.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, seansw@qti.qualcomm.com, davidai@quicinc.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

Modern SoCs have multiple processors and various dedicated cores (video, gpu,
graphics, modem). These cores are talking to each other and can generate a lot
of data flowing through the on-chip interconnects. These interconnect buses
could form different topologies such as crossbar, point to point buses,
hierarchical buses or use the network-on-chip concept.

These buses have been sized usually to handle use cases with high data
throughput but it is not necessary all the time and consume a lot of power.
Furthermore, the priority between masters can vary depending on the running
use case like video playback or cpu intensive tasks.

Having an API to control the requirement of the system in term of bandwidth
and QoS, so we can adapt the interconnect configuration to match those by
scaling the frequencies, setting link priority and tuning QoS parameters.
This configuration can be a static, one-time operation done at boot for some
platforms or a dynamic set of operations that happen at run-time.

This patchset introduce a new API to get the requirement and configure the
interconnect buses across the entire chipset to fit with the current demand.
The API is NOT for changing the performance of the endpoint devices, but only
the interconnect path in between them.

The API is using a consumer/provider-based model, where the providers are
the interconnect buses and the consumers could be various drivers.
The consumers request interconnect resources (path) to an endpoint and set
the desired constraints on this data flow path. The provider(s) receive
requests from consumers and aggregate these requests for all master-slave
pairs on that path. Then the providers configure each participating in the
topology node according to the requested data flow path, physical links and
constraints. The topology could be complicated and multi-tiered and is SoC
specific.

Below is a simplified diagram of a real-world SoC topology. The interconnect
providers are the NoCs.

 +----------------+    +----------------+
 | HW Accelerator |--->|      M NoC     |<---------------+
 +----------------+    +----------------+                |
                         |      |                    +------------+
  +-----+  +-------------+      V       +------+     |            |
  | DDR |  |                +--------+  | PCIe |     |            |
  +-----+  |                | Slaves |  +------+     |            |
    ^ ^    |                +--------+     |         |   C NoC    |
    | |    V                               V         |            |
 +------------------+   +------------------------+   |            |   +-----+
 |                  |-->|                        |-->|            |-->| CPU |
 |                  |-->|                        |<--|            |   +-----+
 |     Mem NoC      |   |         S NoC          |   +------------+
 |                  |<--|                        |---------+    |
 |                  |<--|                        |<------+ |    |   +--------+
 +------------------+   +------------------------+       | |    +-->| Slaves |
   ^  ^    ^    ^          ^                             | |        +--------+
   |  |    |    |          |                             | V
 +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
 | CPUs |  |  | GPU |   | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
 +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
           |
       +-------+                                                                                                                                                          
       | Modem |
       +-------+

This patchset does not implement all features but only main skeleton to check
the validity of the proposal.

TODO:
 * Constraints are currently stored in internal data structure. Should PM QoS
 be used instead?
 * Extend interconect_set() to handle parameters such as latency and other QoS
   values.
 * Cache the path between the nodes instead of walking the graph on each get().
 * Sync interconnect requests with the idle state of the device.
 * Replace dev_id string names resource lookups with integer ids.

Summary of the patches:
Patch 1 introduces the interconnect API.
Patch 2 creates the first vendor specific interconnect bus driver.

Changes since patchset v1 (https://lkml.org/lkml/2017/6/27/890)
* Updates in the documentation.
* Changes in request aggregation, locking.
* Dropped the aggregate() callback and use the default as it currently
  sufficient for the single vendor driver. Will add it later when needed.
* Dropped the dt-bindings draft patch for now.

Changes since RFC v2 (https://lkml.org/lkml/2017/6/12/316)
* Converted documentation to rst format.
* Fixed an incorrect call to mutex_lock. Renamed max_bw to peak_bw.

Changes since RFC v1 (https://lkml.org/lkml/2017/5/15/605)
* Refactored code into shorter functions.
* Added a new aggregate() API function.
* Rearranged some structs to reduce padding bytes.

Changes since RFC v0 (https://lkml.org/lkml/2017/3/1/599)
* Removed DT support and added optional Patch 3 with new bindings proposal.
* Converted the topology into internal driver data.
* Made the framework modular.
* interconnect_get() now takes (src and dst ports as arguments).
* Removed public declarations of some structs.
* Now passing prev/next nodes to the vendor driver.
* Properly remove requests on _put().
* Added refcounting.
* Updated documentation.
* Changed struct interconnect_path to use array instead of linked list.


Georgi Djakov (2):
  interconnect: Add generic on-chip interconnect API
  interconnect: Add Qualcomm msm8916 interconnect provider driver

 Documentation/interconnect/interconnect.rst      |  93 ++++++
 drivers/Kconfig                                  |   2 +
 drivers/Makefile                                 |   1 +
 drivers/interconnect/Kconfig                     |  15 +
 drivers/interconnect/Makefile                    |   2 +
 drivers/interconnect/interconnect.c              | 389 ++++++++++++++++++++++
 drivers/interconnect/qcom/Kconfig                |  12 +
 drivers/interconnect/qcom/Makefile               |   2 +
 drivers/interconnect/qcom/interconnect_msm8916.c | 390 +++++++++++++++++++++++
 include/linux/interconnect-consumer.h            |  72 +++++
 include/linux/interconnect-provider.h            | 117 +++++++
 include/linux/interconnect/qcom-noc.h            |  92 ++++++
 12 files changed, 1187 insertions(+)
 create mode 100644 Documentation/interconnect/interconnect.rst
 create mode 100644 drivers/interconnect/Kconfig
 create mode 100644 drivers/interconnect/Makefile
 create mode 100644 drivers/interconnect/interconnect.c
 create mode 100644 drivers/interconnect/qcom/Kconfig
 create mode 100644 drivers/interconnect/qcom/Makefile
 create mode 100644 drivers/interconnect/qcom/interconnect_msm8916.c
 create mode 100644 include/linux/interconnect-consumer.h
 create mode 100644 include/linux/interconnect-provider.h
 create mode 100644 include/linux/interconnect/qcom-noc.h
