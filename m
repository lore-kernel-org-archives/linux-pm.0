From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 04/19] PM / devfreq: tegra: Don't set EMC clock rate to maximum on probe
Date: Mon, 15 Apr 2019 17:54:50 +0300
Message-ID: <20190415145505.18397-5-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

There is no real benefit from doing so, hence let's drop that rate setting
for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 69581c9082d4..d62fb1b0d9bb 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -648,8 +648,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->emc_clock);
 	}
 
-	clk_set_rate(tegra->emc_clock, ULONG_MAX);
-
 	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
 	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
 	if (err) {
-- 
2.21.0
