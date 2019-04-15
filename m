From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 07/19] PM / devfreq: tegra: Register clk notifier in the end of driver's probe
Date: Mon, 15 Apr 2019 17:54:53 +0300
Message-ID: <20190415145505.18397-8-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The notifier isn't unregistered if something fails after the registration,
move it to the end of probe to fix the potential use-after-free problem.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index aa0478464b35..c248c18431d9 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -647,14 +647,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->emc_clock);
 	}
 
-	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
-	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
-	if (err) {
-		dev_err(&pdev->dev,
-			"Failed to register rate change notifier\n");
-		return err;
-	}
-
 	reset_control_assert(tegra->reset);
 
 	err = clk_prepare_enable(tegra->clock);
@@ -712,6 +704,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
+	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
+	if (err) {
+		dev_err(&pdev->dev,
+			"Failed to register rate change notifier\n");
+		return err;
+	}
+
 	return 0;
 }
 
-- 
2.21.0
