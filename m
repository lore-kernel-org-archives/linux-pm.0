From: =?UTF-8?q?Christopher=20D=C3=ADaz=20Riveros?= <chrisadr@gentoo.org>
Subject: [PATCH-next] ab8500_fg: Remove unneeded semicolons
Date: Wed, 17 Jan 2018 20:46:10 -0500
Message-ID: <20180118014610.18298-1-chrisadr@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:52982 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752306AbeARBqR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jan 2018 20:46:17 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, =?UTF-8?q?Christopher=20D=C3=ADaz=20Riveros?= <chrisadr@gentoo.org>

Trivial fix removes unneeded semicolons after if blocks.

This issue was detected by using the Coccinelle software.

Signed-off-by: Christopher Díaz Riveros <chrisadr@gentoo.org>
---
 drivers/power/supply/ab8500_fg.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index c569f82a0071..613fb7b4456e 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2223,10 +2223,10 @@ static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 						ab8500_fg_update_cap_scalers(di);
 					queue_work(di->fg_wq, &di->fg_work);
 					break;
-				};
+				}
 			default:
 				break;
-			};
+			}
 			break;
 		case POWER_SUPPLY_PROP_TECHNOLOGY:
 			switch (ext->desc->type) {
@@ -2335,7 +2335,7 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
 		if (ret) {
 			dev_err(di->dev, "%s write failed AB8505_RTC_PCUT_MAX_TIME_REG\n", __func__);
 			goto out;
-		};
+		}
 
 		ret = abx500_set_register_interruptible(di->dev, AB8500_RTC,
 			AB8505_RTC_PCUT_FLAG_TIME_REG, di->bm->fg_params->pcut_flag_time);
@@ -2343,7 +2343,7 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
 		if (ret) {
 			dev_err(di->dev, "%s write failed AB8505_RTC_PCUT_FLAG_TIME_REG\n", __func__);
 			goto out;
-		};
+		}
 
 		ret = abx500_set_register_interruptible(di->dev, AB8500_RTC,
 			AB8505_RTC_PCUT_RESTART_REG, di->bm->fg_params->pcut_max_restart);
@@ -2351,7 +2351,7 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
 		if (ret) {
 			dev_err(di->dev, "%s write failed AB8505_RTC_PCUT_RESTART_REG\n", __func__);
 			goto out;
-		};
+		}
 
 		ret = abx500_set_register_interruptible(di->dev, AB8500_RTC,
 			AB8505_RTC_PCUT_DEBOUNCE_REG, di->bm->fg_params->pcut_debounce_time);
@@ -2359,7 +2359,7 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
 		if (ret) {
 			dev_err(di->dev, "%s write failed AB8505_RTC_PCUT_DEBOUNCE_REG\n", __func__);
 			goto out;
-		};
+		}
 
 		ret = abx500_set_register_interruptible(di->dev, AB8500_RTC,
 			AB8505_RTC_PCUT_CTL_STATUS_REG, di->bm->fg_params->pcut_enable);
@@ -2367,7 +2367,7 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
 		if (ret) {
 			dev_err(di->dev, "%s write failed AB8505_RTC_PCUT_CTL_STATUS_REG\n", __func__);
 			goto out;
-		};
+		}
 	}
 out:
 	return ret;
-- 
2.15.1
