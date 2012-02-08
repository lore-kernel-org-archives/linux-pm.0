From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Per CPU frequency constraints (was Re: [PATCH v2 0/8]
	RFC: CPU frequency min/max as PM QoS params)
Date: Wed, 08 Feb 2012 10:49:35 +0200
Message-ID: <87ehu5zp40.fsf_-_@amiettinen-lnx.nvidia.com>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
	<201201192315.22590.rjw@sisk.pl>
	<87d3acf2jh.fsf@amiettinen-lnx.nvidia.com>
	<201201230043.46436.rjw@sisk.pl>
	<87vcnp93bl.fsf@amiettinen-lnx.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Antti P Miettinen <amiettinen@nvidia.com> writes:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> On Sunday, January 22, 2012, Antti P Miettinen wrote:
> [..]
>>> Seems that the device specific constraints are not yet in use in
>>> 3.3-rc1, or am I not looking hard enough?
>>
>> They are in use through generic PM domains (drivers/base/power/domain*.c
>> and friends) and ARM/shmobile uses those.
>>
>> Thanks,
>> Rafael
>
> Sorry for the delay - got pre-empted by other stuff. I took a look at
> the per device constraints. Do I understand it correctly that the idea
> is that there is only one constraint per device? If we want to make
> frequency and latency per CPU I guess we'd need separate constraints
> associated with the CPU device. Or do I misunderstand something?
>
> Or would global CPU frequency be more in line with global CPU latency
> after all?
>
> 	--Antti

Ok - here's something - try not to laugh too hard. It's not pretty but
should serve as something for discussion the issues. This is on top of
the v3 patch series, against linus/master (3.3-rc2+). Previously I did
not CC people in my followups, I only posted to the lists. This was
probably wrong - sorry about that. This time I'm CCing people - if you
do not want to be CCd, please tell me. If you want this in some other
form (just a big patch with the previous series?), please tell me.

Anyway - does anyone have good solutions to the below issues? In general
- is per CPU worth the trouble?

1. Per device request ID space

Should each device have it's own ID space? I changed the one (implicitly
"latency") constraint to an array. But not all requests are relevant for
all devices so we waste some space. Is this an issue?

2. Systems with large number of processors

Dynamic minors for misc devices run out for those. Also the
pm_qos_object array is large for such systems. Also, hotpluggable CPUs
are kind of an issue. My laptop has possible-mask of 16 CPUs even though
I will never plug more CPUs to this system - at least not at
runtime. Also having a file handle per QoS request feels a bit
excessive. Can we require the data via the file handle to be more
structured line dev+id+value? Would require more elaborate book keeping
to clean up upon file close. Some better solution for the user space
interface?

3. Normal pm_qos_request vs dev_pm_qos_request

Maybe some refactoring could minimize the acrobatics related to the
function pointers and stuff I added to pm_qos_object.

And, yes, general cleanup and splitting to coherent changes would
definitely be required but I wanted to get opinions about what direction
to go with this.

	--Antti

From: Antti P Miettinen <amiettinen@nvidia.com>
Date: Tue, 7 Feb 2012 15:20:15 +0200
Subject: [PATCH] cpufreq: PM QoS: Per CPU frequency constraints

Change frequency minimum and maximum into per device
constraints.

Signed-off-by: Antti P Miettinen <amiettinen@nvidia.com>
---
 drivers/base/power/qos.c           |  121 +++++++++++++++++++---------
 drivers/base/power/runtime.c       |    2 +-
 drivers/cpufreq/cpufreq.c          |  132 ++++++++++++++++++++++++++----
 drivers/input/input-cfboost.c      |   29 ++++++--
 drivers/input/touchscreen/st1232.c |    3 +-
 include/linux/pm_qos.h             |   51 ++++++++++---
 kernel/power/qos.c                 |  155 ++++++++++++++++++++----------------
 7 files changed, 350 insertions(+), 143 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index c5d3588..325930b 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -44,7 +44,23 @@
 
 static DEFINE_MUTEX(dev_pm_qos_mtx);
 
-static BLOCKING_NOTIFIER_HEAD(dev_pm_notifiers);
+static const s32 pm_qos_dev_default[] = {
+	PM_QOS_DEV_LAT_DEFAULT_VALUE,
+	PM_QOS_CPU_FREQ_MIN_DEFAULT_VALUE,
+	PM_QOS_CPU_FREQ_MAX_DEFAULT_VALUE,
+};
+
+static const s32 pm_qos_dev_type[] = {
+	PM_QOS_MIN,
+	PM_QOS_MAX,
+	PM_QOS_MIN,
+};
+
+static struct blocking_notifier_head dev_pm_notifiers[] = {
+	BLOCKING_NOTIFIER_INIT(dev_pm_notifiers[0]),
+	BLOCKING_NOTIFIER_INIT(dev_pm_notifiers[1]),
+	BLOCKING_NOTIFIER_INIT(dev_pm_notifiers[2]),
+};
 
 /**
  * __dev_pm_qos_read_value - Get PM QoS constraint for a given device.
@@ -52,24 +68,24 @@ static BLOCKING_NOTIFIER_HEAD(dev_pm_notifiers);
  *
  * This routine must be called with dev->power.lock held.
  */
