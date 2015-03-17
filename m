From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v6 2/8] PM / devfreq: tegra: Update to v5 of the submitted patches
Date: Tue, 17 Mar 2015 10:36:12 +0100
Message-ID: <1426584991-11110-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1426584991-11110-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426584991-11110-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tegra@vger.kernel.org
Cc: Mikko Perttunen <mikko.perttunen@kapsi.fi>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Alex Frid <afrid@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

There seemed to be some miscommunication and an old version of the
submitted patches was merged.

This commit updates the driver to v5, which had this changelog:

* Clarify the units of avg_dependency_threshold
* Remove unused references to platform_device
* Enable and disable interrupts on governor events
* Make sure we handle all interrupts for any of the devices we are sampling
* Move locking to be per-actmon-device

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
CC: Alex Frid <afrid@nvidia.com>
CC: Mikko Perttunen <mikko.perttunen@kapsi.fi>
---
 drivers/devfreq/tegra-devfreq.c | 455 ++++++++++++++++++++++------------------
 1 file changed, 252 insertions(+), 203 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 3479096..c71635a 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -62,7 +62,8 @@
 #define ACTMON_BELOW_WMARK_WINDOW				3
 #define ACTMON_BOOST_FREQ_STEP					16000
 
-/* activity counter is incremented every 256 memory transactions, and each
+/*
+ * Activity counter is incremented every 256 memory transactions, and each
  * transaction takes 4 EMC clocks for Tegra124; So the COUNT_WEIGHT is
  * 4 * 256 = 1024.
  */
@@ -85,16 +86,25 @@
  * struct tegra_devfreq_device_config - configuration specific to an ACTMON
  * device
  *
- * Coefficients and thresholds are in %
+ * Coefficients and thresholds are percentages unless otherwise noted
  */
 struct tegra_devfreq_device_config {
 	u32		offset;
 	u32		irq_mask;
 
+	/* Factors applied to boost_freq every consecutive watermark breach */
 	unsigned int	boost_up_coeff;
 	unsigned int	boost_down_coeff;
+
+	/* Define the watermark bounds when applied to the current avg */
 	unsigned int	boost_up_threshold;
 	unsigned int	boost_down_threshold;
+
+	/*
+	 * Threshold of activity (cycles) below which the CPU frequency isn't
+	 * to be taken into account. This is to avoid increasing the EMC
+	 * frequency when the CPU is very busy but not accessing the bus often.
+	 */
 	u32		avg_dependency_threshold;
 };
 
