From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v6 4/8] PM / devfreq: tegra: Use clock rate constraints
Date: Tue, 17 Mar 2015 10:36:14 +0100
Message-ID: <1426584991-11110-5-git-send-email-tomeu.vizoso@collabora.com>
References: <1426584991-11110-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426584991-11110-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tegra@vger.kernel.org
Cc: Mikko Perttunen <mikko.perttunen@kapsi.fi>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Now that we have per-user clocks and the possibility to set constraints
in a clock, set a floor constraint on the EMC clock.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/devfreq/tegra-devfreq.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index c71635a..5a6164c 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -497,10 +497,8 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	rate = dev_pm_opp_get_freq(opp);
 	rcu_read_unlock();
 
-	/* TODO: Once we have per-user clk constraints, set a floor */
-	clk_set_rate(tegra->emc_clock, rate);
-
-	/* TODO: Set voltage as well */
+	clk_set_min_rate(tegra->emc_clock, rate);
+	clk_set_rate(tegra->emc_clock, 0);
 
 	return 0;
 }
@@ -619,7 +617,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
 	struct resource *res;
-	unsigned long max_freq;
 	unsigned int i;
 	int irq;
 	int err;
@@ -658,6 +655,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	clk_set_rate(tegra->emc_clock, ULONG_MAX);
+
 	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
 	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
 	if (err) {
@@ -677,11 +676,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	reset_control_deassert(tegra->reset);
 
-	max_freq = clk_round_rate(tegra->emc_clock, ULONG_MAX);
-	tegra->max_freq = max_freq / KHZ;
-
-	clk_set_rate(tegra->emc_clock, max_freq);
-
+	tegra->max_freq = clk_round_rate(tegra->emc_clock, ULONG_MAX) / KHZ;
 	tegra->cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
 
 	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
-- 
2.1.0
