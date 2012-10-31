From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V3 4/4] cpuidle: support multiple drivers
Date: Wed, 31 Oct 2012 17:44:48 +0100
Message-ID: <1351701888-19963-5-git-send-email-daniel.lezcano@linaro.org>
References: <1351701888-19963-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1351701888-19963-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org
Cc: pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

With the tegra3 and the big.LITTLE [1] new architectures, several cpus
with different characteristics (latencies and states) can co-exists on the
system.

The cpuidle framework has the limitation of handling only identical cpus.

This patch removes this limitation by introducing the multiple driver support
for cpuidle.

This option is configurable at compile time and should be enabled for the
architectures mentioned above. So there is no impact for the other platforms
if the option is disabled. The option defaults to 'n'. Note the multiple drivers
support is also compatible with the existing drivers, even if just one driver is
needed, all the cpu will be tied to this driver using an extra small chunk of
processor memory.

The multiple driver support use a per-cpu driver pointer instead of a global
variable and the accessor to this variable are done from a cpu context.

In order to keep the compatibility with the existing drivers, the function
'cpuidle_register_driver' and 'cpuidle_unregister_driver' will register
the specified driver for all the cpus.

The semantic for the output of /sys/devices/system/cpu/cpuidle/current_driver
remains the same except the driver name will be related to the current cpu.

The /sys/devices/system/cpu/cpu[0-9]/cpuidle/driver/name files are added
allowing to read the per cpu driver name.

