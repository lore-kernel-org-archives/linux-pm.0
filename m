From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [RFC v0 0/2] Introduce on-chip interconnect API
Date: Wed,  1 Mar 2017 20:22:33 +0200
Message-ID: <20170301182235.19154-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org, rjw@rjwysocki.net, robh+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, vincent.guittot@linaro.org, seansw@qti.qualcomm.com, gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, davidai@quicinc.com, skannan@codeaurora.org, khilman@baylibre.com, andy.gross@linaro.org, georgi.djakov@linaro.org, linux-arm-kernel@lists.infradead.org
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
the interconnect controllers and the consumers could be various drivers.
The consumers request interconnect resources (path) to an endpoint and set
the desired constraints on this data flow path. The provider(s) receive
requests from consumers and aggregate these requests for all master-slave
pairs on that path. Then the providers configure each participating in the
topology node according to the requested data flow path, physical links and
constraints. The topology could be complicated and multi-tiered and is SoC
specific.

Below is a simplified diagram of a real-world SoC topology. The interconnect
providers are the memory front-end and the NoCs.

+----------------+    +----------------+
| HW Accelerator |--->|      M NoC     |<---------------+
+----------------+    +----------------+                |
                        |      |                    +------------+
          +-------------+      V       +------+     |            |
          |                +--------+  | PCIe |     |            |
          |                | Slaves |  +------+     |            |
          |                +--------+     |         |   C NoC    |
          V                               V         |            |
+------------------+   +------------------------+   |            |   +-----+
|                  |-->|                        |-->|            |-->| CPU |
|                  |-->|                        |<--|            |   +-----+
|      Memory      |   |         S NoC          |   +------------+
|                  |<--|                        |---------+    |
|                  |<--|                        |<------+ |    |   +--------+
+------------------+   +------------------------+       | |    +-->| Slaves |
   ^     ^    ^           ^                             | |        +--------+
   |     |    |           |                             | V
+-----+  |  +-----+    +-----+  +---------+   +----------------+   +--------+
| CPU |  |  | GPU |    | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
+-----+  |  +-----+    +-----+  +---------+   +----------------+   +--------+
         |
     +-------+
     | Modem |
     +-------+

This RFC does not implement all features but only main skeleton to check the
validity of the proposal. Currently it only works with device-tree and platform
devices.

TODO:
 * Constraints are currently stored in internal data structure. Should PM QoS
 be used instead?
 * Rework the framework to not depend on DT as frameworks cannot be tied
 directly to firmware interfaces. Add support for ACPI?
 * Currently the interconnect_set() use one bandwidth integer value as parameter
 but this might be extended to support a list of parameters and other QoS values.
 * Add support for more than one endpoint per consumer.
 * Cache the path between the nodes instead of walking the graph on each get().
 * Sync interconnect requests with the idle state of the device.
 * Use integers for interconnect ids instead of strings.


Summary of the patches:
Patch 1 introduces the interconnect API.
Patch 2 creates the first vendor specific interconnect controller driver.


Georgi Djakov (2):
  interconnect: Add generic interconnect controller API
  interconnect: Add Qualcomm msm8916 interconnect provider driver

 .../bindings/interconnect/interconnect.txt         |  91 ++++
 Documentation/interconnect/interconnect.txt        |  68 +++
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/interconnect/Kconfig                       |  11 +
 drivers/interconnect/Makefile                      |   3 +
 drivers/interconnect/interconnect.c                | 285 +++++++++++++
 drivers/interconnect/qcom/Kconfig                  |  11 +
 drivers/interconnect/qcom/Makefile                 |   2 +
 drivers/interconnect/qcom/interconnect_msm8916.c   | 473 +++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,msm8916.h    |  87 ++++
 include/linux/interconnect-consumer.h              |  70 +++
 include/linux/interconnect-provider.h              |  92 ++++
 13 files changed, 1196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
 create mode 100644 Documentation/interconnect/interconnect.txt
 create mode 100644 drivers/interconnect/Kconfig
 create mode 100644 drivers/interconnect/Makefile
 create mode 100644 drivers/interconnect/interconnect.c
 create mode 100644 drivers/interconnect/qcom/Kconfig
 create mode 100644 drivers/interconnect/qcom/Makefile
 create mode 100644 drivers/interconnect/qcom/interconnect_msm8916.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8916.h
 create mode 100644 include/linux/interconnect-consumer.h
 create mode 100644 include/linux/interconnect-provider.h