@@ -105,7 +115,7 @@ enum tegra_actmon_device {
 
 static struct tegra_devfreq_device_config actmon_device_configs[] = {
 	{
-		/* MCALL */
+		/* MCALL: All memory accesses (including from the CPUs) */
 		.offset = 0x1c0,
 		.irq_mask = 1 << 26,
 		.boost_up_coeff = 200,
@@ -114,7 +124,7 @@ static struct tegra_devfreq_device_config actmon_device_configs[] = {
 		.boost_down_threshold = 40,
 	},
 	{
-		/* MCCPU */
+		/* MCCPU: memory accesses from the CPUs */
 		.offset = 0x200,
 		.irq_mask = 1 << 25,
 		.boost_up_coeff = 800,
@@ -132,25 +142,29 @@ static struct tegra_devfreq_device_config actmon_device_configs[] = {
  */
 struct tegra_devfreq_device {
 	const struct tegra_devfreq_device_config *config;
+	void __iomem *regs;
+	spinlock_t lock;
 
-	void __iomem	*regs;
-	u32		avg_band_freq;
-	u32		avg_count;
+	/* Average event count sampled in the last interrupt */
+	u32 avg_count;
 
-	unsigned long	target_freq;
-	unsigned long	boost_freq;
+	/*
+	 * Extra frequency to increase the target by due to consecutive
+	 * watermark breaches.
+	 */
+	unsigned long boost_freq;
+
+	/* Optimal frequency calculated from the stats for this device */
+	unsigned long target_freq;
 };
 
 struct tegra_devfreq {
 	struct devfreq		*devfreq;
 
-	struct platform_device	*pdev;
 	struct reset_control	*reset;
 	struct clk		*clock;
 	void __iomem		*regs;
 
-	spinlock_t		lock;
-
 	struct clk		*emc_clock;
 	unsigned long		max_freq;
 	unsigned long		cur_freq;
@@ -174,19 +188,43 @@ static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
 	{  250000,    100000 },
 };
 
+static u32 actmon_readl(struct tegra_devfreq *tegra, u32 offset)
+{
+	return readl(tegra->regs + offset);
+}
+
+static void actmon_writel(struct tegra_devfreq *tegra, u32 val, u32 offset)
+{
+	writel(val, tegra->regs + offset);
+}
+
+static u32 device_readl(struct tegra_devfreq_device *dev, u32 offset)
+{
+	return readl(dev->regs + offset);
+}
+
+static void device_writel(struct tegra_devfreq_device *dev, u32 val,
+			  u32 offset)
+{
+	writel(val, dev->regs + offset);
+}
+
 static unsigned long do_percent(unsigned long val, unsigned int pct)
 {
 	return val * pct / 100;
 }
 
-static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq_device *dev)
+static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
+					   struct tegra_devfreq_device *dev)
 {
 	u32 avg = dev->avg_count;
-	u32 band = dev->avg_band_freq * ACTMON_SAMPLING_PERIOD;
+	u32 avg_band_freq = tegra->max_freq * ACTMON_DEFAULT_AVG_BAND / KHZ;
+	u32 band = avg_band_freq * ACTMON_SAMPLING_PERIOD;
+
+	device_writel(dev, avg + band, ACTMON_DEV_AVG_UPPER_WMARK);
 
-	writel(avg + band, dev->regs + ACTMON_DEV_AVG_UPPER_WMARK);
-	avg = max(avg, band);
-	writel(avg - band, dev->regs + ACTMON_DEV_AVG_LOWER_WMARK);
+	avg = max(dev->avg_count, band);
+	device_writel(dev, avg - band, ACTMON_DEV_AVG_LOWER_WMARK);
 }
 
 static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
@@ -194,96 +232,96 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 {
 	u32 val = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
 
-	writel(do_percent(val, dev->config->boost_up_threshold),
-	       dev->regs + ACTMON_DEV_UPPER_WMARK);
+	device_writel(dev, do_percent(val, dev->config->boost_up_threshold),
+		      ACTMON_DEV_UPPER_WMARK);
 
-	writel(do_percent(val, dev->config->boost_down_threshold),
-	       dev->regs + ACTMON_DEV_LOWER_WMARK);
+	device_writel(dev, do_percent(val, dev->config->boost_down_threshold),
+		      ACTMON_DEV_LOWER_WMARK);
 }
 
 static void actmon_write_barrier(struct tegra_devfreq *tegra)
 {
 	/* ensure the update has reached the ACTMON */
 	wmb();
-	readl(tegra->regs + ACTMON_GLB_STATUS);
+	actmon_readl(tegra, ACTMON_GLB_STATUS);
 }
 
-static irqreturn_t actmon_isr(int irq, void *data)
+static void actmon_isr_device(struct tegra_devfreq *tegra,
+			      struct tegra_devfreq_device *dev)
 {
-	struct tegra_devfreq *tegra = data;
-	struct tegra_devfreq_device *dev = NULL;
 	unsigned long flags;
-	u32 val;
-	unsigned int i;
+	u32 intr_status, dev_ctrl;
 
-	val = readl(tegra->regs + ACTMON_GLB_STATUS);
+	spin_lock_irqsave(&dev->lock, flags);
 
-	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		if (val & tegra->devices[i].config->irq_mask) {
-			dev = tegra->devices + i;
-			break;
-		}
-	}
-
-	if (!dev)
-		return IRQ_NONE;
-
-	spin_lock_irqsave(&tegra->lock, flags);
-
-	dev->avg_count = readl(dev->regs + ACTMON_DEV_AVG_COUNT);
-	tegra_devfreq_update_avg_wmark(dev);
+	dev->avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
+	tegra_devfreq_update_avg_wmark(tegra, dev);
 
-	val = readl(dev->regs + ACTMON_DEV_INTR_STATUS);
-	if (val & ACTMON_DEV_INTR_CONSECUTIVE_UPPER) {
-		val = readl(dev->regs + ACTMON_DEV_CTRL) |
-			ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN |
-			ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+	intr_status = device_readl(dev, ACTMON_DEV_INTR_STATUS);
+	dev_ctrl = device_readl(dev, ACTMON_DEV_CTRL);
 
+	if (intr_status & ACTMON_DEV_INTR_CONSECUTIVE_UPPER) {
 		/*
 		 * new_boost = min(old_boost * up_coef + step, max_freq)
 		 */
 		dev->boost_freq = do_percent(dev->boost_freq,
 					     dev->config->boost_up_coeff);
 		dev->boost_freq += ACTMON_BOOST_FREQ_STEP;
-		if (dev->boost_freq >= tegra->max_freq) {
-			dev->boost_freq = tegra->max_freq;
-			val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
-		}
-		writel(val, dev->regs + ACTMON_DEV_CTRL);
-	} else if (val & ACTMON_DEV_INTR_CONSECUTIVE_LOWER) {
-		val = readl(dev->regs + ACTMON_DEV_CTRL) |
-			ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN |
-			ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
 
+		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+
+		if (dev->boost_freq >= tegra->max_freq)
+			dev->boost_freq = tegra->max_freq;
+		else
+			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
+	} else if (intr_status & ACTMON_DEV_INTR_CONSECUTIVE_LOWER) {
 		/*
 		 * new_boost = old_boost * down_coef
 		 * or 0 if (old_boost * down_coef < step / 2)
 		 */
 		dev->boost_freq = do_percent(dev->boost_freq,
 					     dev->config->boost_down_coeff);
-		if (dev->boost_freq < (ACTMON_BOOST_FREQ_STEP >> 1)) {
+
+		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
+
+		if (dev->boost_freq < (ACTMON_BOOST_FREQ_STEP >> 1))
 			dev->boost_freq = 0;
-			val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
-		}
-		writel(val, dev->regs + ACTMON_DEV_CTRL);
+		else
+			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
 	}
 
 	if (dev->config->avg_dependency_threshold) {
-		val = readl(dev->regs + ACTMON_DEV_CTRL);
 		if (dev->avg_count >= dev->config->avg_dependency_threshold)
-			val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
 		else if (dev->boost_freq == 0)
-			val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
-		writel(val, dev->regs + ACTMON_DEV_CTRL);
+			dev_ctrl &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
 	}
 
-	writel(ACTMON_INTR_STATUS_CLEAR, dev->regs + ACTMON_DEV_INTR_STATUS);
+	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
+
+	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
 
 	actmon_write_barrier(tegra);
 
-	spin_unlock_irqrestore(&tegra->lock, flags);
+	spin_unlock_irqrestore(&dev->lock, flags);
+}
 
-	return IRQ_WAKE_THREAD;
+static irqreturn_t actmon_isr(int irq, void *data)
+{
+	struct tegra_devfreq *tegra = data;
+	bool handled = false;
+	unsigned int i;
+	u32 val;
+
+	val = actmon_readl(tegra, ACTMON_GLB_STATUS);
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
+		if (val & tegra->devices[i].config->irq_mask) {
+			actmon_isr_device(tegra, tegra->devices + i);
+			handled = true;
+		}
+	}
+
+	return handled ? IRQ_WAKE_THREAD : IRQ_NONE;
 }
 
 static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
@@ -317,7 +355,7 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
 		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
 	}
 
-	spin_lock_irqsave(&tegra->lock, flags);
+	spin_lock_irqsave(&dev->lock, flags);
 
 	dev->target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
 	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
@@ -327,7 +365,7 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
 	if (dev->avg_count >= dev->config->avg_dependency_threshold)
 		dev->target_freq = max(dev->target_freq, static_cpu_emc_freq);
 
-	spin_unlock_irqrestore(&tegra->lock, flags);
+	spin_unlock_irqrestore(&dev->lock, flags);
 }
 
 static irqreturn_t actmon_thread_isr(int irq, void *data)