[1] http://lwn.net/Articles/481055/


Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/cpuidle/Kconfig   |    9 +++
 drivers/cpuidle/cpuidle.c |   36 ++++++----
 drivers/cpuidle/cpuidle.h |    4 +-
 drivers/cpuidle/driver.c  |  166 ++++++++++++++++++++++++++++++++++++++-----
 drivers/cpuidle/sysfs.c   |  174 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/cpuidle.h   |    7 ++-
 6 files changed, 356 insertions(+), 40 deletions(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index a76b689..234ae65 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -9,6 +9,15 @@ config CPU_IDLE
 
 	  If you're using an ACPI-enabled platform, you should say Y here.
 
+config CPU_IDLE_MULTIPLE_DRIVERS
+        bool "Support multiple cpuidle drivers"
+        depends on CPU_IDLE
+        default n
+        help
+         Allows the cpuidle framework to use different drivers for each CPU.
+         This is useful if you have a system with different CPU latencies and
+         states. If unsure say N.
+
 config CPU_IDLE_GOV_LADDER
 	bool
 	depends on CPU_IDLE
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index ce4cac7..711dd83 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -68,7 +68,7 @@ static cpuidle_enter_t cpuidle_enter_ops;
 int cpuidle_play_dead(void)
 {
 	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
-	struct cpuidle_driver *drv = cpuidle_get_driver();
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
 	int i, dead_state = -1;
 	int power_usage = -1;
 
@@ -128,7 +128,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 int cpuidle_idle_call(void)
 {
 	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
-	struct cpuidle_driver *drv = cpuidle_get_driver();
+	struct cpuidle_driver *drv;
 	int next_state, entered_state;
 
 	if (off)
@@ -141,6 +141,8 @@ int cpuidle_idle_call(void)
 	if (!dev || !dev->enabled)
 		return -EBUSY;
 
+	drv = cpuidle_get_cpu_driver(dev);
+
 	/* ask the governor for the next state */
 	next_state = cpuidle_curr_governor->select(drv, dev);
 	if (need_resched()) {
@@ -312,15 +314,19 @@ static void poll_idle_init(struct cpuidle_driver *drv) {}
 int cpuidle_enable_device(struct cpuidle_device *dev)
 {
 	int ret, i;
-	struct cpuidle_driver *drv = cpuidle_get_driver();
+	struct cpuidle_driver *drv;
 
 	if (!dev)
 		return -EINVAL;
 
 	if (dev->enabled)
 		return 0;
+
+	drv = cpuidle_get_cpu_driver(dev);
+
 	if (!drv || !cpuidle_curr_governor)
 		return -EIO;
+
 	if (!dev->state_count)
 		dev->state_count = drv->state_count;
 
@@ -335,7 +341,8 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 
 	poll_idle_init(drv);
 
-	if ((ret = cpuidle_add_state_sysfs(dev)))
+	ret = cpuidle_add_device_sysfs(dev);
+	if (ret)
 		return ret;
 
 	if (cpuidle_curr_governor->enable &&
@@ -356,7 +363,7 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 	return 0;
 
 fail_sysfs:
-	cpuidle_remove_state_sysfs(dev);
+	cpuidle_remove_device_sysfs(dev);
 
 	return ret;
 }
@@ -372,17 +379,20 @@ EXPORT_SYMBOL_GPL(cpuidle_enable_device);
  */
 void cpuidle_disable_device(struct cpuidle_device *dev)
 {
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+
 	if (!dev || !dev->enabled)
 		return;
-	if (!cpuidle_get_driver() || !cpuidle_curr_governor)
+
+	if (!drv || !cpuidle_curr_governor)
 		return;
 
 	dev->enabled = 0;
 
 	if (cpuidle_curr_governor->disable)
-		cpuidle_curr_governor->disable(cpuidle_get_driver(), dev);
+		cpuidle_curr_governor->disable(drv, dev);
 
-	cpuidle_remove_state_sysfs(dev);
+	cpuidle_remove_device_sysfs(dev);
 	enabled_devices--;
 }
 
@@ -398,9 +408,9 @@ EXPORT_SYMBOL_GPL(cpuidle_disable_device);
 static int __cpuidle_register_device(struct cpuidle_device *dev)
 {
 	int ret;
-	struct cpuidle_driver *cpuidle_driver = cpuidle_get_driver();
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
 
-	if (!try_module_get(cpuidle_driver->owner))
+	if (!try_module_get(drv->owner))
 		return -EINVAL;
 
 	per_cpu(cpuidle_devices, dev->cpu) = dev;
@@ -421,7 +431,7 @@ err_coupled:
 err_sysfs:
 	list_del(&dev->device_list);
 	per_cpu(cpuidle_devices, dev->cpu) = NULL;
-	module_put(cpuidle_driver->owner);
+	module_put(drv->owner);
 	return ret;
 }
 
@@ -460,7 +470,7 @@ EXPORT_SYMBOL_GPL(cpuidle_register_device);
  */
 void cpuidle_unregister_device(struct cpuidle_device *dev)
 {
-	struct cpuidle_driver *cpuidle_driver = cpuidle_get_driver();
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
 
 	if (dev->registered == 0)
 		return;
@@ -477,7 +487,7 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
 
 	cpuidle_resume_and_unlock();
 
-	module_put(cpuidle_driver->owner);
+	module_put(drv->owner);
 }
 
 EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
index f6b0923..ee97e96 100644
--- a/drivers/cpuidle/cpuidle.h
+++ b/drivers/cpuidle/cpuidle.h
@@ -28,8 +28,8 @@ struct device;
 
 extern int cpuidle_add_interface(struct device *dev);
 extern void cpuidle_remove_interface(struct device *dev);
-extern int cpuidle_add_state_sysfs(struct cpuidle_device *device);
-extern void cpuidle_remove_state_sysfs(struct cpuidle_device *device);
+extern int cpuidle_add_device_sysfs(struct cpuidle_device *device);
+extern void cpuidle_remove_device_sysfs(struct cpuidle_device *device);
 extern int cpuidle_add_sysfs(struct cpuidle_device *dev);
 extern void cpuidle_remove_sysfs(struct cpuidle_device *dev);
 
diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 8246662..465e256 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -14,9 +14,11 @@
 
 #include "cpuidle.h"
 
-static struct cpuidle_driver *cpuidle_curr_driver;
 DEFINE_SPINLOCK(cpuidle_driver_lock);
 
+static void __cpuidle_set_cpu_driver(struct cpuidle_driver *drv, int cpu);
+static struct cpuidle_driver * __cpuidle_get_cpu_driver(int cpu);
+
 static void set_power_states(struct cpuidle_driver *drv)
 {
 	int i;
@@ -47,12 +49,7 @@ static void __cpuidle_driver_init(struct cpuidle_driver *drv)
 		set_power_states(drv);
 }
 
-static void cpuidle_set_driver(struct cpuidle_driver *drv)
-{
-	cpuidle_curr_driver = drv;
-}
-
-static int __cpuidle_register_driver(struct cpuidle_driver *drv)
+static int __cpuidle_register_driver(struct cpuidle_driver *drv, int cpu)
 {
 	if (!drv || !drv->state_count)
 		return -EINVAL;
@@ -60,23 +57,84 @@ static int __cpuidle_register_driver(struct cpuidle_driver *drv)
 	if (cpuidle_disabled())
 		return -ENODEV;
 
-	if (cpuidle_get_driver())
+	if (__cpuidle_get_cpu_driver(cpu))
 		return -EBUSY;
 
 	__cpuidle_driver_init(drv);
 
-	cpuidle_set_driver(drv);
+	__cpuidle_set_cpu_driver(drv, cpu);
 
 	return 0;
 }
 
-static void __cpuidle_unregister_driver(struct cpuidle_driver *drv)
+static void __cpuidle_unregister_driver(struct cpuidle_driver *drv, int cpu)
 {
-	if (drv != cpuidle_get_driver())
+	if (drv != __cpuidle_get_cpu_driver(cpu))
 		return;
 
 	if (!WARN_ON(drv->refcnt > 0))
-		cpuidle_set_driver(NULL);
+		__cpuidle_set_cpu_driver(NULL, cpu);
+}
+
+#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
+
+DEFINE_PER_CPU(struct cpuidle_driver *, cpuidle_drivers);
+
+static void __cpuidle_set_cpu_driver(struct cpuidle_driver *drv, int cpu)
+{
+	per_cpu(cpuidle_drivers, cpu) = drv;
+}
+
+static struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
+{
+	return per_cpu(cpuidle_drivers, cpu);
+}
+
+static void __cpuidle_unregister_all_cpu_driver(struct cpuidle_driver *drv)
+{
+	int cpu;
+	for_each_present_cpu(cpu)
+		__cpuidle_unregister_driver(drv, cpu);
+}
+
+static int __cpuidle_register_all_cpu_driver(struct cpuidle_driver *drv)
+{
+	int ret = 0;
+	int i, cpu;
+
+	for_each_present_cpu(cpu) {
+		ret = __cpuidle_register_driver(drv, cpu);
+		if (ret)
+			break;
+	}
+
+	if (ret)
+		for_each_present_cpu(i) {
+			if (i == cpu)
+				break;
+			__cpuidle_unregister_driver(drv, i);
+		}
+
+
+	return ret;
+}
+
+int cpuidle_register_cpu_driver(struct cpuidle_driver *drv, int cpu)
+{
+	int ret;
+
+	spin_lock(&cpuidle_driver_lock);
+	ret = __cpuidle_register_driver(drv, cpu);
+	spin_unlock(&cpuidle_driver_lock);
+
+	return ret;
+}
+
+void cpuidle_unregister_cpu_driver(struct cpuidle_driver *drv, int cpu)
+{
+	spin_lock(&cpuidle_driver_lock);
+	__cpuidle_unregister_driver(drv, cpu);
+	spin_unlock(&cpuidle_driver_lock);
 }
 
 /**
@@ -88,7 +146,7 @@ int cpuidle_register_driver(struct cpuidle_driver *drv)
 	int ret;
 
 	spin_lock(&cpuidle_driver_lock);
-	ret = __cpuidle_register_driver(drv);
+	ret = __cpuidle_register_all_cpu_driver(drv);
 	spin_unlock(&cpuidle_driver_lock);
 
 	return ret;
@@ -96,13 +154,48 @@ int cpuidle_register_driver(struct cpuidle_driver *drv)
 EXPORT_SYMBOL_GPL(cpuidle_register_driver);
 
 /**
- * cpuidle_get_driver - return the current driver
+ * cpuidle_unregister_driver - unregisters a driver
+ * @drv: the driver
  */
-struct cpuidle_driver *cpuidle_get_driver(void)
+void cpuidle_unregister_driver(struct cpuidle_driver *drv)
+{
+	spin_lock(&cpuidle_driver_lock);
+	__cpuidle_unregister_all_cpu_driver(drv);
+	spin_unlock(&cpuidle_driver_lock);
+}
+EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
+
+#else
+
+static struct cpuidle_driver *cpuidle_curr_driver;
+
+static inline void __cpuidle_set_cpu_driver(struct cpuidle_driver *drv, int cpu)
+{
+	cpuidle_curr_driver = drv;
+}
+
+static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
 {
 	return cpuidle_curr_driver;
 }
-EXPORT_SYMBOL_GPL(cpuidle_get_driver);
+
+/**
+ * cpuidle_register_driver - registers a driver
+ * @drv: the driver
+ */
+int cpuidle_register_driver(struct cpuidle_driver *drv)
+{
+	int ret, cpu;
+
+	cpu = get_cpu();
+	spin_lock(&cpuidle_driver_lock);
+	ret = __cpuidle_register_driver(drv, cpu);
+	spin_unlock(&cpuidle_driver_lock);
+	put_cpu();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cpuidle_register_driver);
 
 /**
  * cpuidle_unregister_driver - unregisters a driver
@@ -110,11 +203,50 @@ EXPORT_SYMBOL_GPL(cpuidle_get_driver);
  */
 void cpuidle_unregister_driver(struct cpuidle_driver *drv)
 {
+	int cpu;
+
+	cpu = get_cpu();
 	spin_lock(&cpuidle_driver_lock);
-	__cpuidle_unregister_driver(drv);
+	__cpuidle_unregister_driver(drv, cpu);
 	spin_unlock(&cpuidle_driver_lock);
+	put_cpu();
 }
 EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
+#endif
+
+/**
+ * cpuidle_get_driver - return the current driver
+ */
+struct cpuidle_driver *cpuidle_get_driver(void)
+{
+	struct cpuidle_driver *drv;
+	int cpu;
+
+	cpu = get_cpu();
+	drv = __cpuidle_get_cpu_driver(cpu);
+	put_cpu();
+
+	return drv;
+}
+EXPORT_SYMBOL_GPL(cpuidle_get_driver);
+
+/**
+ * cpuidle_get_cpu_driver - return the driver tied with a cpu
+ */
+struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev)
+{
+	struct cpuidle_driver *drv;
+
+	if (!dev)
+		return NULL;
+
+	spin_lock(&cpuidle_driver_lock);
+	drv = __cpuidle_get_cpu_driver(dev->cpu);
+	spin_unlock(&cpuidle_driver_lock);
+
+	return drv;
+}
+EXPORT_SYMBOL_GPL(cpuidle_get_cpu_driver);
 
 struct cpuidle_driver *cpuidle_driver_ref(void)
 {
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 49b1f4bc..3409429 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -364,17 +364,17 @@ static inline void cpuidle_free_state_kobj(struct cpuidle_device *device, int i)
 }
 
 /**
- * cpuidle_add_driver_sysfs - adds driver-specific sysfs attributes
+ * cpuidle_add_state_sysfs - adds cpuidle states sysfs attributes
  * @device: the target device
  */
-int cpuidle_add_state_sysfs(struct cpuidle_device *device)
+static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
 {
 	int i, ret = -ENOMEM;
 	struct cpuidle_state_kobj *kobj;
-	struct cpuidle_driver *drv = cpuidle_get_driver();
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(device);
 
 	/* state statistics */
-	for (i = 0; i < device->state_count; i++) {
+	for (i = 0; i < drv->state_count; i++) {
 		kobj = kzalloc(sizeof(struct cpuidle_state_kobj), GFP_KERNEL);
 		if (!kobj)
 			goto error_state;
@@ -401,10 +401,10 @@ error_state:
 }
 
 /**
- * cpuidle_remove_driver_sysfs - removes driver-specific sysfs attributes
+ * cpuidle_remove_driver_sysfs - removes the cpuidle states sysfs attributes
  * @device: the target device
  */
-void cpuidle_remove_state_sysfs(struct cpuidle_device *device)
+static void cpuidle_remove_state_sysfs(struct cpuidle_device *device)
 {
 	int i;
 
@@ -412,6 +412,168 @@ void cpuidle_remove_state_sysfs(struct cpuidle_device *device)
 		cpuidle_free_state_kobj(device, i);
 }
 
+#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
+#define kobj_to_driver_kobj(k) container_of(k, struct cpuidle_driver_kobj, kobj)
+#define attr_to_driver_attr(a) container_of(a, struct cpuidle_driver_attr, attr)
+
+#define define_one_driver_ro(_name, show)                       \
+	static struct cpuidle_driver_attr attr_driver_##_name = \
+		__ATTR(_name, 0644, show, NULL)
+
+struct cpuidle_driver_kobj {
+	struct cpuidle_driver *drv;
+	struct completion kobj_unregister;
+	struct kobject kobj;
+};
+
+struct cpuidle_driver_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct cpuidle_driver *, char *);
+	ssize_t (*store)(struct cpuidle_driver *, const char *, size_t);
+};
+
+static ssize_t show_driver_name(struct cpuidle_driver *drv, char *buf)
+{
+	ssize_t ret;
+
+	spin_lock(&cpuidle_driver_lock);
+	ret = sprintf(buf, "%s\n", drv ? drv->name : "none");
+	spin_unlock(&cpuidle_driver_lock);
+
+	return ret;
+}
+
+static void cpuidle_driver_sysfs_release(struct kobject *kobj)
+{
+	struct cpuidle_driver_kobj *driver_kobj = kobj_to_driver_kobj(kobj);
+	complete(&driver_kobj->kobj_unregister);
+}
+
+static ssize_t cpuidle_driver_show(struct kobject *kobj, struct attribute * attr,
+				   char * buf)
+{
+	int ret = -EIO;
+	struct cpuidle_driver_kobj *driver_kobj = kobj_to_driver_kobj(kobj);
+	struct cpuidle_driver_attr *dattr = attr_to_driver_attr(attr);
+
+	if (dattr->show)
+		ret = dattr->show(driver_kobj->drv, buf);
+
+	return ret;
+}
+
+static ssize_t cpuidle_driver_store(struct kobject *kobj, struct attribute *attr,
+				    const char *buf, size_t size)
+{
+	int ret = -EIO;
+	struct cpuidle_driver_kobj *driver_kobj = kobj_to_driver_kobj(kobj);
+	struct cpuidle_driver_attr *dattr = attr_to_driver_attr(attr);
+
+	if (dattr->store)
+		ret = dattr->store(driver_kobj->drv, buf, size);
+
+	return ret;
+}
+
+define_one_driver_ro(name, show_driver_name);
+
+static const struct sysfs_ops cpuidle_driver_sysfs_ops = {
+	.show = cpuidle_driver_show,
+	.store = cpuidle_driver_store,
+};
+
+static struct attribute *cpuidle_driver_default_attrs[] = {
+	&attr_driver_name.attr,
+	NULL
+};
+
+static struct kobj_type ktype_driver_cpuidle = {
+	.sysfs_ops = &cpuidle_driver_sysfs_ops,
+	.default_attrs = cpuidle_driver_default_attrs,
+	.release = cpuidle_driver_sysfs_release,
+};
+
+/**
+ * cpuidle_add_driver_sysfs - adds the driver name sysfs attribute
+ * @device: the target device
+ */
+static int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
+{
+	struct cpuidle_driver_kobj *kdrv;
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+	int ret;
+
+	kdrv = kzalloc(sizeof(*kdrv), GFP_KERNEL);
+	if (!kdrv)
+		return -ENOMEM;
+
+	kdrv->drv = drv;
+	init_completion(&kdrv->kobj_unregister);
+
+	ret = kobject_init_and_add(&kdrv->kobj, &ktype_driver_cpuidle,
+				   &dev->kobj, "driver");
+	if (ret) {
+		kfree(kdrv);
+		return ret;
+	}
+
+	kobject_uevent(&kdrv->kobj, KOBJ_ADD);
+	dev->kobj_driver = kdrv;
+
+	return ret;
+}
+
+/**
+ * cpuidle_remove_driver_sysfs - removes the driver name sysfs attribute
+ * @device: the target device
+ */
+static void cpuidle_remove_driver_sysfs(struct cpuidle_device *dev)
+{
+	struct cpuidle_driver_kobj *kdrv = dev->kobj_driver;
+	kobject_put(&kdrv->kobj);
+	wait_for_completion(&kdrv->kobj_unregister);
+	kfree(kdrv);
+}
+#else
+static inline int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
+{
+	return 0;
+}
+
+static inline void cpuidle_remove_driver_sysfs(struct cpuidle_device *dev)
+{
+	;
+}
+#endif
+
+/**
+ * cpuidle_add_device_sysfs - adds device specific sysfs attributes
+ * @device: the target device
+ */
+int cpuidle_add_device_sysfs(struct cpuidle_device *device)
+{
+	int ret;
+
+	ret = cpuidle_add_state_sysfs(device);
+	if (ret)
+		return ret;
+
+	ret = cpuidle_add_driver_sysfs(device);
+	if (ret)
+		cpuidle_remove_state_sysfs(device);
+	return ret;
+}
+
+/**
+ * cpuidle_remove_device_sysfs : removes device specific sysfs attributes
+ * @device : the target device
+ */
+void cpuidle_remove_device_sysfs(struct cpuidle_device *device)
+{
+	cpuidle_remove_driver_sysfs(device);
+	cpuidle_remove_state_sysfs(device);
+}
+
 /**
  * cpuidle_add_sysfs - creates a sysfs instance for the target device
  * @dev: the target device
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index d08e1af..3711b34 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -91,7 +91,7 @@ struct cpuidle_device {
 	int			state_count;
 	struct cpuidle_state_usage	states_usage[CPUIDLE_STATE_MAX];
 	struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
-
+	struct cpuidle_driver_kobj *kobj_driver;
 	struct list_head 	device_list;
 	struct kobject		kobj;
 	struct completion	kobj_unregister;
@@ -157,6 +157,10 @@ extern int cpuidle_wrap_enter(struct cpuidle_device *dev,
 					struct cpuidle_driver *drv, int index));
 extern int cpuidle_play_dead(void);
 
+extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev);
+extern int cpuidle_register_cpu_driver(struct cpuidle_driver *drv, int cpu);
+extern void cpuidle_unregister_cpu_driver(struct cpuidle_driver *drv, int cpu);
+
 #else
 static inline void disable_cpuidle(void) { }
 static inline int cpuidle_idle_call(void) { return -ENODEV; }
@@ -183,7 +187,6 @@ static inline int cpuidle_wrap_enter(struct cpuidle_device *dev,
 					struct cpuidle_driver *drv, int index))
 { return -ENODEV; }
 static inline int cpuidle_play_dead(void) {return -ENODEV; }
-
 #endif
 
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
-- 
1.7.5.4
