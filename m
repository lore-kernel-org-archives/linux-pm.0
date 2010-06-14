From: florian@mickler.org
Subject: [PATCH 2/3] pm_qos: add atomic notifier chain
Date: Mon, 14 Jun 2010 16:46:39 +0200
Message-ID: <1276526800-12362-2-git-send-email-florian@mickler.org>
References: <1276266352.2862.70.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1276266352.2862.70.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James.Bottomley@suse.de
Cc: markgross@thegnar.org, Frederic Weisbecker <fweisbec@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linville@tuxdriver.com, linux-kernel@vger.kernel.org, Florian Mickler <florian@mickler.org>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

This allows for atomic notifications.
This may be necessary to have in some future scenarios,
as it eliminates any scheduling between update_request and doing the
notifier_callback.
---

I took the naming of the interface functions James Bottomly suggested in an earlier patch.

 include/linux/pm_qos_params.h |    1 +
 kernel/pm_qos_params.c        |   76 ++++++++++++++++++++++++++++++++---------
 2 files changed, 61 insertions(+), 16 deletions(-)

diff --git a/include/linux/pm_qos_params.h b/include/linux/pm_qos_params.h
index 8ba440e..0f41378 100644
--- a/include/linux/pm_qos_params.h
+++ b/include/linux/pm_qos_params.h
@@ -23,5 +23,6 @@ void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req);
 
 int pm_qos_request(int pm_qos_class);
 int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier);
+int pm_qos_add_atomic_notifier(int pm_qos_class, struct notifier_block *notifier);
 int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier);
 
diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
index 296343a..9346906 100644
--- a/kernel/pm_qos_params.c
+++ b/kernel/pm_qos_params.c
@@ -65,7 +65,8 @@ static void update_notify(struct work_struct *work);
 
 struct pm_qos_object {
 	struct pm_qos_request_list requests;
-	struct blocking_notifier_head *notifiers;
+	struct blocking_notifier_head *blocking_notifiers;
+	struct atomic_notifier_head *atomic_notifiers;
 	struct miscdevice pm_qos_power_miscdev;
 	struct work_struct notify;
 	char *name;
@@ -76,21 +77,25 @@ struct pm_qos_object {
 
 static struct pm_qos_object null_pm_qos;
 
-static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
+static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier_blocking);
+static ATOMIC_NOTIFIER_HEAD(cpu_dma_lat_notifier_atomic);
 static struct pm_qos_object cpu_dma_pm_qos = {
 	.requests = {LIST_HEAD_INIT(cpu_dma_pm_qos.requests.list)},
-	.notifiers = &cpu_dma_lat_notifier,
+	.blocking_notifiers = &cpu_dma_lat_notifier_blocking,
+	.atomic_notifiers = &cpu_dma_lat_notifier_atomic,
 	.notify = __WORK_INITIALIZER(cpu_dma_pm_qos.notify, update_notify),
 	.name = "cpu_dma_latency",
 	.default_value = 2000 * USEC_PER_SEC,
 	.target_value = ATOMIC_INIT(2000 * USEC_PER_SEC),
-	.comparitor = min_compare
+	.comparitor = min_compare,
 };
 
-static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
+static BLOCKING_NOTIFIER_HEAD(network_lat_notifier_blocking);
+static ATOMIC_NOTIFIER_HEAD(network_lat_notifier_atomic);
 static struct pm_qos_object network_lat_pm_qos = {
 	.requests = {LIST_HEAD_INIT(network_lat_pm_qos.requests.list)},
-	.notifiers = &network_lat_notifier,
+	.blocking_notifiers = &network_lat_notifier_blocking,
+	.atomic_notifiers = &network_lat_notifier_atomic,
 	.notify = __WORK_INITIALIZER(network_lat_pm_qos.notify, update_notify),
 	.name = "network_latency",
 	.default_value = 2000 * USEC_PER_SEC,
@@ -99,10 +104,12 @@ static struct pm_qos_object network_lat_pm_qos = {
 };
 
 
-static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
+static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier_blocking);
+static ATOMIC_NOTIFIER_HEAD(network_throughput_notifier_atomic);
 static struct pm_qos_object network_throughput_pm_qos = {
 	.requests = {LIST_HEAD_INIT(network_throughput_pm_qos.requests.list)},
-	.notifiers = &network_throughput_notifier,
+	.blocking_notifiers = &network_throughput_notifier_blocking,
+	.atomic_notifiers = &network_throughput_notifier_atomic,
 	.notify = __WORK_INITIALIZER(network_throughput_pm_qos.notify,
 			update_notify),
 	.name = "network_throughput",
@@ -142,6 +149,16 @@ static s32 min_compare(s32 v1, s32 v2)
 	return min(v1, v2);
 }
 
+static void pm_qos_call_notifiers(struct pm_qos_object *o,
+				  unsigned long curr_value)
+{
+	schedule_work(&o->notify);
+
+	if (o->atomic_notifiers)
+		atomic_notifier_call_chain(o->atomic_notifiers,
+					   curr_value, NULL);
+}
+
 static void update_notify(struct work_struct *work)
 {
 	struct pm_qos_object *obj =
@@ -149,7 +166,7 @@ static void update_notify(struct work_struct *work)
 
 	s32 extreme_value = atomic_read(&obj->target_value);
 	blocking_notifier_call_chain(
-		obj->notifiers,
+		obj->blocking_notifiers,
 			(unsigned long) extreme_value, NULL);
 }
 
@@ -175,7 +192,7 @@ static void update_target(int pm_qos_class)
 	spin_unlock_irqrestore(&pm_qos_lock, flags);
 
 	if (call_notifier)
-		schedule_work(&obj->notify);
+		pm_qos_call_notifiers(obj, extreme_value);
 }
 
 static int register_pm_qos_misc(struct pm_qos_object *qos)
