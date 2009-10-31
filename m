From: "Ai Li" <aili@codeaurora.org>
Subject: Re: adding handles to pm_qos?
Date: Fri, 30 Oct 2009 19:53:42 -0600
Message-ID: <000001ca59cc$fc6999e0$f53ccda0$@org>
References: <000001ca4cf3$2a2da9c0$7e88fd40$@org>
	<20091023225304.GA32562@linux.intel.com>
	<000301ca5766$e671f870$b355e950$@org>
	<20091030145609.GA21256@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091030145609.GA21256@linux.intel.com>
Content-Language: en-us
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mgross@linux.intel.com
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> Oh.
> 
> This will not scale with the aggregation logic very well at all
> if
> pm_qos update requirement gets hit per transaction through a
> driver code
> path, then I think some thought on the scalability is needed and
> perhaps
> a change to the aggregation design for such uses.
> 
> Do you have a patch for the handle implementation I could look
> at?

Here is the patch that I use with the test code.  There are three new
functions:

void *pm_qos_get(int qos, char *name);
int pm_qos_put(void *handle);
int pm_qos_update_requirement_direct(void *handle, s32 new_value);

In the test, I wanted to keep the existing interface intact so I
could compare them at the same time.  For the formal code submission,
a different approach may work better.


--- include/linux/pm_qos_params.h.orig
+++ include/linux/pm_qos_params.h
@@ -16,7 +16,11 @@
 
 int pm_qos_add_requirement(int qos, char *name, s32 value);
 int pm_qos_update_requirement(int qos, char *name, s32 new_value);
-void pm_qos_remove_requirement(int qos, char *name);
+int pm_qos_remove_requirement(int qos, char *name);
+
+void *pm_qos_get(int qos, char *name);
+int pm_qos_put(void *handle);
+int pm_qos_update_requirement_direct(void *handle, s32 new_value);
 
 int pm_qos_requirement(int qos);
 
--- kernel/pm_qos_params.c.orig
+++ kernel/pm_qos_params.c
@@ -55,6 +55,8 @@ struct requirement_list {
 		s32 kbps;
 	};
 	char *name;
+	int pm_qos_class;
+	int handle_count;
 };
 
 static s32 max_compare(s32 v1, s32 v2);
@@ -210,7 +212,9 @@ EXPORT_SYMBOL_GPL(pm_qos_requirement);
 int pm_qos_add_requirement(int pm_qos_class, char *name, s32 value)
 {
 	struct requirement_list *dep;
+	struct requirement_list *node;
 	unsigned long flags;
+	int retval;
 
 	dep = kzalloc(sizeof(struct requirement_list), GFP_KERNEL);
 	if (dep) {
@@ -219,10 +223,25 @@ int pm_qos_add_requirement(int pm_qos_class,
char *name, s32 value)
 		else
 			dep->value = value;
 		dep->name = kstrdup(name, GFP_KERNEL);
-		if (!dep->name)
+		if (!dep->name) {
+			retval = -ENOMEM;
 			goto cleanup;
+		}
+		dep->pm_qos_class = pm_qos_class;
 
 		spin_lock_irqsave(&pm_qos_lock, flags);
+		/* make sure the new name is unique */
+		list_for_each_entry(node,
+
&pm_qos_array[pm_qos_class]->requirements.list, list) {
+			if (strcmp(node->name, name) == 0) {
+				spin_unlock_irqrestore(&pm_qos_lock,
flags);
+
+				kfree(dep->name);
+				retval = -EINVAL;
+				goto cleanup;
+			}
+		}
+
 		list_add(&dep->list,
 
&pm_qos_array[pm_qos_class]->requirements.list);
 		spin_unlock_irqrestore(&pm_qos_lock, flags);
@@ -231,9 +250,11 @@ int pm_qos_add_requirement(int pm_qos_class,
char *name, s32 value)
 		return 0;
 	}
 
+	retval = -ENOMEM;
+
 cleanup:
 	kfree(dep);
-	return -ENOMEM;
+	return retval;
 }
 EXPORT_SYMBOL_GPL(pm_qos_add_requirement);
 