@@ -345,131 +383,110 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 				       unsigned long action, void *ptr)
 {
 	struct clk_notifier_data *data = ptr;
-	struct tegra_devfreq *tegra = container_of(nb, struct tegra_devfreq,
-						   rate_change_nb);
+	struct tegra_devfreq *tegra;
+	struct tegra_devfreq_device *dev;
 	unsigned int i;
 	unsigned long flags;
 
-	spin_lock_irqsave(&tegra->lock, flags);
+	if (action != POST_RATE_CHANGE)
+		return NOTIFY_OK;
 
-	switch (action) {
-	case POST_RATE_CHANGE:
-		tegra->cur_freq = data->new_rate / KHZ;
+	tegra = container_of(nb, struct tegra_devfreq, rate_change_nb);
 
-		for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
-			tegra_devfreq_update_wmark(tegra, tegra->devices + i);
+	tegra->cur_freq = data->new_rate / KHZ;
 
-		actmon_write_barrier(tegra);
-		break;
-	case PRE_RATE_CHANGE:
-		/* fall through */
-	case ABORT_RATE_CHANGE:
-		break;
-	};
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
+		dev = &tegra->devices[i];
+
+		spin_lock_irqsave(&dev->lock, flags);
+		tegra_devfreq_update_wmark(tegra, dev);
+		spin_unlock_irqrestore(&dev->lock, flags);
+	}
 
