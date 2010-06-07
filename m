From: florian@mickler.org
Subject: [PATCH v3] pm_qos: make update_request callable from
	interrupt context
Date: Mon,  7 Jun 2010 17:34:29 +0200
Message-ID: <1275924869-3811-1-git-send-email-florian@mickler.org>
References: <1275920448.2849.31.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275920448.2849.31.camel@mulgrave.site>
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

We use the spinlocked notifier chain variant (struct
atomic_notifier_head) and add an __might_sleep() to the chain for
constraints which have non-atomic notifiers. This way we catch all
interrupt-context-update-sites at runtime.

Signed-off-by: Florian Mickler <florian@mickler.org>
---

sorry, forgot to commit the changes of my last pass.

btw, that = __might_sleep() gives an "incompatible pointer" warning. 

should we care? it boots ok.

include/linux/pm_qos_params.h |    3 +-
 kernel/pm_qos_params.c        |   61 +++++++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/include/linux/pm_qos_params.h b/include/linux/pm_qos_params.h
index 8ba440e..c21ab20 100644
--- a/include/linux/pm_qos_params.h
+++ b/include/linux/pm_qos_params.h
@@ -20,8 +20,7 @@ struct pm_qos_request_list *pm_qos_add_request(int pm_qos_class, s32 value);
 void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
 		s32 new_value);
 void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req);
-
 int pm_qos_request(int pm_qos_class);
+
 int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier);
 int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier);
