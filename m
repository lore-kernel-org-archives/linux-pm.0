From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 01/19] PM / devfreq: tegra: Fix kHz to Hz conversion
Date: Mon, 15 Apr 2019 17:54:47 +0300
Message-ID: <20190415145505.18397-2-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The kHz to Hz is incorrectly converted in a few places in the code,
this results in a wrong frequency being calculated because devfreq core
uses OPP frequencies that are given in Hz to clamp the rate, while
tegra-devfreq gives to the core value in kHz and then it also expects to
receive value in kHz from the core. In a result memory freq is always set
to a value which is close to ULONG_MAX because of the bug. Hence the EMC
frequency is always capped to the maximum and the driver doesn't do
anything useful. This patch was tested on Tegra30 and Tegra124 SoC's, EMC
frequency scaling works properly now.

Cc: <stable@vger.kernel.org> # 4.14+
Tested-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index c89ba7b834ff..02905978abe1 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -486,9 +486,9 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
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
@@ -499,8 +499,6 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	clk_set_min_rate(tegra->emc_clock, rate);
 	clk_set_rate(tegra->emc_clock, 0);
 
-	*freq = rate;
-
 	return 0;
 }
 
@@ -510,7 +508,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct tegra_devfreq_device *actmon_dev;
 
-	stat->current_frequency = tegra->cur_freq;
+	stat->current_frequency = tegra->cur_freq * KHZ;
 
 	/* To be used by the tegra governor */
 	stat->private_data = tegra;
@@ -565,7 +563,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
 		target_freq = max(target_freq, dev->target_freq);
 	}
 
-	*freq = target_freq;
+	*freq = target_freq * KHZ;
 
 	return 0;
 }
-- 
2.21.0