-s32 __dev_pm_qos_read_value(struct device *dev)
+s32 __dev_pm_qos_read_value(struct device *dev, int id)
 {
 	struct pm_qos_constraints *c = dev->power.constraints;
-
-	return c ? pm_qos_read_value(c) : 0;
+	BUG_ON(id >= PM_QOS_DEV_NUM_CLASSES);
+	return c ? pm_qos_read_value(&c[id]) : pm_qos_dev_default[id];
 }
 
 /**
  * dev_pm_qos_read_value - Get PM QoS constraint for a given device (locked).
  * @dev: Device to get the PM QoS constraint value for.
  */
-s32 dev_pm_qos_read_value(struct device *dev)
+s32 dev_pm_qos_read_value(struct device *dev, int id)
 {
 	unsigned long flags;
 	s32 ret;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
-	ret = __dev_pm_qos_read_value(dev);
+	ret = __dev_pm_qos_read_value(dev, id);
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	return ret;
@@ -89,14 +105,16 @@ static int apply_constraint(struct dev_pm_qos_request *req,
 			    enum pm_qos_req_action action, int value)
 {
 	int ret, curr_value;
+	struct pm_qos_constraints *c;
 
-	ret = pm_qos_update_target(req->dev->power.constraints,
+	c = &req->dev->power.constraints[req->dev_class];
+	ret = pm_qos_update_target(c,
 				   &req->node, action, value);
 
 	if (ret) {
 		/* Call the global callbacks if needed */
-		curr_value = pm_qos_read_value(req->dev->power.constraints);
-		blocking_notifier_call_chain(&dev_pm_notifiers,
+		curr_value = pm_qos_read_value(c);
+		blocking_notifier_call_chain(&dev_pm_notifiers[req->dev_class],
 					     (unsigned long)curr_value,
 					     req);
 	}
@@ -105,33 +123,38 @@ static int apply_constraint(struct dev_pm_qos_request *req,
 }
 
 /*
- * dev_pm_qos_constraints_allocate
+ * __dev_pm_qos_constraints_allocate
  * @dev: device to allocate data for
  *
  * Called at the first call to add_request, for constraint data allocation
  * Must be called with the dev_pm_qos_mtx mutex held
  */
-static int dev_pm_qos_constraints_allocate(struct device *dev)
+static int __dev_pm_qos_constraints_allocate(struct device *dev)
 {
 	struct pm_qos_constraints *c;
 	struct blocking_notifier_head *n;
+	int i;
 
-	c = kzalloc(sizeof(*c), GFP_KERNEL);
+	c = kzalloc(sizeof(*c) * PM_QOS_DEV_NUM_CLASSES, GFP_KERNEL);
 	if (!c)
 		return -ENOMEM;
 
-	n = kzalloc(sizeof(*n), GFP_KERNEL);
+	n = kzalloc(sizeof(*n) * PM_QOS_DEV_NUM_CLASSES, GFP_KERNEL);
 	if (!n) {
 		kfree(c);
 		return -ENOMEM;
 	}
-	BLOCKING_INIT_NOTIFIER_HEAD(n);
 
-	plist_head_init(&c->list);
-	c->target_value = PM_QOS_DEV_LAT_DEFAULT_VALUE;
-	c->default_value = PM_QOS_DEV_LAT_DEFAULT_VALUE;
-	c->type = PM_QOS_MIN;
-	c->notifiers = n;
+	for (i = 0; i < PM_QOS_DEV_NUM_CLASSES; ++i) {
+		BLOCKING_INIT_NOTIFIER_HEAD(&n[i]);
+
+		plist_head_init(&c[i].list);
+		c[i].target_value = pm_qos_dev_default[i];
+		c[i].default_value = pm_qos_dev_default[i];
+		c[i].type = pm_qos_dev_type[i];
+		c[i].notifiers = &n[i];
+
+	}
 
 	spin_lock_irq(&dev->power.lock);
 	dev->power.constraints = c;
@@ -140,6 +163,16 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	return 0;
 }
 
+int dev_pm_qos_constraints_allocate(struct device *dev)
+{
+	int ret;
+	mutex_lock(&dev_pm_qos_mtx);
+	ret = __dev_pm_qos_constraints_allocate(dev);
+	mutex_unlock(&dev_pm_qos_mtx);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_qos_constraints_allocate);
+
 /**
  * dev_pm_qos_constraints_init - Initalize device's PM QoS constraints pointer.
  * @dev: target device
@@ -165,6 +198,7 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 {
 	struct dev_pm_qos_request *req, *tmp;
 	struct pm_qos_constraints *c;
+	int i;
 
 	mutex_lock(&dev_pm_qos_mtx);
 
@@ -173,21 +207,25 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 	if (!c)
 		goto out;
 
-	/* Flush the constraints list for the device */
-	plist_for_each_entry_safe(req, tmp, &c->list, node) {
-		/*
-		 * Update constraints list and call the notification
-		 * callbacks if needed
-		 */
-		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
-		memset(req, 0, sizeof(*req));
+	for (i = 0; i < PM_QOS_DEV_NUM_CLASSES; ++i) {
+		c = &dev->power.constraints[i];
+		/* Flush the constraints list for the device */
+		plist_for_each_entry_safe(req, tmp, &c->list, node) {
+			/*
+			 * Update constraints list and call the notification
+			 * callbacks if needed
+			 */
+			apply_constraint(req, PM_QOS_REMOVE_REQ,
+					 PM_QOS_DEFAULT_VALUE);
+			memset(req, 0, sizeof(*req));
+		}
 	}
 
 	spin_lock_irq(&dev->power.lock);
 	dev->power.constraints = NULL;
 	spin_unlock_irq(&dev->power.lock);
 
-	kfree(c->notifiers);
+	kfree(c[0].notifiers);
 	kfree(c);
 
  out:
@@ -213,7 +251,7 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
  * from the system.
  */
 int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
-			   s32 value)
+			   int id, s32 value)
 {
 	int ret = 0;
 
@@ -225,6 +263,7 @@ int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 		return -EINVAL;
 
 	req->dev = dev;
+	req->dev_class = id;
 
 	mutex_lock(&dev_pm_qos_mtx);
 
@@ -346,7 +385,8 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
  * Will register the notifier into a notification chain that gets called
  * upon changes to the target value for the device.
  */
-int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier)
+int dev_pm_qos_add_notifier(struct device *dev, int id,
+			    struct notifier_block *notifier)
 {
 	int retval = 0;
 
@@ -355,7 +395,7 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier)
 	/* Silently return if the constraints object is not present. */
 	if (dev->power.constraints)
 		retval = blocking_notifier_chain_register(
-				dev->power.constraints->notifiers,
+				dev->power.constraints[id].notifiers,
 				notifier);
 
 	mutex_unlock(&dev_pm_qos_mtx);
@@ -373,7 +413,7 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_add_notifier);
  * Will remove the notifier from the notification chain that gets called
  * upon changes to the target value.
  */
-int dev_pm_qos_remove_notifier(struct device *dev,
+int dev_pm_qos_remove_notifier(struct device *dev, int id,
 			       struct notifier_block *notifier)
 {
 	int retval = 0;
@@ -383,7 +423,7 @@ int dev_pm_qos_remove_notifier(struct device *dev,
 	/* Silently return if the constraints object is not present. */
 	if (dev->power.constraints)
 		retval = blocking_notifier_chain_unregister(
-				dev->power.constraints->notifiers,
+				dev->power.constraints[id].notifiers,
 				notifier);
 
 	mutex_unlock(&dev_pm_qos_mtx);
@@ -400,9 +440,10 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_remove_notifier);
  * Will register the notifier into a notification chain that gets called
  * upon changes to the target value for any device.
  */
-int dev_pm_qos_add_global_notifier(struct notifier_block *notifier)
+int dev_pm_qos_add_global_notifier(struct notifier_block *notifier, int id)
 {
-	return blocking_notifier_chain_register(&dev_pm_notifiers, notifier);
+	return blocking_notifier_chain_register(&dev_pm_notifiers[id],
+						notifier);
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_add_global_notifier);
 
@@ -415,9 +456,10 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_add_global_notifier);
  * Will remove the notifier from the notification chain that gets called
  * upon changes to the target value for any device.
  */
-int dev_pm_qos_remove_global_notifier(struct notifier_block *notifier)
+int dev_pm_qos_remove_global_notifier(struct notifier_block *notifier, int id)
 {
-	return blocking_notifier_chain_unregister(&dev_pm_notifiers, notifier);
+	return blocking_notifier_chain_unregister(&dev_pm_notifiers[id],
+						  notifier);
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_remove_global_notifier);
 
@@ -428,7 +470,8 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_remove_global_notifier);
  * @value: Constraint latency value.
  */
 int dev_pm_qos_add_ancestor_request(struct device *dev,
-				    struct dev_pm_qos_request *req, s32 value)
+				    struct dev_pm_qos_request *req,
+				    int id, s32 value)
 {
 	struct device *ancestor = dev->parent;
 	int error = -ENODEV;
@@ -437,7 +480,7 @@ int dev_pm_qos_add_ancestor_request(struct device *dev,
 		ancestor = ancestor->parent;
 
 	if (ancestor)
-		error = dev_pm_qos_add_request(ancestor, req, value);
+		error = dev_pm_qos_add_request(ancestor, req, id, value);
 
 	if (error)
 		req->dev = NULL;
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 541f821..cc424bc 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -445,7 +445,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 		goto out;
 	}
 
-	qos.constraint_ns = __dev_pm_qos_read_value(dev);
+	qos.constraint_ns = __dev_pm_qos_read_value(dev, PM_QOS_DEV_LATENCY);
 	if (qos.constraint_ns < 0) {
 		/* Negative constraint means "never suspend". */
 		retval = -EPERM;
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d233a8b..89c61ba 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1634,11 +1634,14 @@ static int __cpufreq_set_policy(struct cpufreq_policy *data,
 				struct cpufreq_policy *policy)
 {
 	int ret = 0;
+	struct device *dev = get_cpu_device(policy->cpu);
 	unsigned int pmin = policy->min;
 	unsigned int pmax = policy->max;
-	unsigned int qmin = min(pm_qos_request(PM_QOS_CPU_FREQ_MIN),
+	unsigned int qmin = min(dev_pm_qos_read_value(dev,
+						      PM_QOS_CPU_FREQ_MIN),
 				data->max);
-	unsigned int qmax = max(pm_qos_request(PM_QOS_CPU_FREQ_MAX),
+	unsigned int qmax = max(dev_pm_qos_read_value(dev,
+						      PM_QOS_CPU_FREQ_MAX),
 				data->min);
 
 	pr_debug("setting new policy for CPU %u: %u/%u - %u/%u kHz\n",
@@ -1930,23 +1933,22 @@ static struct notifier_block max_freq_notifier = {
 static int cpu_freq_notify(struct notifier_block *b,
 			   unsigned long l, void *v)
 {
-	int cpu;
-	pr_debug("PM QoS %s %lu\n",
-		 b == &min_freq_notifier ? "min" : "max", l);
-	for_each_online_cpu(cpu) {
-		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-		if (policy) {
-			cpufreq_update_policy(policy->cpu);
-			cpufreq_cpu_put(policy);
-		}
+	struct dev_pm_qos_request *req = v;
+	int cpu = req->dev->id;
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	pr_debug("CPU%d PM QoS %s: %lu\n",
+		 cpu, b == &min_freq_notifier ? "min" : "max", l);
+	if (policy) {
+		cpufreq_update_policy(policy->cpu);
+		cpufreq_cpu_put(policy);
 	}
+
 	return NOTIFY_OK;
 }
 
 static int __init cpufreq_core_init(void)
 {
 	int cpu;
-	int rc;
 
 	for_each_possible_cpu(cpu) {
 		per_cpu(cpufreq_policy_cpu, cpu) = -1;
@@ -1956,13 +1958,107 @@ static int __init cpufreq_core_init(void)
 	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
 	BUG_ON(!cpufreq_global_kobject);
 	register_syscore_ops(&cpufreq_syscore_ops);
-	rc = pm_qos_add_notifier(PM_QOS_CPU_FREQ_MIN,
-				 &min_freq_notifier);
-	BUG_ON(rc);
-	rc = pm_qos_add_notifier(PM_QOS_CPU_FREQ_MAX,
-				 &max_freq_notifier);
-	BUG_ON(rc);
 
 	return 0;
 }
 core_initcall(cpufreq_core_init);
+
+struct cpufreq_pm_qos {
+	struct pm_qos_object obj_min;
+	struct pm_qos_object obj_max;
+	char name_min[32];
+	char name_max[32];
+};
+static DEFINE_PER_CPU(struct cpufreq_pm_qos, cf_pq);
+
+static void *pm_qos_cpu_add(void *p)
+{
+	struct pm_qos_object *o = p;
+	struct dev_pm_qos_request *req = kzalloc(sizeof(*req), GFP_KERNEL);
+	struct device *dev = o->data;
+	BUG_ON(!dev);
+	if (!req)
+		return 0;
+	dev_pm_qos_add_request(dev, req, o->pm_qos_dev_class,
+			       PM_QOS_DEFAULT_VALUE);
+	return req;
+}
+
+static s32 pm_qos_cpu_read(void *p)
+{
+	struct pm_qos_object *o = p;
+	struct device *dev = o->data;
+	BUG_ON(!dev);
+	return dev_pm_qos_read_value(dev, o->pm_qos_dev_class);
+}
+
+static void pm_qos_cpu_write(void *p, s32 value)
+{
+	struct pm_qos_object *o = p;
+	struct dev_pm_qos_request *req = o->req;
+	dev_pm_qos_update_request(req, value);
+}
+
+static void pm_qos_cpu_remove(void *p)
+{
+	struct pm_qos_object *o = p;
+	struct dev_pm_qos_request *req = o->req;
+	dev_pm_qos_remove_request(req);
+	kfree(req);
+	o->req = 0;
+}
+
+static int __init cpufreq_pm_qos_init(void)
+{
+	int cpu;
+	int rc;
+
+	for_each_possible_cpu(cpu) {
+		struct device *dev = get_cpu_device(cpu);
+		if (!dev) {
+			pr_info("CPU%d: skipping\n", cpu);
+			continue;
+		}
+		rc = dev_pm_qos_constraints_allocate(dev);
+		BUG_ON(rc);
+		/* register interface for min freq */
+		sprintf(per_cpu(cf_pq, cpu).name_min, "cpu%d_freq_min", cpu);
+		per_cpu(cf_pq, cpu).obj_min.name
+			= per_cpu(cf_pq, cpu).name_min;
+		per_cpu(cf_pq, cpu).obj_min.constraints =
+			&dev->power.constraints[PM_QOS_CPU_FREQ_MIN];
+		per_cpu(cf_pq, cpu).obj_min.add = pm_qos_cpu_add;
+		per_cpu(cf_pq, cpu).obj_min.read = pm_qos_cpu_read;
+		per_cpu(cf_pq, cpu).obj_min.write = pm_qos_cpu_write;
+		per_cpu(cf_pq, cpu).obj_min.remove = pm_qos_cpu_remove;
+		per_cpu(cf_pq, cpu).obj_min.data = dev;
+		per_cpu(cf_pq, cpu).obj_min.pm_qos_dev_class
+			= PM_QOS_CPU_FREQ_MIN;
+		rc = pm_qos_register_misc(&per_cpu(cf_pq, cpu).obj_min);
+		BUG_ON(rc);
+		/* register interface for max freq */
+		sprintf(per_cpu(cf_pq, cpu).name_max, "cpu%d_freq_max", cpu);
+		per_cpu(cf_pq, cpu).obj_max.constraints =
+			&dev->power.constraints[PM_QOS_CPU_FREQ_MAX];
+		per_cpu(cf_pq, cpu).obj_max.name
+			= per_cpu(cf_pq, cpu).name_max;
+		per_cpu(cf_pq, cpu).obj_max.add = pm_qos_cpu_add;
+		per_cpu(cf_pq, cpu).obj_max.read = pm_qos_cpu_read;
+		per_cpu(cf_pq, cpu).obj_max.write = pm_qos_cpu_write;
+		per_cpu(cf_pq, cpu).obj_max.remove = pm_qos_cpu_remove;
+		per_cpu(cf_pq, cpu).obj_max.data = dev;
+		per_cpu(cf_pq, cpu).obj_max.pm_qos_dev_class
+			= PM_QOS_CPU_FREQ_MAX;
+		rc = pm_qos_register_misc(&per_cpu(cf_pq, cpu).obj_max);
+		BUG_ON(rc);
+		rc = dev_pm_qos_add_notifier(dev, PM_QOS_CPU_FREQ_MIN,
+					     &min_freq_notifier);
+		BUG_ON(rc);
+		rc = dev_pm_qos_add_notifier(dev, PM_QOS_CPU_FREQ_MAX,
+					     &max_freq_notifier);
+		BUG_ON(rc);
+	}
+
+	return 0;
+}
+late_initcall(cpufreq_pm_qos_init);
diff --git a/drivers/input/input-cfboost.c b/drivers/input/input-cfboost.c
index bef3ec5..52f0a38 100644
--- a/drivers/input/input-cfboost.c
+++ b/drivers/input/input-cfboost.c
@@ -25,6 +25,7 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/pm_qos.h>
+#include <linux/cpu.h>
 
 /* This module listens to input events and sets a temporary frequency
  * floor upon input event detection. This is based on changes to
@@ -48,7 +49,7 @@ MODULE_DESCRIPTION("Input event CPU frequency booster");
 MODULE_LICENSE("GPL v2");
 
 
-static struct pm_qos_request qos_req;
+static DEFINE_PER_CPU(struct dev_pm_qos_request, qos_req);
 static struct work_struct boost;
 static struct delayed_work unboost;
 static unsigned int boost_freq; /* kHz */
@@ -59,14 +60,21 @@ static struct workqueue_struct *cfb_wq;
 
 static void cfb_boost(struct work_struct *w)
 {
+	int cpu;
 	cancel_delayed_work_sync(&unboost);
-	pm_qos_update_request(&qos_req, boost_freq);
+	for_each_online_cpu(cpu) {
+		dev_pm_qos_update_request(&per_cpu(qos_req, cpu), boost_freq);
+	}
 	queue_delayed_work(cfb_wq, &unboost, msecs_to_jiffies(boost_time));
 }
 
 static void cfb_unboost(struct work_struct *w)
 {
-	pm_qos_update_request(&qos_req, PM_QOS_DEFAULT_VALUE);
+	int cpu;
+	for_each_online_cpu(cpu) {
+		dev_pm_qos_update_request(&per_cpu(qos_req, cpu),
+					  PM_QOS_DEFAULT_VALUE);
+	}
 }
 
 static void cfb_input_event(struct input_handle *handle, unsigned int type,
@@ -142,6 +150,7 @@ static struct input_handler cfb_input_handler = {
 static int __init cfboost_init(void)
 {
 	int ret;
+	int cpu;
 
 	cfb_wq = create_workqueue("icfb-wq");
 	if (!cfb_wq)
@@ -153,13 +162,19 @@ static int __init cfboost_init(void)
 		destroy_workqueue(cfb_wq);
 		return ret;
 	}
-	pm_qos_add_request(&qos_req, PM_QOS_CPU_FREQ_MIN,
-			   PM_QOS_DEFAULT_VALUE);
+	for_each_possible_cpu(cpu) {
+		struct device *dev = get_cpu_device(cpu);
+		dev_pm_qos_add_request(dev, &per_cpu(qos_req, cpu),
+				       PM_QOS_CPU_FREQ_MIN,
+				       PM_QOS_DEFAULT_VALUE);
+	}
 	return 0;
 }
 
 static void __exit cfboost_exit(void)
 {
+	int cpu;
+
 	/* stop input events */
 	input_unregister_handler(&cfb_input_handler);
 	/* cancel pending work requests */
@@ -167,7 +182,9 @@ static void __exit cfboost_exit(void)
 	cancel_delayed_work_sync(&unboost);
 	/* clean up */
 	destroy_workqueue(cfb_wq);
-	pm_qos_remove_request(&qos_req);
+	for_each_possible_cpu(cpu) {
+		dev_pm_qos_remove_request(&per_cpu(qos_req, cpu));
+	}
 }
 
 module_init(cfboost_init);
diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 8825fe3..9f68c98 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -129,7 +129,8 @@ static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
 	} else if (!ts->low_latency_req.dev) {
 		/* First contact, request 100 us latency. */
 		dev_pm_qos_add_ancestor_request(&ts->client->dev,
-						&ts->low_latency_req, 100);
+						&ts->low_latency_req,
+						PM_QOS_DEV_LATENCY, 100);
 	}
 
 	/* SYN_REPORT */
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index fedda35..843dc22 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -9,19 +9,27 @@
 #include <linux/miscdevice.h>
 #include <linux/device.h>
 
+/* Global */
 enum {
 	PM_QOS_RESERVED = 0,
 	PM_QOS_CPU_DMA_LATENCY,
 	PM_QOS_NETWORK_LATENCY,
 	PM_QOS_NETWORK_THROUGHPUT,
-	PM_QOS_CPU_FREQ_MIN,
-	PM_QOS_CPU_FREQ_MAX,
 
 	/* insert new class ID */
 
 	PM_QOS_NUM_CLASSES,
 };
 
+/* Per device */
+enum {
+	PM_QOS_DEV_LATENCY,
+	PM_QOS_CPU_FREQ_MIN,
+	PM_QOS_CPU_FREQ_MAX,
+
+	PM_QOS_DEV_NUM_CLASSES,
+};
+
 #define PM_QOS_DEFAULT_VALUE -1
 
 #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
@@ -39,6 +47,8 @@ struct pm_qos_request {
 struct dev_pm_qos_request {
 	struct plist_node node;
 	struct device *dev;
+	int dev_class;
+	int pm_qos_class;
 };
 
 enum pm_qos_type {
@@ -67,6 +77,20 @@ enum pm_qos_req_action {
 	PM_QOS_REMOVE_REQ	/* Remove an existing request */
 };
 
+struct pm_qos_object {
+	struct pm_qos_constraints *constraints;
+	struct miscdevice pm_qos_power_miscdev;
+	char *name;
+	int pm_qos_class;
+	int pm_qos_dev_class;
+	void *data;
+	void *req;
+	void *(*add)(void *);
+	s32 (*read)(void *);
+	void (*write)(void *, s32);
+	void (*remove)(void *);
+};
+
 static inline int dev_pm_qos_request_active(struct dev_pm_qos_request *req)
 {
 	return req->dev != 0;
@@ -84,25 +108,28 @@ void pm_qos_remove_request(struct pm_qos_request *req);
 int pm_qos_request(int pm_qos_class);
 int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier);
 int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier);
+int pm_qos_register_misc(struct pm_qos_object *qos);
 int pm_qos_request_active(struct pm_qos_request *req);
 s32 pm_qos_read_value(struct pm_qos_constraints *c);
 
-s32 __dev_pm_qos_read_value(struct device *dev);
-s32 dev_pm_qos_read_value(struct device *dev);
+s32 __dev_pm_qos_read_value(struct device *dev, int id);
+s32 dev_pm_qos_read_value(struct device *dev, int id);
 int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
-			   s32 value);
+			   int id, s32 value);
 int dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_value);
 int dev_pm_qos_remove_request(struct dev_pm_qos_request *req);
-int dev_pm_qos_add_notifier(struct device *dev,
+int dev_pm_qos_add_notifier(struct device *dev, int id,
 			    struct notifier_block *notifier);
-int dev_pm_qos_remove_notifier(struct device *dev,
+int dev_pm_qos_remove_notifier(struct device *dev, int id,
 			       struct notifier_block *notifier);
-int dev_pm_qos_add_global_notifier(struct notifier_block *notifier);
-int dev_pm_qos_remove_global_notifier(struct notifier_block *notifier);
+int dev_pm_qos_add_global_notifier(struct notifier_block *notifier, int id);
+int dev_pm_qos_remove_global_notifier(struct notifier_block *notifier, int id);
+int dev_pm_qos_constraints_allocate(struct device *dev);
 void dev_pm_qos_constraints_init(struct device *dev);
 void dev_pm_qos_constraints_destroy(struct device *dev);
 int dev_pm_qos_add_ancestor_request(struct device *dev,
-				    struct dev_pm_qos_request *req, s32 value);
+				    struct dev_pm_qos_request *req,
+				    int id, s32 value);
 #else
 static inline int pm_qos_update_target(struct pm_qos_constraints *c,
 				       struct plist_node *node,
@@ -138,6 +165,8 @@ static inline int pm_qos_add_notifier(int pm_qos_class,
 static inline int pm_qos_remove_notifier(int pm_qos_class,
 					 struct notifier_block *notifier)
 			{ return 0; }
+static inline int pm_qos_register_misc(struct pm_qos_object *qos)
+			{ return 0; }
 static inline int pm_qos_request_active(struct pm_qos_request *req)
 			{ return 0; }
 static inline s32 pm_qos_read_value(struct pm_qos_constraints *c)
@@ -168,6 +197,8 @@ static inline int dev_pm_qos_add_global_notifier(
 static inline int dev_pm_qos_remove_global_notifier(
 					struct notifier_block *notifier)
 			{ return 0; }
+static inline int dev_pm_qos_constraints_allocate(struct device *dev)
+			{ return 0; }
 static inline void dev_pm_qos_constraints_init(struct device *dev)
 {
 	dev->power.power_state = PMSG_ON;
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 04b744b..a3524ea 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -50,16 +50,22 @@
  * or pm_qos_object list and pm_qos_objects need to happen with pm_qos_lock
  * held, taken with _irqsave.  One lock to rule them all
  */
-struct pm_qos_object {
-	struct pm_qos_constraints *constraints;
-	struct miscdevice pm_qos_power_miscdev;
-	char *name;
-};
 
 static DEFINE_SPINLOCK(pm_qos_lock);
 
 static struct pm_qos_object null_pm_qos;
 
+static void *pm_qos_global_add(void *);
+static s32 pm_qos_global_read(void *);
+static void pm_qos_global_write(void *, s32);
+static void pm_qos_global_remove(void *);
+
+#define PM_QOS_OBJ_INIT				\
+	.add = pm_qos_global_add,		\
+	.read = pm_qos_global_read,		\
+	.write = pm_qos_global_write,		\
+	.remove = pm_qos_global_remove
+
 static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
 static struct pm_qos_constraints cpu_dma_constraints = {
 	.list = PLIST_HEAD_INIT(cpu_dma_constraints.list),
@@ -71,6 +77,7 @@ static struct pm_qos_constraints cpu_dma_constraints = {
 static struct pm_qos_object cpu_dma_pm_qos = {
 	.constraints = &cpu_dma_constraints,
 	.name = "cpu_dma_latency",
+	PM_QOS_OBJ_INIT,
 };
 
 static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
@@ -84,6 +91,7 @@ static struct pm_qos_constraints network_lat_constraints = {
 static struct pm_qos_object network_lat_pm_qos = {
 	.constraints = &network_lat_constraints,
 	.name = "network_latency",
+	PM_QOS_OBJ_INIT,
 };
 
 
@@ -98,44 +106,17 @@ static struct pm_qos_constraints network_tput_constraints = {
 static struct pm_qos_object network_throughput_pm_qos = {
 	.constraints = &network_tput_constraints,
 	.name = "network_throughput",
+	PM_QOS_OBJ_INIT,
 };
 
 
-static BLOCKING_NOTIFIER_HEAD(cpu_freq_min_notifier);
-static struct pm_qos_constraints cpu_freq_min_constraints = {
-	.list = PLIST_HEAD_INIT(cpu_freq_min_constraints.list),
-	.target_value = PM_QOS_CPU_FREQ_MIN_DEFAULT_VALUE,
-	.default_value = PM_QOS_CPU_FREQ_MIN_DEFAULT_VALUE,
-	.type = PM_QOS_MAX,
-	.notifiers = &cpu_freq_min_notifier,
-};
-static struct pm_qos_object cpu_freq_min_pm_qos = {
-	.constraints = &cpu_freq_min_constraints,
-	.name = "cpu_freq_min",
-};
-
-
-static BLOCKING_NOTIFIER_HEAD(cpu_freq_max_notifier);
-static struct pm_qos_constraints cpu_freq_max_constraints = {
-	.list = PLIST_HEAD_INIT(cpu_freq_max_constraints.list),
-	.target_value = PM_QOS_CPU_FREQ_MAX_DEFAULT_VALUE,
-	.default_value = PM_QOS_CPU_FREQ_MAX_DEFAULT_VALUE,
-	.type = PM_QOS_MIN,
-	.notifiers = &cpu_freq_max_notifier,
-};
-static struct pm_qos_object cpu_freq_max_pm_qos = {
-	.constraints = &cpu_freq_max_constraints,
-	.name = "cpu_freq_max",
-};
-
-
-static struct pm_qos_object *pm_qos_array[] = {
+#define PM_QOS_MAX_CLASSES (PM_QOS_NUM_CLASSES \
+			    + NR_CPUS * PM_QOS_DEV_NUM_CLASSES)
+static struct pm_qos_object *pm_qos_array[PM_QOS_MAX_CLASSES] = {
 	&null_pm_qos,
 	&cpu_dma_pm_qos,
 	&network_lat_pm_qos,
 	&network_throughput_pm_qos,
-	&cpu_freq_min_pm_qos,
-	&cpu_freq_max_pm_qos,
 };
 
 static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
@@ -234,7 +215,7 @@ int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
 	if (prev_value != curr_value) {
 		blocking_notifier_call_chain(c->notifiers,
 					     (unsigned long)curr_value,
-					     NULL);
+					     node);
 		return 1;
 	} else {
 		return 0;
@@ -382,22 +363,30 @@ int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier)
 }
 EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
 
+static int pm_qos_ifcount = 1;
+
 /* User space interface to PM QoS classes via misc devices */
-static int register_pm_qos_misc(struct pm_qos_object *qos)
+int pm_qos_register_misc(struct pm_qos_object *qos)
 {
 	qos->pm_qos_power_miscdev.minor = MISC_DYNAMIC_MINOR;
 	qos->pm_qos_power_miscdev.name = qos->name;
 	qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
-
+	if (pm_qos_array[pm_qos_ifcount] == 0)
+		pm_qos_array[pm_qos_ifcount] = qos;
+	else
+		BUG_ON(pm_qos_array[pm_qos_ifcount] != qos);
+	qos->pm_qos_class = pm_qos_ifcount;
+	++pm_qos_ifcount;
 	return misc_register(&qos->pm_qos_power_miscdev);
 }
+EXPORT_SYMBOL_GPL(pm_qos_register_misc);
 
 static int find_pm_qos_object_by_minor(int minor)
 {
 	int pm_qos_class;
 
 	for (pm_qos_class = 0;
-		pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_class++) {
+		pm_qos_class < pm_qos_ifcount; pm_qos_class++) {
 		if (minor ==
 			pm_qos_array[pm_qos_class]->pm_qos_power_miscdev.minor)
 			return pm_qos_class;
@@ -411,12 +400,13 @@ static int pm_qos_power_open(struct inode *inode, struct file *filp)
 
 	pm_qos_class = find_pm_qos_object_by_minor(iminor(inode));
 	if (pm_qos_class >= 0) {
-		struct pm_qos_request *req = kzalloc(sizeof(*req), GFP_KERNEL);
-		if (!req)
+		struct pm_qos_object *o = pm_qos_array[pm_qos_class];
+		void *p = o->add(o);
+		if (!p)
 			return -ENOMEM;
 
-		pm_qos_add_request(req, pm_qos_class, PM_QOS_DEFAULT_VALUE);
-		filp->private_data = req;
+		o->req = p;
+		filp->private_data = o;
 
 		return 0;
 	}
@@ -425,12 +415,8 @@ static int pm_qos_power_open(struct inode *inode, struct file *filp)
 
 static int pm_qos_power_release(struct inode *inode, struct file *filp)
 {
-	struct pm_qos_request *req;
-
-	req = filp->private_data;
-	pm_qos_remove_request(req);
-	kfree(req);
-
+	struct pm_qos_object *o = filp->private_data;
+	o->remove(o);
 	return 0;
 }
 
@@ -439,18 +425,8 @@ static ssize_t pm_qos_power_read(struct file *filp, char __user *buf,
 		size_t count, loff_t *f_pos)
 {
 	s32 value;
-	unsigned long flags;
-	struct pm_qos_request *req = filp->private_data;
-
-	if (!req)
-		return -EINVAL;
-	if (!pm_qos_request_active(req))
-		return -EINVAL;
-
-	spin_lock_irqsave(&pm_qos_lock, flags);
-	value = pm_qos_get_value(pm_qos_array[req->pm_qos_class]->constraints);
-	spin_unlock_irqrestore(&pm_qos_lock, flags);
-
+	struct pm_qos_object *o = filp->private_data;
+	value = o->read(o);
 	return simple_read_from_buffer(buf, count, f_pos, &value, sizeof(s32));
 }
 
@@ -458,7 +434,7 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
 		size_t count, loff_t *f_pos)
 {
 	s32 value;
-	struct pm_qos_request *req;
+	struct pm_qos_object *o;
 
 	if (count == sizeof(s32)) {
 		if (copy_from_user(&value, buf, sizeof(s32)))
@@ -489,22 +465,65 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
 		return -EINVAL;
 	}
 
-	req = filp->private_data;
-	pm_qos_update_request(req, value);
-
+	o = filp->private_data;
+	o->write(o, value);
 	return count;
 }
 
 
+static void *pm_qos_global_add(void *p)
+{
+	struct pm_qos_object *o = p;
+	struct pm_qos_request *req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return 0;
+	pm_qos_add_request(req, o->pm_qos_class, PM_QOS_DEFAULT_VALUE);
+	return req;
+}
+
+static s32 pm_qos_global_read(void *p)
+{
+	struct pm_qos_object *o = p;
+	unsigned long flags;
+	struct pm_qos_request *req = o->req;
+	s32 value;
+
+	if (!req)
+		return -EINVAL;
+	if (!pm_qos_request_active(req))
+		return -EINVAL;
+
+	spin_lock_irqsave(&pm_qos_lock, flags);
+	value = pm_qos_get_value(pm_qos_array[req->pm_qos_class]->constraints);
+	spin_unlock_irqrestore(&pm_qos_lock, flags);
+	return value;
+}
+
+static void pm_qos_global_write(void *p, s32 value)
+{
+	struct pm_qos_object *o = p;
+	struct pm_qos_request *req = o->req;
+	pm_qos_update_request(req, value);
+}
+
+static void pm_qos_global_remove(void *p)
+{
+	struct pm_qos_object *o = p;
+	struct pm_qos_request *req = o->req;
+	pm_qos_remove_request(req);
+	kfree(req);
+	o->req = 0;
+}
+
 static int __init pm_qos_power_init(void)
 {
 	int ret = 0;
 	int i;
 
-	BUILD_BUG_ON(ARRAY_SIZE(pm_qos_array) != PM_QOS_NUM_CLASSES);
+	BUILD_BUG_ON(ARRAY_SIZE(pm_qos_array) < PM_QOS_NUM_CLASSES);
 
 	for (i = 1; i < PM_QOS_NUM_CLASSES; i++) {
-		ret = register_pm_qos_misc(pm_qos_array[i]);
+		ret = pm_qos_register_misc(pm_qos_array[i]);
 		if (ret < 0) {
 			printk(KERN_ERR "pm_qos_param: %s setup failed\n",
 			       pm_qos_array[i]->name);
-- 
1.7.4.1