-	spin_unlock_irqrestore(&tegra->lock, flags);
+	actmon_write_barrier(tegra);
 
 	return NOTIFY_OK;
 }
 
-static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
-					  struct tegra_devfreq_device *dev)
+static void tegra_actmon_enable_interrupts(struct tegra_devfreq *tegra)
 {
+	struct tegra_devfreq_device *dev;
 	u32 val;
+	unsigned int i;
 
-	dev->avg_band_freq = tegra->max_freq * ACTMON_DEFAULT_AVG_BAND / KHZ;
-	dev->target_freq = tegra->cur_freq;
-
-	dev->avg_count = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
-	writel(dev->avg_count, dev->regs + ACTMON_DEV_INIT_AVG);
-
-	tegra_devfreq_update_avg_wmark(dev);
-	tegra_devfreq_update_wmark(tegra, dev);
-
-	writel(ACTMON_COUNT_WEIGHT, dev->regs + ACTMON_DEV_COUNT_WEIGHT);
-	writel(ACTMON_INTR_STATUS_CLEAR, dev->regs + ACTMON_DEV_INTR_STATUS);
-
-	val = 0;
-	val |= ACTMON_DEV_CTRL_ENB_PERIODIC |
-	       ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN |
-	       ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
-	val |= (ACTMON_AVERAGE_WINDOW_LOG2 - 1)
-		<< ACTMON_DEV_CTRL_K_VAL_SHIFT;
-	val |= (ACTMON_BELOW_WMARK_WINDOW - 1)
-		<< ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_NUM_SHIFT;
-	val |= (ACTMON_ABOVE_WMARK_WINDOW - 1)
-		<< ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_NUM_SHIFT;
-	val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN |
-	       ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
-
-	writel(val, dev->regs + ACTMON_DEV_CTRL);
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
+		dev = &tegra->devices[i];
 
-	actmon_write_barrier(tegra);
+		val = device_readl(dev, ACTMON_DEV_CTRL);
+		val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
+		val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
+		val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+		val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 
-	val = readl(dev->regs + ACTMON_DEV_CTRL);
-	val |= ACTMON_DEV_CTRL_ENB;
-	writel(val, dev->regs + ACTMON_DEV_CTRL);
+		device_writel(dev, val, ACTMON_DEV_CTRL);
+	}
 
 	actmon_write_barrier(tegra);
 }
 
