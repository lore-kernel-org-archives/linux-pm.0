From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v4 06/16] PM / devfreq: tegra: Drop primary interrupt handler
Date: Thu,  2 May 2019 02:38:05 +0300
Message-ID: <20190501233815.32643-7-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

There is no real need in the primary interrupt handler, hence move
everything to the secondary (threaded) handler. In a result locking
is consistent now and there are no potential races with the interrupt
handler because it is protected with the devfreq's mutex.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 55 +++++++++++----------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 24ec65556c39..b65313fe3c2e 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -144,7 +144,6 @@ static struct tegra_devfreq_device_config actmon_device_configs[] = {
 struct tegra_devfreq_device {
 	const struct tegra_devfreq_device_config *config;
 	void __iomem *regs;
-	spinlock_t lock;
 
 	/* Average event count sampled in the last interrupt */
 	u32 avg_count;
@@ -249,11 +248,8 @@ static void actmon_write_barrier(struct tegra_devfreq *tegra)
 static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev)
 {
-	unsigned long flags;
 	u32 intr_status, dev_ctrl;
 
-	spin_lock_irqsave(&dev->lock, flags);
-
 	dev->avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
 	tegra_devfreq_update_avg_wmark(tegra, dev);
 
@@ -302,26 +298,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
 
 	actmon_write_barrier(tegra);
-
-	spin_unlock_irqrestore(&dev->lock, flags);
-}
-
-static irqreturn_t actmon_isr(int irq, void *data)
-{
-	struct tegra_devfreq *tegra = data;
-	bool handled = false;
-	unsigned int i;
-	u32 val;
-
-	val = actmon_readl(tegra, ACTMON_GLB_STATUS);
-	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		if (val & tegra->devices[i].config->irq_mask) {
-			actmon_isr_device(tegra, tegra->devices + i);
-			handled = true;
-		}
-	}
-
-	return handled ? IRQ_WAKE_THREAD : IRQ_NONE;
 }
 
 static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
@@ -348,15 +324,12 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
 	unsigned long cpu_freq = 0;
 	unsigned long static_cpu_emc_freq = 0;
 	unsigned int avg_sustain_coef;
-	unsigned long flags;
 
 	if (dev->config->avg_dependency_threshold) {
 		cpu_freq = cpufreq_get(0);
 		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
 	}
 
-	spin_lock_irqsave(&dev->lock, flags);
-
 	dev->target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
 	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
 	dev->target_freq = do_percent(dev->target_freq, avg_sustain_coef);
@@ -364,19 +337,31 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
 
 	if (dev->avg_count >= dev->config->avg_dependency_threshold)
 		dev->target_freq = max(dev->target_freq, static_cpu_emc_freq);
-
-	spin_unlock_irqrestore(&dev->lock, flags);
 }
 
 static irqreturn_t actmon_thread_isr(int irq, void *data)
 {
 	struct tegra_devfreq *tegra = data;
+	bool handled = false;
+	unsigned int i;
+	u32 val;
 
 	mutex_lock(&tegra->devfreq->lock);
-	update_devfreq(tegra->devfreq);
+
+	val = actmon_readl(tegra, ACTMON_GLB_STATUS);
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
+		if (val & tegra->devices[i].config->irq_mask) {
+			actmon_isr_device(tegra, tegra->devices + i);
+			handled = true;
+		}
+	}
+
+	if (handled)
+		update_devfreq(tegra->devfreq);
+
 	mutex_unlock(&tegra->devfreq->lock);
 
-	return IRQ_HANDLED;
+	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
@@ -386,7 +371,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
 	unsigned int i;
-	unsigned long flags;
 
 	if (action != POST_RATE_CHANGE)
 		return NOTIFY_OK;
@@ -398,9 +382,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
 		dev = &tegra->devices[i];
 
-		spin_lock_irqsave(&dev->lock, flags);
 		tegra_devfreq_update_wmark(tegra, dev);
-		spin_unlock_irqrestore(&dev->lock, flags);
 	}
 
 	actmon_write_barrier(tegra);
@@ -682,7 +664,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		dev = tegra->devices + i;
 		dev->config = actmon_device_configs + i;
 		dev->regs = tegra->regs + dev->config->offset;
-		spin_lock_init(&dev->lock);
 
 		tegra_actmon_configure_device(tegra, dev);
 	}
@@ -700,8 +681,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tegra);
 
-	err = devm_request_threaded_irq(&pdev->dev, irq, actmon_isr,
-					actmon_thread_isr, IRQF_SHARED,
+	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					actmon_thread_isr, IRQF_ONESHOT,
 					"tegra-devfreq", tegra);
 	if (err) {
 		dev_err(&pdev->dev, "Interrupt request failed\n");
-- 
2.21.0
