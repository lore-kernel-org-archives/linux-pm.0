From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 3/7] arm: mach-u300: regulator: add missing of_node_put after calling of_parse_phandle
Date: Fri, 1 Jul 2016 17:41:57 +0800
Message-ID: <1467366121-14120-4-git-send-email-peter.chen__29316.9396849864$1467367688$gmane$org@nxp.com>
References: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Peter Chen <peter.chen@nxp.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pm@vger.kernel.org

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 arch/arm/mach-u300/regulator.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-u300/regulator.c b/arch/arm/mach-u300/regulator.c
index 595b574..509643e 100644
--- a/arch/arm/mach-u300/regulator.c
+++ b/arch/arm/mach-u300/regulator.c
@@ -71,19 +71,21 @@ static int __init __u300_init_boardpower(struct platform_device *pdev)
 	regmap = syscon_node_to_regmap(syscon_np);
 	if (IS_ERR(regmap)) {
 		pr_crit("U300: could not locate syscon regmap\n");
-		return PTR_ERR(regmap);
+		err = PTR_ERR(regmap);
+		goto error;
 	}
 
 	main_power_15 = regulator_get(&pdev->dev, "vana15");
 
 	if (IS_ERR(main_power_15)) {
 		pr_err("could not get vana15");
-		return PTR_ERR(main_power_15);
+		err = PTR_ERR(main_power_15);
+		goto error;
 	}
 	err = regulator_enable(main_power_15);
 	if (err) {
 		pr_err("could not enable vana15\n");
-		return err;
+		goto error;
 	}
 
 	/*
@@ -99,8 +101,12 @@ static int __init __u300_init_boardpower(struct platform_device *pdev)
 
 	/* Register globally exported PM poweroff hook */
 	pm_power_off = u300_pm_poweroff;
+	of_node_put(syscon_np);
 
 	return 0;
+error:
+	of_node_put(syscon_np);
+	return err;
 }
 
 static int __init s365_board_probe(struct platform_device *pdev)
-- 
1.9.1
