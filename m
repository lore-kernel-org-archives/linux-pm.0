From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/8] ARM: cpuidle: Add a cpuidle ops structure to be used for
 DT
Date: Wed, 25 Mar 2015 10:07:10 +0100
Message-ID: <1427274436-21916-2-git-send-email-daniel.lezcano@linaro.org>
References: <55127A53.8050206@linaro.org>
 <1427274436-21916-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1427274436-21916-1-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@rjwysocki.net
Cc: lina.iyer@linaro.org, Lorenzo.Pieralisi@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The current state of the different cpuidle drivers is the different PM
operations are passed via the platform_data using the platform driver
paradigm.

This approach allowed to split the low level PM code from the arch specific
and the generic cpuidle code.

Unfortunately there are complaints about this approach as, in the context of the
single kernel image, we have multiple drivers loaded in memory for nothing and
the platform driver is not adequate for cpuidle.

This patch provides a common interface via cpuidle ops for all new cpuidle
driver and a definition for the device tree.

It will allow with the next patches to a have a common definition with ARM64
and share the same cpuidle driver.

The code is optimized to use the __init section intensively in order to reduce
the memory footprint after the driver is initialized and unify the function
names with ARM64.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Kevin Hilman <khilman@linaro.org>
Acked-by: Rob Herring <robherring2@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/include/asm/cpuidle.h    | 21 ++++++++++++
 arch/arm/kernel/cpuidle.c         | 72 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/cpuidle.h  |  5 ++-
 include/asm-generic/vmlinux.lds.h |  2 ++
 4 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
index 348dc81..0f84249 100644
--- a/arch/arm/include/asm/cpuidle.h
+++ b/arch/arm/include/asm/cpuidle.h
@@ -27,4 +27,25 @@ static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
  */
 #define ARM_CPUIDLE_WFI_STATE ARM_CPUIDLE_WFI_STATE_PWR(UINT_MAX)
 
+struct device_node;
+
+struct cpuidle_ops {
+	int (*suspend)(int cpu, unsigned long arg);
+	int (*init)(struct device_node *, int cpu);
+};
+
+struct of_cpuidle_method {
+	const char *method;
+	struct cpuidle_ops *ops;
+};
+
+#define CPUIDLE_METHOD_OF_DECLARE(name, _method, _ops)			\
+	static const struct of_cpuidle_method __cpuidle_method_of_table_##name \
+	__used __section(__cpuidle_method_of_table)			\
+	= { .method = _method, .ops = _ops }
+
+extern int arm_cpuidle_suspend(int index);
+
+extern int arm_cpuidle_init(int cpu);
+
 #endif
diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index 45969f8..2b0dae3 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -10,8 +10,17 @@
  */
 
 #include <linux/cpuidle.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <asm/cpuidle.h>
 
+extern struct of_cpuidle_method __cpuidle_method_of_table[];
+
+static const struct of_cpuidle_method __cpuidle_method_of_table_sentinel
+	__used __section(__cpuidle_method_of_table_end);
+
+static struct cpuidle_ops cpuidle_ops[NR_CPUS];
+
 int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
 {
@@ -19,3 +28,66 @@ int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
 
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
+static struct cpuidle_ops *__init arm_cpuidle_get_ops(const char *method)
+{
+	struct of_cpuidle_method *m = __cpuidle_method_of_table;
+
+	for (; m->method; m++)
+		if (!strcmp(m->method, method))
+			return m->ops;
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
+		  " found operations\n", enable_method);
+
+	return 0;
+}
+
+int __init arm_cpuidle_init(int cpu)
+{
+	struct device_node *cpu_node = of_cpu_device_node_get(cpu);
+	int ret;
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
index c60643f..460a38b 100644
--- a/arch/arm64/include/asm/cpuidle.h
+++ b/arch/arm64/include/asm/cpuidle.h
@@ -17,5 +17,8 @@ static inline int cpu_suspend(unsigned long arg)
 	return -EOPNOTSUPP;
 }
 #endif
-
+static inline int arm_cpuidle_suspend(int index)
+{
+	return cpu_suspend(index);
+}
 #endif
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ac78910..91c0930 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -167,6 +167,7 @@
 #define IOMMU_OF_TABLES()	OF_TABLE(CONFIG_OF_IOMMU, iommu)
 #define RESERVEDMEM_OF_TABLES()	OF_TABLE(CONFIG_OF_RESERVED_MEM, reservedmem)
 #define CPU_METHOD_OF_TABLES()	OF_TABLE(CONFIG_SMP, cpu_method)
+#define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
 #define EARLYCON_OF_TABLES()	OF_TABLE(CONFIG_SERIAL_EARLYCON, earlycon)
 
 #define KERNEL_DTB()							\
@@ -501,6 +502,7 @@
 	CLKSRC_OF_TABLES()						\
 	IOMMU_OF_TABLES()						\
 	CPU_METHOD_OF_TABLES()						\
+	CPUIDLE_METHOD_OF_TABLES()					\
 	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()					\
 	EARLYCON_OF_TABLES()
-- 
1.9.1
