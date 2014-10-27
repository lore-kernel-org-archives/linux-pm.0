From: Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v2 06/10] mfd: tps65910: Use the standard DT property system-power-controller
Date: Mon, 27 Oct 2014 16:26:51 +0000
Message-ID: <1414427215-14380-6-git-send-email-romain.perier@gmail.com>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: devicetree@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, grant.likely@linaro.org, robh@kernel.org, mark.rutland@arm.com, johan@kernel.org, linux-pm@vger.kernel.org, linux@roeck-us.net, lee.jones@linaro.org, balbi@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

No longer use custom property to define poweroff capability, use the standard
DT property instead.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 drivers/mfd/tps65910.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 7612d89..a7faff2 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -423,8 +423,7 @@ static struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
 
 	board_info->irq = client->irq;
 	board_info->irq_base = -1;
-	board_info->pm_off = of_property_read_bool(np,
-			"ti,system-power-controller");
+	board_info->pm_off = of_is_system_power_controller();
 
 	return board_info;
 }
-- 
1.9.1
