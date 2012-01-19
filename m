From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: [PATCH v3 2/3] PM QoS: Add CPU frequency minimum as PM QoS param
Date: Thu, 19 Jan 2012 14:34:51 +0200
Message-ID: <1326976492-3970-3-git-send-email-amiettinen@nvidia.com>
References: <1326976492-3970-1-git-send-email-amiettinen@nvidia.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1326976492-3970-1-git-send-email-amiettinen@nvidia.com>
Sender: cpufreq-owner@vger.kernel.org
To: davej@redhat.com, pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, khilman@ti.com, j-pihet@ti.com, markgross@thegnar.org, cpufreq@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Add minimum CPU frequency as PM QoS parameter.

Signed-off-by: Antti P Miettinen <amiettinen@nvidia.com>
---
 include/linux/pm_qos.h |    3 +++
 kernel/power/qos.c     |   17 ++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 5ac91d8..54a0d00 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -14,8 +14,10 @@ enum {
 	PM_QOS_CPU_DMA_LATENCY,
 	PM_QOS_NETWORK_LATENCY,
 	PM_QOS_NETWORK_THROUGHPUT,
+	PM_QOS_CPU_FREQ_MIN,
 
 	/* insert new class ID */
+
 	PM_QOS_NUM_CLASSES,
 };
 
@@ -25,6 +27,7 @@ enum {
 #define PM_QOS_NETWORK_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
 #define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE	0
 #define PM_QOS_DEV_LAT_DEFAULT_VALUE		0
+#define PM_QOS_CPU_FREQ_MIN_DEFAULT_VALUE	0
 
 struct pm_qos_request {
 	struct plist_node node;
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index d6d6dbd..07d761a 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -101,11 +101,26 @@ static struct pm_qos_object network_throughput_pm_qos = {
 };
 
 
+static BLOCKING_NOTIFIER_HEAD(cpu_freq_min_notifier);
+static struct pm_qos_constraints cpu_freq_min_constraints = {
+	.list = PLIST_HEAD_INIT(cpu_freq_min_constraints.list),
+	.target_value = PM_QOS_CPU_FREQ_MIN_DEFAULT_VALUE,
+	.default_value = PM_QOS_CPU_FREQ_MIN_DEFAULT_VALUE,
+	.type = PM_QOS_MAX,
+	.notifiers = &cpu_freq_min_notifier,
+};
+static struct pm_qos_object cpu_freq_min_pm_qos = {
+	.constraints = &cpu_freq_min_constraints,
+	.name = "cpu_freq_min",
+};
+
+
 static struct pm_qos_object *pm_qos_array[] = {
 	&null_pm_qos,
 	&cpu_dma_pm_qos,
 	&network_lat_pm_qos,
-	&network_throughput_pm_qos
+	&network_throughput_pm_qos,
+	&cpu_freq_min_pm_qos,
 };
 
 static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
-- 
1.7.4.1

