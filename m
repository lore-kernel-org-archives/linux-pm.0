From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 1/8] PM / devfreq: tegra: Fix kHz to Hz conversion
Date: Fri, 12 Apr 2019 01:29:07 +0300
Message-ID: <20190411222914.25539-2-digetx@gmail.com>
References: <20190411222914.25539-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411222914.25539-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The kHz to Hz is incorrectly converted in a few places in the code,
this results in a wrong frequency being calculated because devfreq core
uses OPP frequencies that are given in Hz to clamp the rate, while
tegra-devfreq gives to the core value in kHz and then it also expects to
receive value in kHz from the core. In a result memory freq is always set
to a value which is close to ULONG_MAX because of the bug. Hence the EMC
frequency is always capped to the maximum and the driver doesn't do
anything useful. Let's provide OPP with rates in kHz since this eliminates
few multiplies and divisions in the code. This patch was tested on Tegra30
and Tegra124 SoC's, EMC frequency scaling works properly now.

Cc: <stable@vger.kernel.org>
Tested-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index c89ba7b834ff..ec4ff55f5eea 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -394,7 +394,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 
 	tegra = container_of(nb, struct tegra_devfreq, rate_change_nb);
 
-	tegra->cur_freq = data->new_rate / KHZ;
+	tegra->cur_freq = data->new_rate;
 
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
 		dev = &tegra->devices[i];
@@ -486,21 +486,19 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct dev_pm_opp *opp;
-	unsigned long rate = *freq * KHZ;
+	unsigned long rate;
 
-	opp = devfreq_recommended_opp(dev, &rate, flags);
+	opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(opp)) {
 		dev_err(dev, "Failed to find opp for %lu KHz\n", *freq);
 		return PTR_ERR(opp);
 	}
-	rate = dev_pm_opp_get_freq(opp);
+	rate = dev_pm_opp_get_freq(opp) * KHZ;
 	dev_pm_opp_put(opp);
 
 	clk_set_min_rate(tegra->emc_clock, rate);
 	clk_set_rate(tegra->emc_clock, 0);
 
-	*freq = rate;
-
 	return 0;
 }
 
@@ -682,7 +680,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
 		rate = clk_round_rate(tegra->emc_clock, rate);
-		dev_pm_opp_add(&pdev->dev, rate, 0);
+		dev_pm_opp_add(&pdev->dev, rate / KHZ, 0);
 	}
 
 	irq = platform_get_irq(pdev, 0);
-- 
2.21.0