-static int tegra_devfreq_suspend(struct device *dev)
+static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
 {
-	struct platform_device *pdev;
-	struct tegra_devfreq *tegra;
-	struct tegra_devfreq_device *actmon_dev;
-	unsigned int i;
+	struct tegra_devfreq_device *dev;
 	u32 val;
-
-	pdev = container_of(dev, struct platform_device, dev);
-	tegra = platform_get_drvdata(pdev);
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		actmon_dev = &tegra->devices[i];
-
-		val = readl(actmon_dev->regs + ACTMON_DEV_CTRL);
-		val &= ~ACTMON_DEV_CTRL_ENB;
-		writel(val, actmon_dev->regs + ACTMON_DEV_CTRL);
+		dev = &tegra->devices[i];
 
-		writel(ACTMON_INTR_STATUS_CLEAR,
-		       actmon_dev->regs + ACTMON_DEV_INTR_STATUS);
+		val = device_readl(dev, ACTMON_DEV_CTRL);
+		val &= ~ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
+		val &= ~ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
+		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 
-		actmon_write_barrier(tegra);
+		device_writel(dev, val, ACTMON_DEV_CTRL);
 	}
 
-	return 0;
+	actmon_write_barrier(tegra);
 }
 
-static int tegra_devfreq_resume(struct device *dev)
+static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
+					  struct tegra_devfreq_device *dev)
 {
-	struct platform_device *pdev;
-	struct tegra_devfreq *tegra;
-	struct tegra_devfreq_device *actmon_dev;
-	unsigned int i;
+	u32 val = 0;
 
-	pdev = container_of(dev, struct platform_device, dev);
-	tegra = platform_get_drvdata(pdev);
+	dev->target_freq = tegra->cur_freq;
 
-	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		actmon_dev = &tegra->devices[i];
+	dev->avg_count = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
+	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
 
-		tegra_actmon_configure_device(tegra, actmon_dev);
-	}
+	tegra_devfreq_update_avg_wmark(tegra, dev);
+	tegra_devfreq_update_wmark(tegra, dev);
 
