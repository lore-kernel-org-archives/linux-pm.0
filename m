From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] cpuidle : use percpu cpuidle in the core code
Date: Fri, 30 Mar 2012 12:48:19 +0200
Message-ID: <1333104499-8627-1-git-send-email-daniel.lezcano@linaro.org>
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
To: lenb@kernel.org
Cc: linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

The usual cpuidle initialization routines are to register the
driver, then register a cpuidle device per cpu.

With the device's state count default initialization with the
driver's state count, the code initialization remains mostly the
same in the different drivers.

We can then add a new function 'cpuidle_register' where we register
the driver and the devices. These devices can be defined in a global
static variable in cpuidle.c. We will be able to factor out and
remove a lot of duplicate lines of code.

As we still have some drivers, with different initialization routines,
we keep 'cpuidle_register_driver' and 'cpuidle_register_device' as low
level initialization routines to do some specific operations on the
cpuidle devices.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c |   34 ++++++++++++++++++++++++++++++++++
 include/linux/cpuidle.h   |    3 +++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index b8a1faf..2a174e8 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -23,6 +23,7 @@
 #include "cpuidle.h"
 
 DEFINE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
+DEFINE_PER_CPU(struct cpuidle_device, cpuidle_device);
 
 DEFINE_MUTEX(cpuidle_lock);
 LIST_HEAD(cpuidle_detected_devices);
@@ -391,6 +392,39 @@ int cpuidle_register_device(struct cpuidle_device *dev)
 
 EXPORT_SYMBOL_GPL(cpuidle_register_device);
 
+int cpuidle_register(struct cpuidle_driver *drv)
+{
+	int ret, cpu;
+	struct cpuidle_device *dev;
+
+	ret = cpuidle_register_driver(drv);
+	if (ret)
+		return ret;
+
+	for_each_online_cpu(cpu) {
+		dev = &per_cpu(cpuidle_device, cpu);
+		dev->cpu = cpu;
+
+		ret = cpuidle_register_device(dev);
+		if (ret)
+			goto out_unregister;
+	}
+
+out:
+	return ret;
+
+out_unregister:
+	for_each_online_cpu(cpu) {
+		dev = &per_cpu(cpuidle_device, cpu);
+		cpuidle_unregister_device(dev);
+	}
+
+	cpuidle_unregister_driver(drv);
+
+	goto out;
+}
+EXPORT_SYMBOL_GPL(cpuidle_register);
+
 /**
  * cpuidle_unregister_device - unregisters a CPU's idle PM feature
  * @dev: the cpu
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index f3ebbba..17e3d33 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -133,6 +133,7 @@ struct cpuidle_driver {
 #ifdef CONFIG_CPU_IDLE
 extern void disable_cpuidle(void);
 extern int cpuidle_idle_call(void);
+extern int cpuidle_register(struct cpuidle_driver *drv);
 extern int cpuidle_register_driver(struct cpuidle_driver *drv);
 struct cpuidle_driver *cpuidle_get_driver(void);
 extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
@@ -150,6 +151,8 @@ extern int cpuidle_wrap_enter(struct cpuidle_device *dev,
 #else
 static inline void disable_cpuidle(void) { }
 static inline int cpuidle_idle_call(void) { return -ENODEV; }
+static inline int cpuidle_register(struct cpuidle_driver *drv)
+{return -ENODEV; }
 static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
 {return -ENODEV; }
 static inline struct cpuidle_driver *cpuidle_get_driver(void) {return NULL; }
-- 
1.7.5.4
