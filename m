From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: [PATCH 1/6] PM QoS: Simplify PM QoS expansion/merge
Date: Fri,  6 Jan 2012 02:36:21 +0200
Message-ID: <1325810186-28986-2-git-send-email-amiettinen@nvidia.com>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
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
Cc: Alex Frid <afrid@nvidia.com>
List-Id: linux-pm@vger.kernel.org

From: Alex Frid <afrid@nvidia.com>

- Replace class ID #define with enumeration
- Loop through PM QoS objects during initialization (rather than
  initializing them one-by-one)

Signed-off-by: Alex Frid <afrid@nvidia.com>
Reviewed-by: Antti Miettinen <amiettinen@nvidia.com>
Reviewed-by: Diwakar Tundlam <dtundlam@nvidia.com>
Reviewed-by: Scott Williams <scwilliams@nvidia.com>
Reviewed-by: Yu-Huan Hsu <yhsu@nvidia.com>
---
 include/linux/pm_qos.h |   14 +++++++++-----
 kernel/power/qos.c     |   23 ++++++++++-------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index e5bbcba..5ac91d8 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -9,12 +9,16 @@
 #include <linux/miscdevice.h>
 #include <linux/device.h>
 
-#define PM_QOS_RESERVED 0
-#define PM_QOS_CPU_DMA_LATENCY 1
-#define PM_QOS_NETWORK_LATENCY 2
-#define PM_QOS_NETWORK_THROUGHPUT 3
+enum {
+	PM_QOS_RESERVED = 0,
+	PM_QOS_CPU_DMA_LATENCY,
+	PM_QOS_NETWORK_LATENCY,
+	PM_QOS_NETWORK_THROUGHPUT,
+
+	/* insert new class ID */
+	PM_QOS_NUM_CLASSES,
+};
 
-#define PM_QOS_NUM_CLASSES 4
 #define PM_QOS_DEFAULT_VALUE -1
 
 #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 995e3bd..d6d6dbd 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -469,21 +469,18 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
 static int __init pm_qos_power_init(void)
 {
 	int ret = 0;
+	int i;
 
-	ret = register_pm_qos_misc(&cpu_dma_pm_qos);
-	if (ret < 0) {
-		printk(KERN_ERR "pm_qos_param: cpu_dma_latency setup failed\n");
-		return ret;
-	}
-	ret = register_pm_qos_misc(&network_lat_pm_qos);
-	if (ret < 0) {
-		printk(KERN_ERR "pm_qos_param: network_latency setup failed\n");
-		return ret;
+	BUILD_BUG_ON(ARRAY_SIZE(pm_qos_array) != PM_QOS_NUM_CLASSES);
+
+	for (i = 1; i < PM_QOS_NUM_CLASSES; i++) {
+		ret = register_pm_qos_misc(pm_qos_array[i]);
+		if (ret < 0) {
+			printk(KERN_ERR "pm_qos_param: %s setup failed\n",
+			       pm_qos_array[i]->name);
+			return ret;
+		}
 	}
-	ret = register_pm_qos_misc(&network_throughput_pm_qos);
-	if (ret < 0)
-		printk(KERN_ERR
-			"pm_qos_param: network_throughput setup failed\n");
 
 	return ret;
 }
-- 
1.7.4.1
