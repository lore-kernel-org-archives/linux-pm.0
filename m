From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/6] power: supply: charger-manager: Fix some misspelled words
Date: Fri, 16 Nov 2018 19:01:09 +0800
Message-ID: <24406bab7e6b694c8eeb621c450ea7b039beb1d8.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org, linus.walleij@linaro.org
List-Id: linux-pm@vger.kernel.org

Fix some misspelled words.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/charger-manager.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index a1b420a..bd6c450 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -363,7 +363,7 @@ static int try_charger_enable(struct charger_manager *cm, bool enable)
 	int err = 0, i;
 	struct charger_desc *desc = cm->desc;
 
-	/* Ignore if it's redundent command */
+	/* Ignore if it's redundant command */
 	if (enable == cm->charger_enabled)
 		return 0;
 
@@ -1799,7 +1799,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 
 	/*
 	 * Charger-manager is capable of waking up the systme from sleep
-	 * when event is happend through cm_notify_event()
+	 * when event is happened through cm_notify_event()
 	 */
 	device_init_wakeup(&pdev->dev, true);
 	device_set_wakeup_capable(&pdev->dev, false);
@@ -2019,7 +2019,7 @@ static void __exit charger_manager_cleanup(void)
  * cm_notify_event - charger driver notify Charger Manager of charger event
  * @psy: pointer to instance of charger's power_supply
  * @type: type of charger event
- * @msg: optional message passed to uevent_notify fuction
+ * @msg: optional message passed to uevent_notify function
  */
 void cm_notify_event(struct power_supply *psy, enum cm_event_types type,
 		     char *msg)
-- 
1.7.9.5
