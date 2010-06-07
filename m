From: florian@mickler.org
Subject: [PATCH] pm_qos: make update_request callable from
	interrupt context
Date: Mon,  7 Jun 2010 14:31:05 +0200
Message-ID: <1275913865-16277-1-git-send-email-florian@mickler.org>
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

We introduce new atomic_notifiers and only call the (legacy) blocking
notifiers if there are any registered. A might_sleep() tries to
fence off all misuse.

This should make it possible to call update_request from interrupt-context
as long as only atomic notifiers are registered.

Signed-off-by: Florian Mickler <florian@mickler.org>
---
 include/linux/pm_qos_params.h |    3 +
 kernel/pm_qos_params.c        |  114 ++++++++++++++++++++++++++++++++--------
 2 files changed, 94 insertions(+), 23 deletions(-)

diff --git a/include/linux/pm_qos_params.h b/include/linux/pm_qos_params.h
index 8ba440e..60ed542 100644
--- a/include/linux/pm_qos_params.h
+++ b/include/linux/pm_qos_params.h
@@ -22,6 +22,9 @@ void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
 void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req);
 
 int pm_qos_request(int pm_qos_class);
+
 int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier);
 int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier);
 
+int pm_qos_add_notifier_nonblocking(int pm_qos_class, struct notifier_block *notifier);
+int pm_qos_remove_notifier_nonblocking(int pm_qos_class, struct notifier_block *notifier);
diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
index f42d3f7..0a67997 100644
--- a/kernel/pm_qos_params.c
+++ b/kernel/pm_qos_params.c
@@ -63,7 +63,8 @@ static s32 min_compare(s32 v1, s32 v2);
 
 struct pm_qos_object {
 	struct pm_qos_request_list requests;
-	struct blocking_notifier_head *notifiers;
+	struct atomic_notifier_head *notifiers;
+	struct blocking_notifier_head *blocking_notifiers;
 	struct miscdevice pm_qos_power_miscdev;
 	char *name;
 	s32 default_value;
@@ -72,20 +73,24 @@ struct pm_qos_object {
 };
 
 static struct pm_qos_object null_pm_qos;
-static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
+static ATOMIC_NOTIFIER_HEAD(cpu_dma_lat_notifier);
+static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_blocking_notifier);
 static struct pm_qos_object cpu_dma_pm_qos = {
 	.requests = {LIST_HEAD_INIT(cpu_dma_pm_qos.requests.list)},
 	.notifiers = &cpu_dma_lat_notifier,
+	.blocking_notifiers = &cpu_dma_lat_blocking_notifier,
 	.name = "cpu_dma_latency",
 	.default_value = 2000 * USEC_PER_SEC,
 	.target_value = ATOMIC_INIT(2000 * USEC_PER_SEC),
 	.comparitor = min_compare
 };
 
-static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
+static ATOMIC_NOTIFIER_HEAD(network_lat_notifier);
+static BLOCKING_NOTIFIER_HEAD(network_lat_blocking_notifier);
 static struct pm_qos_object network_lat_pm_qos = {
 	.requests = {LIST_HEAD_INIT(network_lat_pm_qos.requests.list)},
 	.notifiers = &network_lat_notifier,
+	.blocking_notifiers = &network_lat_blocking_notifier,
 	.name = "network_latency",
 	.default_value = 2000 * USEC_PER_SEC,
 	.target_value = ATOMIC_INIT(2000 * USEC_PER_SEC),
@@ -93,17 +98,18 @@ static struct pm_qos_object network_lat_pm_qos = {
 };
 
 
-static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
+static ATOMIC_NOTIFIER_HEAD(network_throughput_notifier);
+static BLOCKING_NOTIFIER_HEAD(network_throughput_blocking_notifier);
 static struct pm_qos_object network_throughput_pm_qos = {
 	.requests = {LIST_HEAD_INIT(network_throughput_pm_qos.requests.list)},
 	.notifiers = &network_throughput_notifier,
+	.blocking_notifiers = &network_throughput_blocking_notifier,
 	.name = "network_throughput",
 	.default_value = 0,
 	.target_value = ATOMIC_INIT(0),
 	.comparitor = max_compare
 };
 
-
 static struct pm_qos_object *pm_qos_array[] = {
 	&null_pm_qos,
 	&cpu_dma_pm_qos,
@@ -135,35 +141,45 @@ static s32 min_compare(s32 v1, s32 v2)
 	return min(v1, v2);
 }
 
+/* these notifiers may not be cool to call from interrupt context... */
+static void blocking_update_notify(struct pm_qos_object *obj)
+{
+	s32 extreme_value;
+
+	might_sleep();
+
+	extreme_value = atomic_read(&obj->target_value);
+	blocking_notifier_call_chain(obj->blocking_notifiers,
+			(unsigned long) extreme_value, NULL);
+}
 
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
+	if (call_notifier) {
+		atomic_notifier_call_chain(obj->notifiers,
+				(unsigned long) extreme_value, NULL);
+		if (obj->blocking_notifiers->head != NULL)
+			blocking_update_notify(obj);
+	}
 }
 
 static int register_pm_qos_misc(struct pm_qos_object *qos)
