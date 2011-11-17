From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/6][resend] cpuidle : move code to prevent
	forward declaration
Date: Thu, 17 Nov 2011 11:26:35 +0100
Message-ID: <1321525600-2466-2-git-send-email-daniel.lezcano__42215.2429273867$1321526077$gmane$org@linaro.org>
References: <1321525600-2466-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1321525600-2466-1-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, rob.lee@linaro.org
List-Id: linux-pm@vger.kernel.org

A mindless change by moving __cpuidle_register_device and cpuidle_register_device
up in the code and hence preventing the forward declaration.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c |  116 ++++++++++++++++++++++-----------------------
 1 files changed, 57 insertions(+), 59 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 7a57b11..e0e2a02 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -50,8 +50,6 @@ static void cpuidle_kick_cpus(void)
 static void cpuidle_kick_cpus(void) {}
 #endif
 
-static int __cpuidle_register_device(struct cpuidle_device *dev);
-
 /**
  * cpuidle_idle_call - the main idle loop
  *
@@ -202,6 +200,63 @@ static void poll_idle_init(struct cpuidle_driver *drv) {}
 #endif /* CONFIG_ARCH_HAS_CPU_RELAX */
 
 /**
+ * __cpuidle_register_device - internal register function called before register
+ * and enable routines
+ * @dev: the cpu
+ *
+ * cpuidle_lock mutex must be held before this is called
+ */
+static int __cpuidle_register_device(struct cpuidle_device *dev)
+{
+	int ret;
+	struct sys_device *sys_dev = get_cpu_sysdev((unsigned long)dev->cpu);
+	struct cpuidle_driver *cpuidle_driver = cpuidle_get_driver();
+
+	if (!sys_dev)
+		return -EINVAL;
+	if (!try_module_get(cpuidle_driver->owner))
+		return -EINVAL;
+
+	init_completion(&dev->kobj_unregister);
+
+	per_cpu(cpuidle_devices, dev->cpu) = dev;
+	list_add(&dev->device_list, &cpuidle_detected_devices);
+	if ((ret = cpuidle_add_sysfs(sys_dev))) {
+		module_put(cpuidle_driver->owner);
+		return ret;
+	}
+
+	dev->registered = 1;
+	return 0;
+}
+
+/**
+ * cpuidle_register_device - registers a CPU's idle PM feature
+ * @dev: the cpu
+ */
+int cpuidle_register_device(struct cpuidle_device *dev)
+{
+	int ret;
+
+	mutex_lock(&cpuidle_lock);
+
+	if ((ret = __cpuidle_register_device(dev))) {
+		mutex_unlock(&cpuidle_lock);
+		return ret;
+	}
+
+	cpuidle_enable_device(dev);
+	cpuidle_install_idle_handler();
+
+	mutex_unlock(&cpuidle_lock);
+
+	return 0;
+
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_register_device);
+
+/**
  * cpuidle_enable_device - enables idle PM for a CPU
  * @dev: the CPU
  *
@@ -281,63 +336,6 @@ void cpuidle_disable_device(struct cpuidle_device *dev)
 EXPORT_SYMBOL_GPL(cpuidle_disable_device);
 
 /**
- * __cpuidle_register_device - internal register function called before register
- * and enable routines
- * @dev: the cpu
- *
- * cpuidle_lock mutex must be held before this is called
- */
-static int __cpuidle_register_device(struct cpuidle_device *dev)
-{
-	int ret;
-	struct sys_device *sys_dev = get_cpu_sysdev((unsigned long)dev->cpu);
-	struct cpuidle_driver *cpuidle_driver = cpuidle_get_driver();
-
-	if (!sys_dev)
-		return -EINVAL;
-	if (!try_module_get(cpuidle_driver->owner))
-		return -EINVAL;
-
-	init_completion(&dev->kobj_unregister);
-
-	per_cpu(cpuidle_devices, dev->cpu) = dev;
-	list_add(&dev->device_list, &cpuidle_detected_devices);
-	if ((ret = cpuidle_add_sysfs(sys_dev))) {
-		module_put(cpuidle_driver->owner);
-		return ret;
-	}
-
-	dev->registered = 1;
-	return 0;
-}
-
-/**
- * cpuidle_register_device - registers a CPU's idle PM feature
- * @dev: the cpu
- */
-int cpuidle_register_device(struct cpuidle_device *dev)
-{
-	int ret;
-
-	mutex_lock(&cpuidle_lock);
-
-	if ((ret = __cpuidle_register_device(dev))) {
-		mutex_unlock(&cpuidle_lock);
-		return ret;
-	}
-
-	cpuidle_enable_device(dev);
-	cpuidle_install_idle_handler();
-
-	mutex_unlock(&cpuidle_lock);
-
-	return 0;
-
-}
-
-EXPORT_SYMBOL_GPL(cpuidle_register_device);
-
-/**
  * cpuidle_unregister_device - unregisters a CPU's idle PM feature
  * @dev: the cpu
  */
-- 
1.7.4.1
