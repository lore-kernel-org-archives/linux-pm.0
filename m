From: florian@mickler.org
Subject: [PATCH] pm_qos: make update_request non blocking
Date: Sat,  5 Jun 2010 22:46:23 +0200
Message-ID: <1275770783-4183-1-git-send-email-florian@mickler.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Florian Mickler <florian@mickler.org>, james.bottomley@suse.de, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

First we use atomic_notifier to get the spinlocked variant.
Secondly we call the notifiers via schedule_work.

Signed-off-by: Florian Mickler <florian@mickler.org>
---

Please advise.

 kernel/pm_qos_params.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
index f42d3f7..7335c27 100644
--- a/kernel/pm_qos_params.c
+++ b/kernel/pm_qos_params.c
@@ -40,6 +40,7 @@
 #include <linux/string.h>
 #include <linux/platform_device.h>
 #include <linux/init.h>
+#include <linux/workqueue.h>
 
 #include <linux/uaccess.h>
 
@@ -63,7 +64,7 @@ static s32 min_compare(s32 v1, s32 v2);
 
 struct pm_qos_object {
 	struct pm_qos_request_list requests;
-	struct blocking_notifier_head *notifiers;
+	struct atomic_notifier_head *notifiers;
 	struct miscdevice pm_qos_power_miscdev;
 	char *name;
 	s32 default_value;
@@ -72,7 +73,7 @@ struct pm_qos_object {
 };
 
 static struct pm_qos_object null_pm_qos;
-static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
+static ATOMIC_NOTIFIER_HEAD(cpu_dma_lat_notifier);
 static struct pm_qos_object cpu_dma_pm_qos = {
 	.requests = {LIST_HEAD_INIT(cpu_dma_pm_qos.requests.list)},
 	.notifiers = &cpu_dma_lat_notifier,
@@ -82,7 +83,7 @@ static struct pm_qos_object cpu_dma_pm_qos = {
 	.comparitor = min_compare
 };
 
-static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
+static ATOMIC_NOTIFIER_HEAD(network_lat_notifier);
 static struct pm_qos_object network_lat_pm_qos = {
 	.requests = {LIST_HEAD_INIT(network_lat_pm_qos.requests.list)},
 	.notifiers = &network_lat_notifier,
@@ -93,7 +94,7 @@ static struct pm_qos_object network_lat_pm_qos = {
 };
 
 
-static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
+static ATOMIC_NOTIFIER_HEAD(network_throughput_notifier);
 static struct pm_qos_object network_throughput_pm_qos = {
 	.requests = {LIST_HEAD_INIT(network_throughput_pm_qos.requests.list)},
 	.notifiers = &network_throughput_notifier,
@@ -103,7 +104,6 @@ static struct pm_qos_object network_throughput_pm_qos = {
 	.comparitor = max_compare
 };
 
-
 static struct pm_qos_object *pm_qos_array[] = {
 	&null_pm_qos,
 	&cpu_dma_pm_qos,
@@ -135,6 +135,15 @@ static s32 min_compare(s32 v1, s32 v2)
 	return min(v1, v2);
 }
 
+static void update_notify(struct work_struct* work){
+	int pm_qos_class = atomic_long_read(&work->data);
+	
+	s32 extreme_value = atomic_read(&pm_qos_array[pm_qos_class]->target_value);
+	atomic_notifier_call_chain(
+		pm_qos_array[pm_qos_class]->notifiers,
+			(unsigned long) extreme_value, NULL);
+}
+struct work_struct pm_qos_update_notify_work;
 
 static void update_target(int pm_qos_class)
 {
@@ -160,10 +169,10 @@ static void update_target(int pm_qos_class)
 	}
 	spin_unlock_irqrestore(&pm_qos_lock, flags);
 
-	if (call_notifier)
-		blocking_notifier_call_chain(
-				pm_qos_array[pm_qos_class]->notifiers,
-					(unsigned long) extreme_value, NULL);
+	if (call_notifier){
+		atomic_long_set(&pm_qos_update_notify_work.data, pm_qos_class);
+		schedule_work(&pm_qos_update_notify_work);
+	}
 }
 
 static int register_pm_qos_misc(struct pm_qos_object *qos)
@@ -308,7 +317,7 @@ int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier)
 {
 	int retval;
 
-	retval = blocking_notifier_chain_register(
+	retval = atomic_notifier_chain_register(
 			pm_qos_array[pm_qos_class]->notifiers, notifier);
 
 	return retval;
@@ -327,7 +336,7 @@ int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier)
 {
 	int retval;
 
-	retval = blocking_notifier_chain_unregister(
+	retval = atomic_notifier_chain_unregister(
 			pm_qos_array[pm_qos_class]->notifiers, notifier);
 
 	return retval;
@@ -380,6 +389,8 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
 		pr_debug(KERN_ERR "%s, %d, 0x%x\n", ascii_value, x, value);
 	} else
 		return -EINVAL;
+	
+	INIT_WORK(&pm_qos_update_notify_work,update_notify);
 
 	pm_qos_req = (struct pm_qos_request_list *)filp->private_data;
 	pm_qos_update_request(pm_qos_req, value);
-- 
1.7.1
