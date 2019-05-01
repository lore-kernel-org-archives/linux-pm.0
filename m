From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v4 12/16] PM / devfreq: tegra: Reconfigure hardware on governor's restart
Date: Thu,  2 May 2019 02:38:11 +0300
Message-ID: <20190501233815.32643-13-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Move hardware configuration to governor's start/resume methods.
This allows to re-initialize hardware counters and reconfigure
cleanly if governor was stopped/paused. That is needed because we
are not aware of all hardware changes that happened while governor
was stopped and the paused state may get out of sync with reality,
hence it's better to start with a clean slate after the pause. In
a result there is no memory bandwidth starvation after resume from
suspend-to-ram that results in display controller underflowing that
happens on resume because of improper decision made by devfreq about
the required memory frequency. This change also cleans up code a tad
by moving hardware-configuration code into a single location.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 98 ++++++++++++++-------------------
 1 file changed, 40 insertions(+), 58 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 40ce9881f144..2d9d53daedd8 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -392,55 +392,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static void tegra_actmon_enable_interrupts(struct tegra_devfreq *tegra)
-{
-	struct tegra_devfreq_device *dev;
-	u32 val;
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		dev = &tegra->devices[i];
-
-		val = device_readl(dev, ACTMON_DEV_CTRL);
-		val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
-		val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
-		val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
-		val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
-
-		device_writel(dev, val, ACTMON_DEV_CTRL);
-	}
-
-	actmon_write_barrier(tegra);
-}
-
-static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
-{
-	struct tegra_devfreq_device *dev;
-	u32 val;
-	unsigned int i;
-
-	disable_irq(tegra->irq);
-
-	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		dev = &tegra->devices[i];
-
-		val = device_readl(dev, ACTMON_DEV_CTRL);
-		val &= ~ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
-		val &= ~ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
-		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
-		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
-
-		device_writel(dev, val, ACTMON_DEV_CTRL);
-
-		device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
-			      ACTMON_DEV_INTR_STATUS);
-	}
-
-	actmon_write_barrier(tegra);
-
-	enable_irq(tegra->irq);
-}
-
 static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 					  struct tegra_devfreq_device *dev)
 {
@@ -464,11 +415,47 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 		<< ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_NUM_SHIFT;
 	val |= (ACTMON_ABOVE_WMARK_WINDOW - 1)
 		<< ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_NUM_SHIFT;
+	val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
+	val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
+	val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+	val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_ENB;
 
 	device_writel(dev, val, ACTMON_DEV_CTRL);
+}
+
+static void tegra_actmon_start(struct tegra_devfreq *tegra)
+{
+	unsigned int i;
+
+	disable_irq(tegra->irq);
+
+	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
+		      ACTMON_GLB_PERIOD_CTRL);
+
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
+		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
+
+	actmon_write_barrier(tegra);
+
+	enable_irq(tegra->irq);
+}
+
+static void tegra_actmon_stop(struct tegra_devfreq *tegra)
+{
+	unsigned int i;
+
+	disable_irq(tegra->irq);
+
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
+		device_writel(&tegra->devices[i], 0x00000000, ACTMON_DEV_CTRL);
+		device_writel(&tegra->devices[i], ACTMON_INTR_STATUS_CLEAR,
+			      ACTMON_DEV_INTR_STATUS);
+	}
 
 	actmon_write_barrier(tegra);
+
+	enable_irq(tegra->irq);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -580,22 +567,22 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 	switch (event) {
 	case DEVFREQ_GOV_START:
 		devfreq_monitor_start(devfreq);
-		tegra_actmon_enable_interrupts(tegra);
+		tegra_actmon_start(tegra);
 		break;
 
 	case DEVFREQ_GOV_STOP:
-		tegra_actmon_disable_interrupts(tegra);
+		tegra_actmon_stop(tegra);
 		devfreq_monitor_stop(devfreq);
 		break;
 
 	case DEVFREQ_GOV_SUSPEND:
-		tegra_actmon_disable_interrupts(tegra);
+		tegra_actmon_stop(tegra);
 		devfreq_monitor_suspend(devfreq);
 		break;
 
 	case DEVFREQ_GOV_RESUME:
 		devfreq_monitor_resume(devfreq);
-		tegra_actmon_enable_interrupts(tegra);
+		tegra_actmon_start(tegra);
 		break;
 	}
 
@@ -664,15 +651,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	tegra->max_freq = clk_round_rate(tegra->emc_clock, ULONG_MAX) / KHZ;
 	tegra->cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
 
-	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
-		      ACTMON_GLB_PERIOD_CTRL);
-
 	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
 		dev = tegra->devices + i;
 		dev->config = actmon_device_configs + i;
 		dev->regs = tegra->regs + dev->config->offset;
-
-		tegra_actmon_configure_device(tegra, dev);
 	}
 
 	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
-- 
2.21.0
