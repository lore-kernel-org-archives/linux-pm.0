From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v2 1/5] PM / OPP: Introduce a power estimation helper
Date: Wed, 30 Jan 2019 17:05:02 +0000
Message-ID: <20190130170506.20450-2-quentin.perret@arm.com>
References: <20190130170506.20450-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130170506.20450-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org, mka@chromium.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

The Energy Model (EM) framework provides an API to let drivers register
the active power of CPUs. The drivers are expected to provide a callback
method which estimates the power consumed by a CPU at each available
performance levels. How exactly this should be implemented, however,
depends on the platform.

On some systems, PM_OPP knows the voltage and frequency at which CPUs
can run. When coupled with the CPU 'capacitance' (as provided by the
'dynamic-power-coefficient' devicetree binding), it is possible to
estimate the dynamic power consumption of a CPU as P = C * V^2 * f, with
C its capacitance and V and f respectively the voltage and frequency of
the OPP. The Intelligent Power Allocator (IPA) thermal governor already
implements that estimation method, in the thermal framework.

However, this power estimation method can be applied to any platform
where all the parameters are known (C, V and f), and not only those
suffering thermal issues. As such, the code implementing this feature
can be re-used to also populate the EM framework now used by EAS.

As a first step, introduce in PM_OPP a helper function which CPUFreq
drivers can use to register into the EM framework. This duplicates the
power estimation done in IPA until it can be migrated to using the EM
framework. This will be done later, once the EM framework has support
for at least all platforms currently supported by IPA.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>

---

Matthias: Given this patch changed a bit I dropped your Reviewed-by and
Tested-by, but let me know if you think they still hold.
---
 drivers/opp/of.c       | 88 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 +++
 2 files changed, 94 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 06f0f632ec47..4c8bf172e9ed 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -20,6 +20,7 @@
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/energy_model.h>
 
 #include "opp.h"
 
@@ -1047,3 +1048,90 @@ struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 	return of_node_get(opp->np);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
+
+/*
+ * Callback function provided to the Energy Model framework upon registration.
+ * This computes the power estimated by @CPU at the first OPP above @kHz (ceil),
+ * and updates @kHz and @mW accordingly. The power is estimated as
+ * P = C * V^2 * f with C being the CPU's capacitance and V and f respectively
+ * the voltage and frequency of the OPP.
+ *
+ * Returns -ENODEV if the CPU device cannot be found, -EINVAL if the power
+ * calculation failed because of missing parameters, 0 otherwise.
+ */
+static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
+					 int cpu)
+{
+	struct device *cpu_dev;
+	struct dev_pm_opp *opp;
+	struct device_node *np;
+	unsigned long mV, Hz;
+	u32 cap;
+	u64 tmp;
+	int ret;
+
+	cpu_dev = get_cpu_device(cpu);
+	if (!cpu_dev)
+		return -ENODEV;
+
+	np = of_node_get(cpu_dev->of_node);
+	if (!np)
+		return -EINVAL;
+
+	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
+	of_node_put(np);
+	if (ret)
+		return -EINVAL;
+
+	Hz = *kHz * 1000;
+	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
+	if (IS_ERR(opp))
+		return -EINVAL;
+
+	mV = dev_pm_opp_get_voltage(opp) / 1000;
+	dev_pm_opp_put(opp);
+	if (!mV)
+		return -EINVAL;
+
+	tmp = (u64)cap * mV * mV * (Hz / 1000000);
+	do_div(tmp, 1000000000);
+
+	*mW = (unsigned long)tmp;
+	*kHz = Hz / 1000;
+
+	return 0;
+}
+
+/**
+ * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
+ * @cpus	: CPUs for which an Energy Model has to be registered
+ * @nr_opp	: Number of OPPs to register in the Energy Model
+ *
+ * This checks whether the "dynamic-power-coefficient" devicetree binding has
+ * been specified, and tries to register an Energy Model with it if it has.
+ */
+void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
+{
+	struct em_data_callback em_cb = EM_DATA_CB(_get_cpu_power);
+	int ret, cpu = cpumask_first(cpus);
+	struct device *cpu_dev;
+	struct device_node *np;
+	u32 cap;
+
+	cpu_dev = get_cpu_device(cpu);
+	if (!cpu_dev)
+		return;
+
+	np = of_node_get(cpu_dev->of_node);
+	if (!np)
+		return;
+
+	/* Don't register an EM without the right DT binding */
+	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
+	of_node_put(np);
+	if (ret || !cap)
+		return;
+
+	em_register_perf_domain(cpus, nr_opp, &em_cb);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_register_em);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index b895f4e79868..58ae08b024bd 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -327,6 +327,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
 int of_get_required_opp_performance_state(struct device_node *np, int index);
+void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
@@ -365,6 +366,11 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 {
 	return NULL;
 }
+
+static inline void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
+{
+}
+
 static inline int of_get_required_opp_performance_state(struct device_node *np, int index)
 {
 	return -ENOTSUPP;
-- 
2.20.1
