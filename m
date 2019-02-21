From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 07/12] thermal: tegra: add support for thermal IRQ
Date: Thu, 21 Feb 2019 18:18:42 +0800
Message-ID: <1550744327-4677-8-git-send-email-wni@nvidia.com>
References: <1550744327-4677-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550744327-4677-1-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, edubezval@gmail.com, robh@kernel.org
Cc: thierry.reding@gmail.com, linux-tegra@vger.kernel.org, rui.zhang@intel.com, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Support to generate an interrupt when the temperature
crosses a programmed threshold and notify the thermal framework.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 136 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index edbb90da1ac3..16275de2d67b 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -86,6 +86,20 @@
 #define THERMCTL_LVL0_UP_STATS			0x10
 #define THERMCTL_LVL0_DN_STATS			0x14
 
+#define THERMCTL_INTR_STATUS			0x84
+#define THERMCTL_INTR_ENABLE			0x88
+#define THERMCTL_INTR_DISABLE			0x8c
+
+#define TH_INTR_MD0_MASK			BIT(25)
+#define TH_INTR_MU0_MASK			BIT(24)
+#define TH_INTR_GD0_MASK			BIT(17)
+#define TH_INTR_GU0_MASK			BIT(16)
+#define TH_INTR_CD0_MASK			BIT(9)
+#define TH_INTR_CU0_MASK			BIT(8)
+#define TH_INTR_PD0_MASK			BIT(1)
+#define TH_INTR_PU0_MASK			BIT(0)
+#define TH_INTR_IGNORE_MASK			0xFCFCFCFC
+
 #define THERMCTL_STATS_CTL			0x94
 #define STATS_CTL_CLR_DN			0x8
 #define STATS_CTL_EN_DN				0x4
@@ -242,6 +256,8 @@ struct tegra_soctherm {
 	void __iomem *clk_regs;
 	void __iomem *ccroc_regs;
 
+	int thermal_irq;
+
 	u32 *calib;
 	struct thermal_zone_device **thermctl_tzs;
 	struct tegra_soctherm_soc *soc;
@@ -640,6 +656,98 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 	return 0;
 }
 
+static irqreturn_t soctherm_thermal_isr(int irq, void *dev_id)
+{
+	struct tegra_soctherm *ts = dev_id;
+	u32 r;
+
+	r = readl(ts->regs + THERMCTL_INTR_STATUS);
+	writel(r, ts->regs + THERMCTL_INTR_DISABLE);
+
+	return IRQ_WAKE_THREAD;
+}
+
+/**
+ * soctherm_thermal_isr_thread() - Handles a thermal interrupt request
+ * @irq:       The interrupt number being requested; not used
+ * @dev_id:    Opaque pointer to tegra_soctherm;
+ *
+ * Clears the interrupt status register if there are expected
+ * interrupt bits set.
+ * The interrupt(s) are then handled by updating the corresponding
+ * thermal zones.
+ *
+ * An error is logged if any unexpected interrupt bits are set.
+ *
+ * Disabled interrupts are re-enabled.
+ *
+ * Return: %IRQ_HANDLED. Interrupt was handled and no further processing
+ * is needed.
+ */
+static irqreturn_t soctherm_thermal_isr_thread(int irq, void *dev_id)
+{
+	struct tegra_soctherm *ts = dev_id;
+	struct thermal_zone_device *tz;
+	u32 st, ex = 0, cp = 0, gp = 0, pl = 0, me = 0;
+
+	st = readl(ts->regs + THERMCTL_INTR_STATUS);
+
+	/* deliberately clear expected interrupts handled in SW */
+	cp |= st & TH_INTR_CD0_MASK;
+	cp |= st & TH_INTR_CU0_MASK;
+
+	gp |= st & TH_INTR_GD0_MASK;
+	gp |= st & TH_INTR_GU0_MASK;
+
+	pl |= st & TH_INTR_PD0_MASK;
+	pl |= st & TH_INTR_PU0_MASK;
+
+	me |= st & TH_INTR_MD0_MASK;
+	me |= st & TH_INTR_MU0_MASK;
+
+	ex |= cp | gp | pl | me;
+	if (ex) {
+		writel(ex, ts->regs + THERMCTL_INTR_STATUS);
+		st &= ~ex;
+
+		if (cp) {
+			tz = ts->thermctl_tzs[TEGRA124_SOCTHERM_SENSOR_CPU];
+			thermal_zone_device_update(tz,
+						   THERMAL_EVENT_UNSPECIFIED);
+		}
+
+		if (gp) {
+			tz = ts->thermctl_tzs[TEGRA124_SOCTHERM_SENSOR_GPU];
+			thermal_zone_device_update(tz,
+						   THERMAL_EVENT_UNSPECIFIED);
+		}
+
+		if (pl) {
+			tz = ts->thermctl_tzs[TEGRA124_SOCTHERM_SENSOR_PLLX];
+			thermal_zone_device_update(tz,
+						   THERMAL_EVENT_UNSPECIFIED);
+		}
+
+		if (me) {
+			tz = ts->thermctl_tzs[TEGRA124_SOCTHERM_SENSOR_MEM];
+			thermal_zone_device_update(tz,
+						   THERMAL_EVENT_UNSPECIFIED);
+		}
+	}
+
+	/* deliberately ignore expected interrupts NOT handled in SW */
+	ex |= TH_INTR_IGNORE_MASK;
+	st &= ~ex;
+
+	if (st) {
+		/* Whine about any other unexpected INTR bits still set */
+		pr_err("soctherm: Ignored unexpected INTRs 0x%08x\n", st);
+		writel(st, ts->regs + THERMCTL_INTR_STATUS);
+	}
+
+	return IRQ_HANDLED;
+}
+
 #ifdef CONFIG_DEBUG_FS
 static int regs_show(struct seq_file *s, void *data)
 {
@@ -1302,6 +1410,32 @@ static void tegra_soctherm_throttle(struct device *dev)
 	writel(v, ts->regs + THERMCTL_STATS_CTL);
 }
 
+static int soctherm_interrupts_init(struct platform_device *pdev,
+				    struct tegra_soctherm *tegra)
+{
+	int ret;
+
+	tegra->thermal_irq = platform_get_irq(pdev, 0);
+	if (tegra->thermal_irq < 0) {
+		dev_dbg(&pdev->dev, "get 'thermal_irq' failed.\n");
+		return 0;
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev,
+					tegra->thermal_irq,
+					soctherm_thermal_isr,
+					soctherm_thermal_isr_thread,
+					IRQF_ONESHOT,
+					dev_name(&pdev->dev),
+					tegra);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "request_irq 'thermal_irq' failed.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static void soctherm_init(struct platform_device *pdev)
 {
 	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
@@ -1495,6 +1629,8 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 			goto disable_clocks;
 	}
 
+	err = soctherm_interrupts_init(pdev, tegra);
+
 	soctherm_debug_init(pdev);
 
 	return 0;
-- 
2.7.4