@@ -282,8 +303,10 @@ EXPORT_SYMBOL_GPL(pm_qos_update_requirement);
  *
  * Will remove named qos request from pm_qos_class list of
parameters and
  * recompute the current target value for the pm_qos_class.
+ *
+ * If there are outstanding handles to the request, -EBUSY is
returned.
  */
-void pm_qos_remove_requirement(int pm_qos_class, char *name)
+int pm_qos_remove_requirement(int pm_qos_class, char *name)
 {
 	unsigned long flags;
 	struct requirement_list *node;
@@ -293,6 +316,11 @@ void pm_qos_remove_requirement(int pm_qos_class,
char *name)
 	list_for_each_entry(node,
 		&pm_qos_array[pm_qos_class]->requirements.list, list)
{
 		if (strcmp(node->name, name) == 0) {
+			if (node->handle_count > 0) {
+				spin_unlock_irqrestore(&pm_qos_lock,
flags);
+				return -EBUSY;
+			}
+
 			kfree(node->name);
 			list_del(&node->list);
 			kfree(node);
@@ -303,9 +331,83 @@ void pm_qos_remove_requirement(int pm_qos_class,
char *name)
 	spin_unlock_irqrestore(&pm_qos_lock, flags);
 	if (pending_update)
 		update_target(pm_qos_class);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pm_qos_remove_requirement);
 
+/* pm_qos_get - returns an opaque handle to the existing qos request
+ * @pm_qos_class: identifies which list of qos request to us
+ * @name: identifies the request
+ *
+ * Will increment the reference count as well.
+ *
+ * If the named request isn't in the list then NULL is returned.
+ */
+void *pm_qos_get(int pm_qos_class, char *name)
+{
+	unsigned long flags;
+	struct requirement_list *node;
+	struct requirement_list *handle = NULL;
+
+	spin_lock_irqsave(&pm_qos_lock, flags);
+	list_for_each_entry(node,
+		&pm_qos_array[pm_qos_class]->requirements.list, list)
{
+		if (strcmp(node->name, name) == 0) {
+			node->handle_count++;
+			handle = node;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&pm_qos_lock, flags);
+	return handle;
+}
+EXPORT_SYMBOL_GPL(pm_qos_get);
+
+/* pm_qos_put - release the handle of the existing qos request
+ * @handle: previously acquired through pm_qos_get
+ *
+ * Will decrement the reference count as well. Caller should no
+ * longer use the handle after this call.
+ */
+int pm_qos_put(void *handle)
+{
+	unsigned long flags;
+	struct requirement_list *node =	(struct requirement_list *)
handle;
+
+	spin_lock_irqsave(&pm_qos_lock, flags);
+	BUG_ON(node->handle_count == 0);
+	node->handle_count--;
+	spin_unlock_irqrestore(&pm_qos_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pm_qos_put);
+
+/* pm_qos_update_requirement_direct - modifies an existing qos
request
+ * @handle: previously acquired through pm_qos_get
+ * @value: defines the qos request
+ *
+ * Updates an existing qos requirement for the pm_qos_class of
parameters along
+ * with updating the target pm_qos_class value.
+ */
+int pm_qos_update_requirement_direct(void *handle, s32 new_value)
+{
+	unsigned long flags;
+	struct requirement_list *node = (struct requirement_list *)
handle;
+
+	spin_lock_irqsave(&pm_qos_lock, flags);
+	if (new_value == PM_QOS_DEFAULT_VALUE)
+		node->value =
pm_qos_array[node->pm_qos_class]->default_value;
+	else
+		node->value = new_value;
+	spin_unlock_irqrestore(&pm_qos_lock, flags);
+	update_target(node->pm_qos_class);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pm_qos_update_requirement_direct);
+
 /**
  * pm_qos_add_notifier - sets notification entry for changes to
target value
  * @pm_qos_class: identifies which qos target changes should be
notified.


~Ai