-	return 0;
+	device_writel(dev, ACTMON_COUNT_WEIGHT, ACTMON_DEV_COUNT_WEIGHT);
+	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
+
+	val |= ACTMON_DEV_CTRL_ENB_PERIODIC;
+	val |= (ACTMON_AVERAGE_WINDOW_LOG2 - 1)
+		<< ACTMON_DEV_CTRL_K_VAL_SHIFT;
+	val |= (ACTMON_BELOW_WMARK_WINDOW - 1)
+		<< ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_NUM_SHIFT;
+	val |= (ACTMON_ABOVE_WMARK_WINDOW - 1)
+		<< ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_NUM_SHIFT;
+	val |= ACTMON_DEV_CTRL_ENB;
+
+	device_writel(dev, val, ACTMON_DEV_CTRL);
+
+	actmon_write_barrier(tegra);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 				u32 flags)
 {
-	struct platform_device *pdev;
-	struct tegra_devfreq *tegra;
+	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct dev_pm_opp *opp;
 	unsigned long rate = *freq * KHZ;
 
-	pdev = container_of(dev, struct platform_device, dev);
-	tegra = platform_get_drvdata(pdev);
-
 	rcu_read_lock();
 	opp = devfreq_recommended_opp(dev, &rate, flags);
 	if (IS_ERR(opp)) {
@@ -491,13 +508,9 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 static int tegra_devfreq_get_dev_status(struct device *dev,
 					struct devfreq_dev_status *stat)
 {
-	struct platform_device *pdev;
-	struct tegra_devfreq *tegra;
+	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct tegra_devfreq_device *actmon_dev;
 
-	pdev = container_of(dev, struct platform_device, dev);
-	tegra = platform_get_drvdata(pdev);
-
 	stat->current_frequency = tegra->cur_freq;
 
 	/* To be used by the tegra governor */
@@ -508,7 +521,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	actmon_dev = &tegra->devices[MCALL];
 
 	/* Number of cycles spent on memory access */
-	stat->busy_time = actmon_dev->avg_count;
+	stat->busy_time = device_readl(actmon_dev, ACTMON_DEV_AVG_COUNT);
 
 	/* The bus can be considered to be saturated way before 100% */
 	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
@@ -516,11 +529,19 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	/* Number of cycles in a sampling period */
 	stat->total_time = ACTMON_SAMPLING_PERIOD * tegra->cur_freq;
 
+	stat->busy_time = min(stat->busy_time, stat->total_time);
+
 	return 0;
 }
 
-static int tegra_devfreq_get_target(struct devfreq *devfreq,
-				    unsigned long *freq)
+static struct devfreq_dev_profile tegra_devfreq_profile = {
+	.polling_ms	= 0,
+	.target		= tegra_devfreq_target,
+	.get_dev_status	= tegra_devfreq_get_dev_status,
+};
+
+static int tegra_governor_get_target(struct devfreq *devfreq,
+				     unsigned long *freq)
 {
 	struct devfreq_dev_status stat;
 	struct tegra_devfreq *tegra;
@@ -548,23 +569,50 @@ static int tegra_devfreq_get_target(struct devfreq *devfreq,
 	return 0;
 }
 
-static int tegra_devfreq_event_handler(struct devfreq *devfreq,
-				       unsigned int event, void *data)
+static int tegra_governor_event_handler(struct devfreq *devfreq,
+					unsigned int event, void *data)
 {
-	return 0;
+	struct tegra_devfreq *tegra;
+	int ret = 0;
+
+	tegra = dev_get_drvdata(devfreq->dev.parent);
+
+	switch (event) {
+	case DEVFREQ_GOV_START:
+		tegra_actmon_enable_interrupts(tegra);
+		devfreq_monitor_start(devfreq);
+		break;
+
+	case DEVFREQ_GOV_STOP:
+		tegra_actmon_disable_interrupts(tegra);
+		devfreq_monitor_stop(devfreq);
+		break;
+
+	case DEVFREQ_GOV_SUSPEND:
+		tegra_actmon_disable_interrupts(tegra);
+		devfreq_monitor_suspend(devfreq);
+		break;
+
+	case DEVFREQ_GOV_RESUME:
+		tegra_actmon_enable_interrupts(tegra);
+		devfreq_monitor_resume(devfreq);
+		break;
+	}
+
+	return ret;
 }
 
 static struct devfreq_governor tegra_devfreq_governor = {
-	.name = "tegra",
-	.get_target_freq = tegra_devfreq_get_target,
-	.event_handler = tegra_devfreq_event_handler,
+	.name = "tegra_actmon",
+	.get_target_freq = tegra_governor_get_target,
+	.event_handler = tegra_governor_event_handler,
 };
 
-static struct devfreq_dev_profile tegra_devfreq_profile = {
-	.polling_ms	= 0,
-	.target		= tegra_devfreq_target,
-	.get_dev_status	= tegra_devfreq_get_dev_status,
-};
+static int __init tegra_governor_init(void)
+{
+	return devfreq_add_governor(&tegra_devfreq_governor);
+}
+subsys_initcall(tegra_governor_init);
 
 static int tegra_devfreq_probe(struct platform_device *pdev)
 {
@@ -580,19 +628,11 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	if (!tegra)
 		return -ENOMEM;
 
-	spin_lock_init(&tegra->lock);
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get regs resource\n");
-		return -ENODEV;
-	}
 
 	tegra->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(tegra->regs)) {
-		dev_err(&pdev->dev, "Failed to get IO memory\n");
+	if (IS_ERR(tegra->regs))
 		return PTR_ERR(tegra->regs);
-	}
 
 	tegra->reset = devm_reset_control_get(&pdev->dev, "actmon");
 	if (IS_ERR(tegra->reset)) {
@@ -630,7 +670,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	err = clk_prepare_enable(tegra->clock);
 	if (err) {
-		reset_control_deassert(tegra->reset);
+		dev_err(&pdev->dev,
+			"Failed to prepare and enable ACTMON clock\n");
 		return err;
 	}
 
@@ -643,30 +684,24 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	tegra->cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
 
-	writel(ACTMON_SAMPLING_PERIOD - 1,
-	       tegra->regs + ACTMON_GLB_PERIOD_CTRL);
+	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
+		      ACTMON_GLB_PERIOD_CTRL);
 
 	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
 		dev = tegra->devices + i;
 		dev->config = actmon_device_configs + i;
 		dev->regs = tegra->regs + dev->config->offset;
+		spin_lock_init(&dev->lock);
 
-		tegra_actmon_configure_device(tegra, tegra->devices + i);
+		tegra_actmon_configure_device(tegra, dev);
 	}
 
-	err = devfreq_add_governor(&tegra_devfreq_governor);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to add governor\n");
-		return err;
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		dev_err(&pdev->dev, "Failed to get IRQ\n");
+		return -ENODEV;
 	}
 