-
diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
index f42d3f7..5ae86c8 100644
--- a/kernel/pm_qos_params.c
+++ b/kernel/pm_qos_params.c
@@ -63,7 +63,7 @@ static s32 min_compare(s32 v1, s32 v2);
 
 struct pm_qos_object {
 	struct pm_qos_request_list requests;
-	struct blocking_notifier_head *notifiers;
+	struct atomic_notifier_head *notifiers;
 	struct miscdevice pm_qos_power_miscdev;
 	char *name;
 	s32 default_value;
@@ -72,7 +72,7 @@ struct pm_qos_object {
 };
 
 static struct pm_qos_object null_pm_qos;
-static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
+static ATOMIC_NOTIFIER_HEAD(cpu_dma_lat_notifier);
 static struct pm_qos_object cpu_dma_pm_qos = {
 	.requests = {LIST_HEAD_INIT(cpu_dma_pm_qos.requests.list)},
 	.notifiers = &cpu_dma_lat_notifier,
@@ -82,7 +82,7 @@ static struct pm_qos_object cpu_dma_pm_qos = {
 	.comparitor = min_compare
 };
 
-static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
+static ATOMIC_NOTIFIER_HEAD(network_lat_notifier);
 static struct pm_qos_object network_lat_pm_qos = {
 	.requests = {LIST_HEAD_INIT(network_lat_pm_qos.requests.list)},
 	.notifiers = &network_lat_notifier,
@@ -93,7 +93,7 @@ static struct pm_qos_object network_lat_pm_qos = {
 };
 
 
-static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
+static ATOMIC_NOTIFIER_HEAD(network_throughput_notifier);
 static struct pm_qos_object network_throughput_pm_qos = {
 	.requests = {LIST_HEAD_INIT(network_throughput_pm_qos.requests.list)},
 	.notifiers = &network_throughput_notifier,
@@ -103,7 +103,6 @@ static struct pm_qos_object network_throughput_pm_qos = {
 	.comparitor = max_compare
 };
 
-
 static struct pm_qos_object *pm_qos_array[] = {
 	&null_pm_qos,
 	&cpu_dma_pm_qos,
@@ -135,35 +134,30 @@ static s32 min_compare(s32 v1, s32 v2)
 	return min(v1, v2);
 }
 
-
 static void update_target(int pm_qos_class)
 {
 	s32 extreme_value;
+	struct pm_qos_object *obj = pm_qos_array[pm_qos_class];
 	struct pm_qos_request_list *node;
 	unsigned long flags;
 	int call_notifier = 0;
 
 	spin_lock_irqsave(&pm_qos_lock, flags);
-	extreme_value = pm_qos_array[pm_qos_class]->default_value;
-	list_for_each_entry(node,
-			&pm_qos_array[pm_qos_class]->requests.list, list) {
-		extreme_value = pm_qos_array[pm_qos_class]->comparitor(
-				extreme_value, node->value);
+	extreme_value = obj->default_value;
+	list_for_each_entry(node, &obj->requests.list, list) {
+		extreme_value = obj->comparitor(extreme_value, node->value);
 	}
-	if (atomic_read(&pm_qos_array[pm_qos_class]->target_value) !=
-			extreme_value) {
+	if (atomic_read(&obj->target_value) != extreme_value) {
 		call_notifier = 1;
-		atomic_set(&pm_qos_array[pm_qos_class]->target_value,
-				extreme_value);
+		atomic_set(&obj->target_value, extreme_value);
 		pr_debug(KERN_ERR "new target for qos %d is %d\n", pm_qos_class,
-			atomic_read(&pm_qos_array[pm_qos_class]->target_value));
+			atomic_read(&obj->target_value));
 	}
 	spin_unlock_irqrestore(&pm_qos_lock, flags);
 
-	if (call_notifier)
-		blocking_notifier_call_chain(
-				pm_qos_array[pm_qos_class]->notifiers,
-					(unsigned long) extreme_value, NULL);
+	if (call_notifier) 
+		atomic_notifier_call_chain(obj->notifiers,
+				(unsigned long) extreme_value, NULL);
 }
 
 static int register_pm_qos_misc(struct pm_qos_object *qos)
@@ -272,6 +266,7 @@ EXPORT_SYMBOL_GPL(pm_qos_update_request);
 
 /**
  * pm_qos_remove_request - modifies an existing qos request
+ *
  * @pm_qos_req: handle to request list element
  *
  * Will remove pm qos request from the list of requests and
@@ -298,18 +293,23 @@ EXPORT_SYMBOL_GPL(pm_qos_remove_request);
 
 /**
  * pm_qos_add_notifier - sets notification entry for changes to target value
+ *
+ * Note: There may be update sites which are called from interrupt context
+ * for a given constraint. Check pm_qos_power_init to check if the constraint
+ * in question does already have a might_sleep() added to the notifier chain.
+ *
  * @pm_qos_class: identifies which qos target changes should be notified.
  * @notifier: notifier block managed by caller.
  *
- * will register the notifier into a notification chain that gets called
+ * Will register the notifier into a notification chain that gets called
  * upon changes to the pm_qos_class target value.
  */
 int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier)
 {
 	int retval;
 
-	retval = blocking_notifier_chain_register(
-			pm_qos_array[pm_qos_class]->notifiers, notifier);
+	retval = atomic_notifier_chain_register(
+		pm_qos_array[pm_qos_class]->notifiers, notifier);
 
 	return retval;
 }
@@ -317,18 +317,19 @@ EXPORT_SYMBOL_GPL(pm_qos_add_notifier);
 
 /**
  * pm_qos_remove_notifier - deletes notification entry from chain.
+ *
  * @pm_qos_class: identifies which qos target changes are notified.
  * @notifier: notifier block to be removed.
  *
- * will remove the notifier from the notification chain that gets called
+ * Will remove the notifier from the notification chain that gets called
  * upon changes to the pm_qos_class target value.
  */
 int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier)
 {
 	int retval;
 
-	retval = blocking_notifier_chain_unregister(
-			pm_qos_array[pm_qos_class]->notifiers, notifier);
+	retval = atomic_notifier_chain_unregister(
+		pm_qos_array[pm_qos_class]->notifiers, notifier);
 
 	return retval;
 }
@@ -381,6 +382,7 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
 	} else
 		return -EINVAL;
 
+
 	pm_qos_req = (struct pm_qos_request_list *)filp->private_data;
 	pm_qos_update_request(pm_qos_req, value);
 
@@ -388,21 +390,28 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
 }
 
 
+static struct notifier_block nb_might_sleep = {
+	.notifier_call = __might_sleep,
+};
+
 static int __init pm_qos_power_init(void)
 {
 	int ret = 0;
 
 	ret = register_pm_qos_misc(&cpu_dma_pm_qos);
+	pm_qos_add_notifier(PM_QOS_CPU_DMA_LATENCY, &nb_might_sleep);
 	if (ret < 0) {
 		printk(KERN_ERR "pm_qos_param: cpu_dma_latency setup failed\n");
 		return ret;
 	}
 	ret = register_pm_qos_misc(&network_lat_pm_qos);
+	pm_qos_add_notifier(PM_QOS_NETWORK_LATENCY,&nb_might_sleep);
 	if (ret < 0) {
 		printk(KERN_ERR "pm_qos_param: network_latency setup failed\n");
 		return ret;
 	}
 	ret = register_pm_qos_misc(&network_throughput_pm_qos);
+	pm_qos_add_notifier(PM_QOS_NETWORK_THROUGHPUT,&nb_might_sleep);
 	if (ret < 0)
 		printk(KERN_ERR
 			"pm_qos_param: network_throughput setup failed\n");
-- 
1.7.1
