From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 4/4] power: supply: sc2731_charger: Free battery information
Date: Mon, 12 Nov 2018 18:52:38 +0800
Message-ID: <ac427c3cca2cc783a82a3d8d62270c1ed139e8c4.1542019800.git.baolin.wang@linaro.org>
References: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
In-Reply-To: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
References: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

Free battery information in case of adding battery OCV tables.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc2731_charger.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index 49b3f0c..335cb85 100644
--- a/drivers/power/supply/sc2731_charger.c
+++ b/drivers/power/supply/sc2731_charger.c
@@ -408,6 +408,8 @@ static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
 			vol_val = (term_voltage - 4200) / 100;
 		else
 			vol_val = 0;
+
+		power_supply_put_battery_info(info->psy_usb, &bat_info);
 	}
 
 	/* Set charge termination current */
-- 
1.7.9.5