@@ -272,6 +288,7 @@ EXPORT_SYMBOL_GPL(pm_qos_update_request);
 
 /**
  * pm_qos_remove_request - modifies an existing qos request
+ *
  * @pm_qos_req: handle to request list element
  *
  * Will remove pm qos request from the list of requests and
@@ -297,11 +314,39 @@ void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req)
 EXPORT_SYMBOL_GPL(pm_qos_remove_request);
 
 /**
+ * pm_qos_add_notifier_nonblocking - sets notification entry for changes to target value
+ *
+ * Code executed by the notifier block may not sleep!
+ *
+ * @pm_qos_class: identifies which qos target changes should be notified.
+ * @notifier: notifier block managed by caller.
+ *
+ * Will register the notifier into a notification chain that gets called
+ * upon changes to the pm_qos_class target value.
+ */
+int pm_qos_add_notifier_nonblocking(int pm_qos_class, struct notifier_block *notifier)
+{
+	int retval;
+
+	retval = atomic_notifier_chain_register(
+			pm_qos_array[pm_qos_class]->notifiers, notifier);
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(pm_qos_add_notifier_nonblocking);
+
+
+/**
  * pm_qos_add_notifier - sets notification entry for changes to target value
+ *
+ * Notifiers added with this function are executed in process context.
+ * They may also be scheduled for later execution if pm_qos_update_request is
+ * called from interrupt context.
+ *
  * @pm_qos_class: identifies which qos target changes should be notified.
  * @notifier: notifier block managed by caller.
  *
- * will register the notifier into a notification chain that gets called
+ * Will register the notifier into a notification chain that gets called
  * upon changes to the pm_qos_class target value.
  */
 int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier)
@@ -309,18 +354,40 @@ int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier)
 	int retval;
 
 	retval = blocking_notifier_chain_register(
-			pm_qos_array[pm_qos_class]->notifiers, notifier);
+			pm_qos_array[pm_qos_class]->blocking_notifiers, notifier);
 
 	return retval;
 }
 EXPORT_SYMBOL_GPL(pm_qos_add_notifier);
 
 /**
+ * pm_qos_remove_notifier_nonblocking - deletes notification entry from the
+ * nonblocking-notifier-chain.
+ *
+ * @pm_qos_class: identifies which qos target changes are notified.
+ * @notifier: notifier block to be removed.
+ *
+ * Will remove the notifier from the notification chain that gets called
+ * upon changes to the pm_qos_class target value.
+ */
+int pm_qos_remove_notifier_nonblocking(int pm_qos_class, struct notifier_block *notifier)
+{
+	int retval;
+
+	retval = atomic_notifier_chain_unregister(
+			pm_qos_array[pm_qos_class]->notifiers, notifier);
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(pm_qos_remove_notifier_nonblocking);
+
+/**
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
@@ -328,7 +395,7 @@ int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier)
 	int retval;
 
 	retval = blocking_notifier_chain_unregister(
-			pm_qos_array[pm_qos_class]->notifiers, notifier);
+			pm_qos_array[pm_qos_class]->blocking_notifiers, notifier);
 
 	return retval;
 }
@@ -381,6 +448,7 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
 	} else
 		return -EINVAL;
 
+
 	pm_qos_req = (struct pm_qos_request_list *)filp->private_data;
 	pm_qos_update_request(pm_qos_req, value);
 
-- 
1.7.1
