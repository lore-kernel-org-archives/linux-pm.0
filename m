From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 13/17] thermal: tegra: enable+check sensor after its
 setup is finished
Date: Wed, 17 Oct 2018 17:52:39 +0200
Message-ID: <1539791563-5959-14-git-send-email-b.zolnierkie@samsung.com>
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155434epcas1p33a6de1fda3c69cc966f954796a95a935@epcas1p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Amit kucheria <amit.kucheria@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Enable+check sensor after setting zone->tz and programming hwtrips.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/tegra/soctherm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 2ac9f81..394b34e 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1375,9 +1375,6 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 			goto disable_clocks;
 		}
 
-		thermal_zone_set_mode(z, THERMAL_DEVICE_ENABLED);
-		thermal_zone_device_check(z);
-
 		zone->tz = z;
 		tegra->thermctl_tzs[soc->ttgs[i]->id] = z;
 
@@ -1385,6 +1382,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		err = tegra_soctherm_set_hwtrips(&pdev->dev, soc->ttgs[i], z);
 		if (err)
 			goto disable_clocks;
+
+		thermal_zone_set_mode(z, THERMAL_DEVICE_ENABLED);
+		thermal_zone_device_check(z);
 	}
 
 	soctherm_debug_init(pdev);
-- 
1.9.1