-	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
-	tegra->devfreq = devm_devfreq_add_device(&pdev->dev,
-						 &tegra_devfreq_profile,
-						 "tegra",
-						 NULL);
-
-	irq = platform_get_irq(pdev, 0);
 	err = devm_request_threaded_irq(&pdev->dev, irq, actmon_isr,
 					actmon_thread_isr, IRQF_SHARED,
 					"tegra-devfreq", tegra);
@@ -677,12 +712,31 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tegra);
 
+	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
+	tegra->devfreq = devm_devfreq_add_device(&pdev->dev,
+						 &tegra_devfreq_profile,
+						 "tegra_actmon",
+						 NULL);
+
 	return 0;
 }
 
 static int tegra_devfreq_remove(struct platform_device *pdev)
 {
 	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
+	int irq = platform_get_irq(pdev, 0);
+	u32 val;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
+		val = device_readl(&tegra->devices[i], ACTMON_DEV_CTRL);
+		val &= ~ACTMON_DEV_CTRL_ENB;
+		device_writel(&tegra->devices[i], val, ACTMON_DEV_CTRL);
+	}
+
+	actmon_write_barrier(tegra);
+
+	devm_free_irq(&pdev->dev, irq, tegra);
 
 	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
 
@@ -691,28 +745,23 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(tegra_devfreq_pm_ops,
-			 tegra_devfreq_suspend,
-			 tegra_devfreq_resume);
-
 static struct of_device_id tegra_devfreq_of_match[] = {
 	{ .compatible = "nvidia,tegra124-actmon" },
 	{ },
 };
 
+MODULE_DEVICE_TABLE(of, tegra_devfreq_of_match);
+
 static struct platform_driver tegra_devfreq_driver = {
 	.probe	= tegra_devfreq_probe,
 	.remove	= tegra_devfreq_remove,
 	.driver = {
-		.name		= "tegra-devfreq",
-		.owner		= THIS_MODULE,
+		.name = "tegra-devfreq",
 		.of_match_table = tegra_devfreq_of_match,
-		.pm		= &tegra_devfreq_pm_ops,
 	},
 };
 module_platform_driver(tegra_devfreq_driver);
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Tegra devfreq driver");
 MODULE_AUTHOR("Tomeu Vizoso <tomeu.vizoso@collabora.com>");
-MODULE_DEVICE_TABLE(of, tegra_devfreq_of_match);
-- 
2.1.0
