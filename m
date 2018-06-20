From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v8 05/26] PM / Domains: Add helper functions to attach/detach CPUs to/from genpd
Date: Wed, 20 Jun 2018 19:22:05 +0200
Message-ID: <20180620172226.15012-6-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Introduce two new genpd helper functions, of_genpd_attach|detach_cpu(),
which takes the CPU-number as an in-parameter.

To attach a CPU to a genpd, of_genpd_attach_cpu() starts by fetching the
struct device belonging to the CPU. Then it calls genpd_dev_pm_attach(),
which via DT tries to hook up the CPU device to its corresponding PM
domain. If it succeeds, of_genpd_attach_cpu() continues to prepare/enable
runtime PM of the device.

To detach a CPU from its PM domain, of_genpd_attach_cpu() reverse the
operations made from of_genpd_attach_cpu(). However, first it checks that
the CPU device has a valid PM domain pointer assigned, as to make sure it
belongs to genpd.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 69 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  9 +++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6149ce0bfa7b..299fa2febbec 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2445,6 +2445,75 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
 
+/*
+ * of_genpd_attach_cpu() - Attach a CPU to its PM domain
+ * @cpu: The CPU to be attached.
+ *
+ * Parses the OF node of the CPU's device, to find a PM domain specifier. If
+ * such is found, attaches the CPU's device to the retrieved pm_domain ops and
+ * enables runtime PM for it. This to allow the CPU to be power managed through
+ * its PM domain.
+ *
+ * Returns zero when successfully attached the CPU's device to its PM domain,
+ * else a negative error code.
+ */
+int of_genpd_attach_cpu(int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+	int ret;
+
+	if (!dev) {
+		pr_warn("genpd: no dev for cpu%d\n", cpu);
+		return -ENODEV;
+	}
+
+	ret = genpd_dev_pm_attach(dev);
+	if (ret != 1) {
+		dev_warn(dev, "genpd: attach cpu failed %d\n", ret);
+		return ret < 0 ? ret : -ENODEV;
+	}
+
+	pm_runtime_irq_safe(dev);
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	dev_info(dev, "genpd: attached cpu\n");
+	return 0;
+}
+EXPORT_SYMBOL(of_genpd_attach_cpu);
+
+/**
+ * of_genpd_detach_cpu() - Detach a CPU from its PM domain
+ * @cpu: The CPU to be detached.
+ *
+ * Detach the CPU's device from its corresponding PM domain. If detaching is
+ * completed successfully, disable runtime PM and restore the runtime PM usage
+ * count for the CPU's device.
+ */
+void of_genpd_detach_cpu(int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	if (!dev) {
+		pr_warn("genpd: no dev for cpu%d\n", cpu);
+		return;
+	}
+
+	/* Check that the device is attached to a genpd. */
+	if (!(dev->pm_domain && dev->pm_domain->detach == genpd_dev_pm_detach))
+		return;
+
+	genpd_dev_pm_detach(dev, true);
+
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_reinit(dev);
+
+	dev_info(dev, "genpd: detached cpu\n");
+}
+EXPORT_SYMBOL(of_genpd_detach_cpu);
+
 static const struct of_device_id idle_state_match[] = {
 	{ .compatible = "domain-idle-state", },
 	{ }
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 3f67ff0c1c69..2c09cf80b285 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -243,6 +243,8 @@ unsigned int of_genpd_opp_to_performance_state(struct device *dev,
 int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 					 unsigned int index);
+int of_genpd_attach_cpu(int cpu);
+void of_genpd_detach_cpu(int cpu);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
 static inline int of_genpd_add_provider_simple(struct device_node *np,
 					struct generic_pm_domain *genpd)
@@ -294,6 +296,13 @@ static inline struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	return NULL;
 }
 
+static inline int of_genpd_attach_cpu(int cpu)
+{
+	return -ENODEV;
+}
+
+static inline void of_genpd_detach_cpu(int cpu) {}
+
 static inline
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 {
-- 
2.17.1
