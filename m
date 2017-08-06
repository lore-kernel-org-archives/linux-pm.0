From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/3] power: supply: charger-manager: Fix a NULL pointer dereference in 'charger_manager_probe()'
Date: Mon,  7 Aug 2017 00:37:55 +0200
Message-ID: <09a9f8a61f784779d6127b83f9540ae1db4c25be.1502058761.git.christophe.jaillet@wanadoo.fr>
References: <cover.1502058761.git.christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1502058761.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1502058761.git.christophe.jaillet@wanadoo.fr>
References: <cover.1502058761.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-pm@vger.kernel.org

'devm_kzalloc()' can return NULL. Return -ENOMEM in this case in order to
avoid a NULL pointer dereference later on.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/power/supply/charger-manager.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index adc3761831e1..52a49857e20f 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1645,6 +1645,8 @@ static int charger_manager_probe(struct platform_device *pdev)
 	/* Initialize alarm timer */
 	if (alarmtimer_get_rtcdev()) {
 		cm_timer = devm_kzalloc(cm->dev, sizeof(*cm_timer), GFP_KERNEL);
+		if (!cm_timer)
+			return -ENOMEM;
 		alarm_init(cm_timer, ALARM_BOOTTIME, cm_timer_func);
 	}
 
-- 
2.11.0
