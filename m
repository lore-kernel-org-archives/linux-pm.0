From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 3/8] PM / devfreq: tegra: Don't ignore clk errors
Date: Fri, 12 Apr 2019 01:29:09 +0300
Message-ID: <20190411222914.25539-4-digetx@gmail.com>
References: <20190411222914.25539-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411222914.25539-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The clk_set_min_rate() could fail and in this case clk_set_rate() sets
rate to 0, which may drop EMC rate to minimum and make machine very
difficult to use.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index d749399f67ae..6185e7ab20a8 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -487,6 +487,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct dev_pm_opp *opp;
 	unsigned long rate;
+	int err;
 
 	opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(opp)) {
@@ -496,8 +497,13 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	rate = dev_pm_opp_get_freq(opp) * KHZ;
 	dev_pm_opp_put(opp);
 
-	clk_set_min_rate(tegra->emc_clock, rate);
-	clk_set_rate(tegra->emc_clock, 0);
+	err = clk_set_min_rate(tegra->emc_clock, rate);
+	if (err)
+		return err;
+
+	err = clk_set_rate(tegra->emc_clock, 0);
+	if (err)
+		return err;
 
 	return 0;
 }
-- 
2.21.0
