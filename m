From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 10/19] PM / devfreq: tegra: Drop primary interrupt handler
Date: Mon, 15 Apr 2019 17:54:56 +0300
Message-ID: <20190415145505.18397-11-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

There is no real need in the primary interrupt handler, hence move
everything to the secondary (threaded) handler. In a result locking
is consistent now and there are no potential races with the interrupt
handler because it is protected with the devfreq's mutex.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 61 ++++++++++++---------------------
 1 file changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 2a1464098200..69b557df5084 100644
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
@@ -348,35 +324,46 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
 	unsigned long cpu_freq = 0;
 	unsigned long static_cpu_emc_freq = 0;
 	unsigned int avg_sustain_coef;
-	unsigned long flags;
+	u32 avg_count;
 
 	if (dev->config->avg_dependency_threshold) {
 		cpu_freq = cpufreq_get(0);
 		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
 	}
 
-	spin_lock_irqsave(&dev->lock, flags);
-
-	dev->target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
+	avg_count = dev->avg_count;
+	dev->target_freq = avg_count / ACTMON_SAMPLING_PERIOD;
 	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
 	dev->target_freq = do_percent(dev->target_freq, avg_sustain_coef);
 	dev->target_freq += dev->boost_freq;
 
-	if (dev->avg_count >= dev->config->avg_dependency_threshold)
+	if (avg_count >= dev->config->avg_dependency_threshold)
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
@@ -386,7 +373,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
 	unsigned int i;
-	unsigned long flags;
 
 	if (action != POST_RATE_CHANGE)
 		return NOTIFY_OK;
@@ -398,9 +384,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
 		dev = &tegra->devices[i];
 
-		spin_lock_irqsave(&dev->lock, flags);
 		tegra_devfreq_update_wmark(tegra, dev);
-		spin_unlock_irqrestore(&dev->lock, flags);
 	}
 
 	actmon_write_barrier(tegra);
@@ -668,7 +652,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		dev = tegra->devices + i;
 		dev->config = actmon_device_configs + i;
 		dev->regs = tegra->regs + dev->config->offset;
-		spin_lock_init(&dev->lock);
 
 		tegra_actmon_configure_device(tegra, dev);
 	}
@@ -696,8 +679,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = devm_request_threaded_irq(&pdev->dev, irq, actmon_isr,
-					actmon_thread_isr, IRQF_SHARED,
+	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					actmon_thread_isr, IRQF_ONESHOT,
 					"tegra-devfreq", tegra);
 	if (err) {
 		dev_err(&pdev->dev, "Interrupt request failed\n");
-- 
2.21.0
