From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 083/102] thermal: tegra: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:26:27 +0200
Message-ID: <20170719152646.25903-84-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/thermal/tegra/soctherm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 7d2db23d71a32..06ce2becfc285 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1334,7 +1334,8 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		}
 	}
 
-	tegra->reset = devm_reset_control_get(&pdev->dev, "soctherm");
+	tegra->reset = devm_reset_control_get_exclusive(&pdev->dev,
+							"soctherm");
 	if (IS_ERR(tegra->reset)) {
 		dev_err(&pdev->dev, "can't get soctherm reset\n");
 		return PTR_ERR(tegra->reset);
-- 
2.11.0
