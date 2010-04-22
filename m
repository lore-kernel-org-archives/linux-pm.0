From: mark gross <mgross@linux.intel.com>
Subject: [patch] pm-qos update, adding new pos parrameter
Date: Thu, 22 Apr 2010 07:44:59 -0700
Message-ID: <20100422144459.GB22565@linux.intel.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

The following patch adds system_but_throughput as a pm-qos parrameter.
It will help with systems that can adjust clocks on busses.


Thanks,

--mgross



>From ea2aa93aa8705f5b3deb818efefcbad24351c333 Mon Sep 17 00:00:00 2001
From: mgross <mark.gross@gmail.com>
Date: Sat, 13 Mar 2010 13:07:20 -0800
Subject: [PATCH 2/2] PM_QOS adding system bus throughput to set of classes


Signed-off-by: markgross <mark.gross@intel.com>
---
 Documentation/power/pm_qos_interface.txt |    7 +++--
 include/linux/pm_qos_params.h            |    3 +-
 kernel/pm_qos_params.c                   |   31 ++++++++++++++++++++++++-----
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/Documentation/power/pm_qos_interface.txt b/Documentation/power/pm_qos_interface.txt
index 2138afb..d37db07 100644
--- a/Documentation/power/pm_qos_interface.txt
+++ b/Documentation/power/pm_qos_interface.txt
@@ -4,8 +4,8 @@ This interface provides a kernel and user mode interface for registering
 performance expectations by drivers, subsystems and user space applications on
 one of the parameters.
 
-Currently we have {cpu_dma_latency, network_latency, network_throughput} as the
-initial set of pm_qos parameters.
+Currently we have {cpu_dma_latency, network_latency, network_throughput,
+system_bus_throughput} as the initial set of pm_qos parameters.
 
 Each parameters have defined units:
  * latency: usec
@@ -49,7 +49,8 @@ cleanup for process the interface requires the process to register its
 parameter requests in the following way:
 
 To register the default pm_qos target for the specific parameter, the process
-must open one of /dev/[cpu_dma_latency, network_latency, network_throughput]
+must open one of /dev/[cpu_dma_latency, network_latency, network_throughput,
+system_bus_throughput]
 
 As long as the device node is held open that process has a registered
 request on the parameter.
diff --git a/include/linux/pm_qos_params.h b/include/linux/pm_qos_params.h
index 8ba440e..7459f3d 100644
--- a/include/linux/pm_qos_params.h
+++ b/include/linux/pm_qos_params.h
@@ -10,8 +10,9 @@
 #define PM_QOS_CPU_DMA_LATENCY 1
 #define PM_QOS_NETWORK_LATENCY 2
 #define PM_QOS_NETWORK_THROUGHPUT 3
+#define PM_QOS_SYSTEM_BUS_THROUGHPUT 4
 
-#define PM_QOS_NUM_CLASSES 4
+#define PM_QOS_NUM_CLASSES 5
 #define PM_QOS_DEFAULT_VALUE -1
 
 struct pm_qos_request_list;
diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
index a1aea04..66368b2 100644
--- a/kernel/pm_qos_params.c
+++ b/kernel/pm_qos_params.c
@@ -104,11 +104,23 @@ static struct pm_qos_object network_throughput_pm_qos = {
 };
 
 
-static struct pm_qos_object *pm_qos_array[] = {
-	&null_pm_qos,
-	&cpu_dma_pm_qos,
-	&network_lat_pm_qos,
-	&network_throughput_pm_qos
+static BLOCKING_NOTIFIER_HEAD(system_bus_throughput_notifier);
+static struct pm_qos_object system_bus_throughput_pm_qos = {
+	.requests = {LIST_HEAD_INIT(system_bus_throughput_pm_qos.requests.list)},
+	.notifiers = &system_bus_throughput_notifier,
+	.name = "system_bus_throughput",
+	.default_value = 0,
+	.target_value = ATOMIC_INIT(0),
+	.comparitor = max_compare
+};
+
+
+static struct pm_qos_object *pm_qos_array[PM_QOS_NUM_CLASSES] = {
+	[PM_QOS_RESERVED] = &null_pm_qos,
+	[PM_QOS_CPU_DMA_LATENCY] = &cpu_dma_pm_qos,
+	[PM_QOS_NETWORK_LATENCY] = &network_lat_pm_qos,
+	[PM_QOS_NETWORK_THROUGHPUT] = &network_throughput_pm_qos,
+	[PM_QOS_SYSTEM_BUS_THROUGHPUT] = &system_bus_throughput_pm_qos,
 };
 
 static DEFINE_SPINLOCK(pm_qos_lock);
@@ -401,9 +413,16 @@ static int __init pm_qos_power_init(void)
 		return ret;
 	}
 	ret = register_pm_qos_misc(&network_throughput_pm_qos);
-	if (ret < 0)
+	if (ret < 0) {
 		printk(KERN_ERR
 			"pm_qos_param: network_throughput setup failed\n");
+		return ret;
+	}
+	ret = register_pm_qos_misc(&system_bus_throughput_pm_qos);
+	if (ret < 0)
+		printk(KERN_ERR
+			"pm_qos_param: system_bus_throughput setup failed\n");
+
 
 	return ret;
 }
-- 
1.6.3.3
