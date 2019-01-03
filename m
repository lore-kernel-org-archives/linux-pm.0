From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v7 1/3] thermal: tegra: remove unnecessary warnings
Date: Thu, 3 Jan 2019 18:12:47 +0800
Message-ID: <1546510369-28491-2-git-send-email-wni@nvidia.com>
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546510369-28491-1-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, edubezval@gmail.com
Cc: thierry.reding@gmail.com, linux-tegra@vger.kernel.org, rui.zhang@intel.com, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Convert warnings to info as not all platforms may
have all the thresholds and sensors enabled.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index ed28110a3535..f07de8258e93 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -569,7 +569,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 set_throttle:
 	ret = get_hot_temp(tz, &trip, &temperature);
 	if (ret) {
-		dev_warn(dev, "throttrip: %s: missing hot temperature\n",
+		dev_info(dev, "throttrip: %s: missing hot temperature\n",
 			 sg->name);
 		return 0;
 	}
@@ -600,7 +600,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 	}
 
 	if (i == THROTTLE_SIZE)
-		dev_warn(dev, "throttrip: %s: missing throttle cdev\n",
+		dev_info(dev, "throttrip: %s: missing throttle cdev\n",
 			 sg->name);
 
 	return 0;
-- 
2.7.4
