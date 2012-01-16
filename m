From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: [PATCH v2 7/8] PM QoS: Add CPU frequency maximum as PM
	QoS param
Date: Mon, 16 Jan 2012 09:00:00 +0200
Message-ID: <1326697201-32406-8-git-send-email-amiettinen@nvidia.com>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Add maximum CPU frequency as PM QoS parameter.

Signed-off-by: Antti P Miettinen <amiettinen@nvidia.com>
---
 include/linux/pm_qos.h |    2 ++
 kernel/power/qos.c     |   15 +++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 54a0d00..7b8d08b 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -15,6 +15,7 @@ enum {
 	PM_QOS_NETWORK_LATENCY,
 	PM_QOS_NETWORK_THROUGHPUT,
 	PM_QOS_CPU_FREQ_MIN,
+	PM_QOS_CPU_FREQ_MAX,
 
 	/* insert new class ID */
 
@@ -28,6 +29,7 @@ enum {
 #define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE	0
 #define PM_QOS_DEV_LAT_DEFAULT_VALUE		0
 #define PM_QOS_CPU_FREQ_MIN_DEFAULT_VALUE	0
+#define PM_QOS_CPU_FREQ_MAX_DEFAULT_VALUE	LONG_MAX
 
 struct pm_qos_request {
 	struct plist_node node;
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 07d761a..04b744b 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -115,12 +115,27 @@ static struct pm_qos_object cpu_freq_min_pm_qos = {
 };
 
 
+static BLOCKING_NOTIFIER_HEAD(cpu_freq_max_notifier);
+static struct pm_qos_constraints cpu_freq_max_constraints = {
+	.list = PLIST_HEAD_INIT(cpu_freq_max_constraints.list),
+	.target_value = PM_QOS_CPU_FREQ_MAX_DEFAULT_VALUE,
+	.default_value = PM_QOS_CPU_FREQ_MAX_DEFAULT_VALUE,
+	.type = PM_QOS_MIN,
+	.notifiers = &cpu_freq_max_notifier,
+};
+static struct pm_qos_object cpu_freq_max_pm_qos = {
+	.constraints = &cpu_freq_max_constraints,
+	.name = "cpu_freq_max",
+};
+
+
 static struct pm_qos_object *pm_qos_array[] = {
 	&null_pm_qos,
 	&cpu_dma_pm_qos,
 	&network_lat_pm_qos,
 	&network_throughput_pm_qos,
 	&cpu_freq_min_pm_qos,
+	&cpu_freq_max_pm_qos,
 };
 
 static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
-- 
1.7.4.1
