From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v7 05/26] PM / Domains: Add helper functions to attach/detach
 CPUs to/from genpd
Date: Thu, 12 Apr 2018 13:14:10 +0200
Message-ID: <1523531671-27491-6-git-send-email-ulf.hansson@linaro.org>
References: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Lina Iyer <lina.iyer@linaro.org>
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
 drivers/base/power/domain.c | 67 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  9 ++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e178521..91ea9b2 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2324,6 +2324,73 @@ int genpd_dev_pm_attach(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 
+/**
+ * of_genpd_attach_cpu() - Attach a CPU to its PM domain
+ * @cpu: The CPU to be attached.
+ *
+ * Try to find the corresponding PM domain provider for the CPU's device. Use
+ * it to attach the CPU's device to its PM domain. If attaching is completed
+ * successfully, we enable runtime PM for the CPU's device.
+ *
+ * Returns zero on success else a negative error code.
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
+	if (ret) {
+		dev_warn(dev, "genpd: attach cpu failed %d\n", ret);
+		return ret;
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
index 29ab00c..ccd7c94 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -249,6 +249,8 @@ extern int of_genpd_parse_idle_states(struct device_node *dn,
 			struct genpd_power_state **states, int *n);
 
 int genpd_dev_pm_attach(struct device *dev);
+int of_genpd_attach_cpu(int cpu);
+void of_genpd_detach_cpu(int cpu);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
 static inline int of_genpd_add_provider_simple(struct device_node *np,
 					struct generic_pm_domain *genpd)
@@ -287,6 +289,13 @@ static inline int genpd_dev_pm_attach(struct device *dev)
 	return -ENODEV;
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
2.7.4
