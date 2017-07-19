From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 015/102] PM / devfreq: tegra: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:25:19 +0200
Message-ID: <20170719152646.25903-16-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/devfreq/tegra-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index ae712159246fb..8108487b34192 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -628,7 +628,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	if (IS_ERR(tegra->regs))
 		return PTR_ERR(tegra->regs);
 
-	tegra->reset = devm_reset_control_get(&pdev->dev, "actmon");
+	tegra->reset = devm_reset_control_get_exclusive(&pdev->dev, "actmon");
 	if (IS_ERR(tegra->reset)) {
 		dev_err(&pdev->dev, "Failed to get reset\n");
 		return PTR_ERR(tegra->reset);
-- 
2.11.0