@@ -310,24 +327,48 @@ EXPORT_SYMBOL_GPL(pm_qos_remove_request);
 
 /**
  * pm_qos_add_notifier - sets notification entry for changes to target value
- * @pm_qos_class: identifies which qos target changes should be notified.
+ * @pm_qos_class: identifies which qos target changes should trigger
+ *   	notifications.
  * @notifier: notifier block managed by caller.
  *
  * Will register the notifier into a notification chain that gets called
  * upon changes to the pm_qos_class target value.
  */
-int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier)
+int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *nb)
 {
 	int retval;
 
 	retval = blocking_notifier_chain_register(
-			pm_qos_array[pm_qos_class]->notifiers, notifier);
+			pm_qos_array[pm_qos_class]->blocking_notifiers, nb);
 
 	return retval;
 }
 EXPORT_SYMBOL_GPL(pm_qos_add_notifier);
 
 /**
+ * pm_qos_add_atomic_notifier - sets notification entry for changes to target value
+ * @pm_qos_class: identifies which qos target changes should trigger
+ * 	notifications.
+ * @notifier: notifier block managed by caller.
+ *
+ * Will register the notifier into a notification chain that gets
+ * called upon changes to the pm_qos_class target value.  The notifier
+ * may be called from atomic context.  use @pm_qos_remove_notifier to
+ * unregister.
+ *
+ */
+int pm_qos_add_atomic_notifier(int pm_qos_class, struct notifier_block *notifier)
+{
+	/* guard against programming error */
+	BUG_ON(!pm_qos_array[pm_qos_class]->atomic_notifiers);
+
+	return atomic_notifier_chain_register(
+		pm_qos_array[pm_qos_class]->atomic_notifiers,
+		notifier);
+}
+EXPORT_SYMBOL_GPL(pm_qos_add_atomic_notifier);
+
+/**
  * pm_qos_remove_notifier - deletes notification entry from chain.
  * @pm_qos_class: identifies which qos target changes are notified.
  * @notifier: notifier block to be removed.
@@ -335,13 +376,16 @@ EXPORT_SYMBOL_GPL(pm_qos_add_notifier);
  * Will remove the notifier from the notification chain that gets called
  * upon changes to the pm_qos_class target value.
  */
-int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier)
+int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *nb)
 {
 	int retval;
 
 	retval = blocking_notifier_chain_unregister(
-			pm_qos_array[pm_qos_class]->notifiers, notifier);
-
+			pm_qos_array[pm_qos_class]->blocking_notifiers, nb);
+	if (retval) {
+		retval = atomic_notifier_chain_unregister(
+			pm_qos_array[pm_qos_class]->atomic_notifiers, nb);
+	}
 	return retval;
 }
 EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
-- 
1.7.1
