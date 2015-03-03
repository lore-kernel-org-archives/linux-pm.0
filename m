From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/6] ARM: cpuidle: Add a cpuidle ops structure to be used for DT
Date: Tue,  3 Mar 2015 13:29:33 +0100
Message-ID: <1425385777-14766-3-git-send-email-daniel.lezcano@linaro.org>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Catalin.Marinas@arm.com, robherring2@gmail.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lina.iyer@linaro.org
List-Id: linux-pm@vger.kernel.org

The current state of the different cpuidle drivers is the different PM
operations are passed via the platform_data using the platform driver
paradigm.

This approach allowed to split the low level PM code from the arch specific
and the generic cpuidle code.

Unfortunately there are complains about this approach as, in the context of the
single kernel image, we have multiple drivers loaded in memory for nothing and
the platform driver is not adequate for cpuidle.

This patch provides a common interface via cpuidle ops for all new cpuidle
driver and a definition for the device tree.

It will allow with the next patches to a have a common definition with ARM64
and share the same cpuidle driver.

The code is optimized to use the __init section intensively in order to reduce
the memory footprint after the driver is initialized and unify the function
names with ARM64.

In order to prevent multiple declarations and the specific cpuidle ops to be
spread across the different headers, a mechanism, similar to the cgroup subsys,
has been introduced.

A new platform willing to add its cpuidle ops must add an entry in the file
cpuidle_ops.h in the current form:

 #if IS_ENABLED(CONFIG_ARM_FOO_CPUIDLE)
 CPUIDLE_OPS(foo)
 #endif

... and use the variable name in the specific low level code:

struct cpuidle_ops foo_cpuidle_ops;

The CPUIDLE_OPS macro will be processed in different way in the cpuidle.c file,
thus allowing to keep untouched the arm cpuidle core code in the future when
a new platform is added.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/include/asm/cpuidle.h     | 10 +++++
 arch/arm/include/asm/cpuidle_ops.h |  3 ++
 arch/arm/kernel/cpuidle.c          | 85 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/cpuidle.h   |  5 ++-
 4 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/asm/cpuidle_ops.h

diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
index 348dc81..3d31459 100644
--- a/arch/arm/include/asm/cpuidle.h
+++ b/arch/arm/include/asm/cpuidle.h
@@ -27,4 +27,14 @@ static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
  */
 #define ARM_CPUIDLE_WFI_STATE ARM_CPUIDLE_WFI_STATE_PWR(UINT_MAX)
 
+struct cpuidle_ops {
+	const char *name;
+	int (*suspend)(int cpu, unsigned long arg);
+	int (*init)(struct device_node *, int cpu);
+};
+
+extern int arm_cpuidle_suspend(int index);
+
+extern int arm_cpuidle_init(int cpu);
+
 #endif
diff --git a/arch/arm/include/asm/cpuidle_ops.h b/arch/arm/include/asm/cpuidle_ops.h
new file mode 100644
index 0000000..be0a612
--- /dev/null
+++ b/arch/arm/include/asm/cpuidle_ops.h
@@ -0,0 +1,3 @@
+/*
+ * List of cpuidle operations
+ */
diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index 45969f8..25e9789c 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -10,8 +10,29 @@
  */
 
 #include <linux/cpuidle.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <asm/cpuidle.h>
 
+#define CPUIDLE_OPS(__x) extern struct cpuidle_ops __x ## _cpuidle_ops;
+#include <asm/cpuidle_ops.h>
+#undef CPUIDLE_OPS
+
+#define CPUIDLE_OPS(__x) __x ## _cpuidle_ops_id,
+enum cpuidle_ops_id {
+#include <asm/cpuidle_ops.h>
+        CPUIDLE_OPS_COUNT,
+};
+#undef CPUIDLE_OPS
+
+#define CPUIDLE_OPS(__x) [__x ## _cpuidle_ops_id ] = &__x ## _cpuidle_ops,
+static struct cpuidle_ops *supported_cpuidle_ops[] __initconst = {
+#include <asm/cpuidle_ops.h>
+};
+#undef CPUIDLE_OPS
+
+static struct cpuidle_ops cpuidle_ops[NR_CPUS];
+
 int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
 {
@@ -19,3 +40,67 @@ int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
 
 	return index;
 }
+
+int arm_cpuidle_suspend(int index)
+{
+	int ret = -EOPNOTSUPP;
+	int cpu = smp_processor_id();
+
+	if (cpuidle_ops[cpu].suspend)
+		ret = cpuidle_ops[cpu].suspend(cpu, index);
+
+	return ret;
+}
+
+static struct cpuidle_ops *__init arm_cpuidle_get_ops(const char *name)
+{
+	int i;
+
+	for (i = 0; i < CPUIDLE_OPS_COUNT; i++) {
+		if (!strcmp(name, supported_cpuidle_ops[i]->name))
+			return supported_cpuidle_ops[i];
+	}
+
+	return NULL;
+}
+
+static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
+{
+	const char *enable_method;
+	struct cpuidle_ops *ops;
+
+	enable_method = of_get_property(dn, "enable-method", NULL);
+	if (!enable_method)
+		return -ENOENT;
+
+	ops = arm_cpuidle_get_ops(enable_method);
+	if (!ops) {
+		pr_warn("%s: unsupported enable-method property: %s\n",
+			dn->full_name, enable_method);
+		return -EOPNOTSUPP;
+	}
+
+	cpuidle_ops[cpu] = *ops; /* structure copy */
+
+	pr_notice("cpuidle: enable-method property '%s'"
+		  " found operations\n", ops->name);
+
+	return 0;
+}
+
+int __init arm_cpuidle_init(int cpu)
+{
+	int ret = -EOPNOTSUPP;
+	struct device_node *cpu_node = of_cpu_device_node_get(cpu);
+
+	if (!cpu_node)
+		return -ENODEV;
+
+	ret = arm_cpuidle_read_ops(cpu_node, cpu);
+	if (!ret && cpuidle_ops[cpu].init)
+		ret = cpuidle_ops[cpu].init(cpu_node, cpu);
+
+	of_node_put(cpu_node);
+
+	return ret;
+}
diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
index 0710654..1bee287 100644
--- a/arch/arm64/include/asm/cpuidle.h
+++ b/arch/arm64/include/asm/cpuidle.h
@@ -15,5 +15,8 @@ static inline int cpu_suspend(unsigned long arg)
 	return -EOPNOTSUPP;
 }
 #endif
-
+static inline int arm_cpuidle_suspend(int index)
+{
+	return cpu_suspend(index);
+}
 #endif
-- 
1.9.1
