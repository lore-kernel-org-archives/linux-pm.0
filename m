From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 3/6] power: supply: charger-manager: Fix incorrect return value
Date: Fri, 16 Nov 2018 19:01:10 +0800
Message-ID: <edef76d756eeae2708f5a23f4d8f1f742fac76a7.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org, linus.walleij@linaro.org
List-Id: linux-pm@vger.kernel.org

Fix incorrect return value.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/charger-manager.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index bd6c450..a52bc77 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1212,7 +1212,6 @@ static int charger_extcon_init(struct charger_manager *cm,
 	if (ret < 0) {
 		pr_info("Cannot register extcon_dev for %s(cable: %s)\n",
 			cable->extcon_name, cable->name);
-		ret = -EINVAL;
 	}
 
 	return ret;
@@ -1633,7 +1632,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 
 	if (IS_ERR(desc)) {
 		dev_err(&pdev->dev, "No platform data (desc) found\n");
-		return -ENODEV;
+		return PTR_ERR(desc);
 	}
 
 	cm = devm_kzalloc(&pdev->dev, sizeof(*cm), GFP_KERNEL);
-- 
1.7.9.5
