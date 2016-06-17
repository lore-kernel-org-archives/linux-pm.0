From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/2] power/supply: unify DT documentation
Date: Fri, 17 Jun 2016 15:25:32 +0200
Message-ID: <1466169932-28031-3-git-send-email-sre@kernel.org>
References: <1466169932-28031-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466169932-28031-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently the power supply device tree documentation is spread
in .../bindings/power_supply and .../bindings/power. This
unifies the files for chargers and battery fuel gauges in
.../bindings/power/supply and the ones for system reset/shutdown
in .../bindings/power/reset (same structure as used for the
drivers itself).

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../devicetree/bindings/{power_supply => power/reset}/axxia-reset.txt  | 0
 .../bindings/{power_supply => power/reset}/imx-snvs-poweroff.txt       | 0
 .../devicetree/bindings/{power_supply => power/reset}/msm-poweroff.txt | 0
 .../bindings/{power_supply => power/reset}/qnap-poweroff.txt           | 0
 .../bindings/{power_supply => power/reset}/restart-poweroff.txt        | 0
 .../bindings/{power_supply => power/supply}/ab8500/btemp.txt           | 0
 .../bindings/{power_supply => power/supply}/ab8500/chargalg.txt        | 0
 .../bindings/{power_supply => power/supply}/ab8500/charger.txt         | 0
 .../devicetree/bindings/{power_supply => power/supply}/ab8500/fg.txt   | 0
 .../devicetree/bindings/power/{ => supply}/act8945a-charger.txt        | 0
 .../bindings/{power_supply => power/supply}/axp20x_usb_power.txt       | 0
 Documentation/devicetree/bindings/power/{ => supply}/bq2415x.txt       | 0
 Documentation/devicetree/bindings/power/{ => supply}/bq24257.txt       | 0
 Documentation/devicetree/bindings/power/{ => supply}/bq25890.txt       | 0
 .../bindings/{power_supply => power/supply}/charger-manager.txt        | 0
 .../devicetree/bindings/power/{ => supply}/da9150-charger.txt          | 0
 Documentation/devicetree/bindings/power/{ => supply}/da9150-fg.txt     | 0
 .../bindings/{power_supply => power/supply}/gpio-charger.txt           | 0
 Documentation/devicetree/bindings/power/{ => supply}/isp1704.txt       | 0
 .../bindings/{power_supply => power/supply}/lp8727_charger.txt         | 0
 Documentation/devicetree/bindings/power/{ => supply}/ltc2941.txt       | 0
 .../bindings/{power_supply => power/supply}/max17042_battery.txt       | 0
 .../bindings/{power_supply => power/supply}/max8925_batter.txt         | 0
 .../bindings/{power_supply => power/supply}/olpc_battery.txt           | 0
 .../bindings/{power_supply => power/supply}/power_supply.txt           | 0
 .../devicetree/bindings/power/{ => supply}/qcom,coincell-charger.txt   | 0
 .../devicetree/bindings/{power_supply => power/supply}/qcom_smbb.txt   | 0
 .../devicetree/bindings/power/{ => supply}/rt9455_charger.txt          | 0
 Documentation/devicetree/bindings/power/{ => supply}/rx51-battery.txt  | 0
 .../bindings/{power_supply => power/supply}/sbs_sbs-battery.txt        | 0
 .../devicetree/bindings/{power_supply => power/supply}/ti,bq24735.txt  | 0
 .../devicetree/bindings/{power_supply => power/supply}/tps65090.txt    | 0
 .../bindings/{power_supply => power/supply}/tps65217_charger.txt       | 0
 Documentation/devicetree/bindings/power/{ => supply}/twl-charger.txt   | 0
 MAINTAINERS                                                            | 3 +--
 35 files changed, 1 insertion(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/{power_supply => power/reset}/axxia-reset.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/reset}/imx-snvs-poweroff.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/reset}/msm-poweroff.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/reset}/qnap-poweroff.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/reset}/restart-poweroff.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/ab8500/btemp.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/ab8500/chargalg.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/ab8500/charger.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/ab8500/fg.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/act8945a-charger.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/axp20x_usb_power.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/bq2415x.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/bq24257.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/bq25890.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/charger-manager.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/da9150-charger.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/da9150-fg.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/gpio-charger.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/isp1704.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/lp8727_charger.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/ltc2941.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/max17042_battery.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/max8925_batter.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/olpc_battery.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/power_supply.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/qcom,coincell-charger.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/qcom_smbb.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/rt9455_charger.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/rx51-battery.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/sbs_sbs-battery.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/ti,bq24735.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/tps65090.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/tps65217_charger.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/twl-charger.txt (100%)

diff --git a/Documentation/devicetree/bindings/power_supply/axxia-reset.txt b/Documentation/devicetree/bindings/power/reset/axxia-reset.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/axxia-reset.txt
rename to Documentation/devicetree/bindings/power/reset/axxia-reset.txt
diff --git a/Documentation/devicetree/bindings/power_supply/imx-snvs-poweroff.txt b/Documentation/devicetree/bindings/power/reset/imx-snvs-poweroff.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/imx-snvs-poweroff.txt
rename to Documentation/devicetree/bindings/power/reset/imx-snvs-poweroff.txt
diff --git a/Documentation/devicetree/bindings/power_supply/msm-poweroff.txt b/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/msm-poweroff.txt
rename to Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
diff --git a/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt b/Documentation/devicetree/bindings/power/reset/qnap-poweroff.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
rename to Documentation/devicetree/bindings/power/reset/qnap-poweroff.txt
diff --git a/Documentation/devicetree/bindings/power_supply/restart-poweroff.txt b/Documentation/devicetree/bindings/power/reset/restart-poweroff.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/restart-poweroff.txt
rename to Documentation/devicetree/bindings/power/reset/restart-poweroff.txt
diff --git a/Documentation/devicetree/bindings/power_supply/ab8500/btemp.txt b/Documentation/devicetree/bindings/power/supply/ab8500/btemp.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/ab8500/btemp.txt
rename to Documentation/devicetree/bindings/power/supply/ab8500/btemp.txt
diff --git a/Documentation/devicetree/bindings/power_supply/ab8500/chargalg.txt b/Documentation/devicetree/bindings/power/supply/ab8500/chargalg.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/ab8500/chargalg.txt
rename to Documentation/devicetree/bindings/power/supply/ab8500/chargalg.txt
diff --git a/Documentation/devicetree/bindings/power_supply/ab8500/charger.txt b/Documentation/devicetree/bindings/power/supply/ab8500/charger.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/ab8500/charger.txt
rename to Documentation/devicetree/bindings/power/supply/ab8500/charger.txt
diff --git a/Documentation/devicetree/bindings/power_supply/ab8500/fg.txt b/Documentation/devicetree/bindings/power/supply/ab8500/fg.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/ab8500/fg.txt
rename to Documentation/devicetree/bindings/power/supply/ab8500/fg.txt
diff --git a/Documentation/devicetree/bindings/power/act8945a-charger.txt b/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/act8945a-charger.txt
rename to Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
diff --git a/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
rename to Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
diff --git a/Documentation/devicetree/bindings/power/bq2415x.txt b/Documentation/devicetree/bindings/power/supply/bq2415x.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/bq2415x.txt
rename to Documentation/devicetree/bindings/power/supply/bq2415x.txt
diff --git a/Documentation/devicetree/bindings/power/bq24257.txt b/Documentation/devicetree/bindings/power/supply/bq24257.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/bq24257.txt
rename to Documentation/devicetree/bindings/power/supply/bq24257.txt
diff --git a/Documentation/devicetree/bindings/power/bq25890.txt b/Documentation/devicetree/bindings/power/supply/bq25890.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/bq25890.txt
rename to Documentation/devicetree/bindings/power/supply/bq25890.txt
diff --git a/Documentation/devicetree/bindings/power_supply/charger-manager.txt b/Documentation/devicetree/bindings/power/supply/charger-manager.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/charger-manager.txt
rename to Documentation/devicetree/bindings/power/supply/charger-manager.txt
diff --git a/Documentation/devicetree/bindings/power/da9150-charger.txt b/Documentation/devicetree/bindings/power/supply/da9150-charger.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/da9150-charger.txt
rename to Documentation/devicetree/bindings/power/supply/da9150-charger.txt
diff --git a/Documentation/devicetree/bindings/power/da9150-fg.txt b/Documentation/devicetree/bindings/power/supply/da9150-fg.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/da9150-fg.txt
rename to Documentation/devicetree/bindings/power/supply/da9150-fg.txt
diff --git a/Documentation/devicetree/bindings/power_supply/gpio-charger.txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/gpio-charger.txt
rename to Documentation/devicetree/bindings/power/supply/gpio-charger.txt
diff --git a/Documentation/devicetree/bindings/power/isp1704.txt b/Documentation/devicetree/bindings/power/supply/isp1704.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/isp1704.txt
rename to Documentation/devicetree/bindings/power/supply/isp1704.txt
diff --git a/Documentation/devicetree/bindings/power_supply/lp8727_charger.txt b/Documentation/devicetree/bindings/power/supply/lp8727_charger.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/lp8727_charger.txt
rename to Documentation/devicetree/bindings/power/supply/lp8727_charger.txt
diff --git a/Documentation/devicetree/bindings/power/ltc2941.txt b/Documentation/devicetree/bindings/power/supply/ltc2941.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/ltc2941.txt
rename to Documentation/devicetree/bindings/power/supply/ltc2941.txt
diff --git a/Documentation/devicetree/bindings/power_supply/max17042_battery.txt b/Documentation/devicetree/bindings/power/supply/max17042_battery.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/max17042_battery.txt
rename to Documentation/devicetree/bindings/power/supply/max17042_battery.txt
diff --git a/Documentation/devicetree/bindings/power_supply/max8925_batter.txt b/Documentation/devicetree/bindings/power/supply/max8925_batter.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/max8925_batter.txt
rename to Documentation/devicetree/bindings/power/supply/max8925_batter.txt
diff --git a/Documentation/devicetree/bindings/power_supply/olpc_battery.txt b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/olpc_battery.txt
rename to Documentation/devicetree/bindings/power/supply/olpc_battery.txt
diff --git a/Documentation/devicetree/bindings/power_supply/power_supply.txt b/Documentation/devicetree/bindings/power/supply/power_supply.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/power_supply.txt
rename to Documentation/devicetree/bindings/power/supply/power_supply.txt
diff --git a/Documentation/devicetree/bindings/power/qcom,coincell-charger.txt b/Documentation/devicetree/bindings/power/supply/qcom,coincell-charger.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/qcom,coincell-charger.txt
rename to Documentation/devicetree/bindings/power/supply/qcom,coincell-charger.txt
diff --git a/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt b/Documentation/devicetree/bindings/power/supply/qcom_smbb.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
rename to Documentation/devicetree/bindings/power/supply/qcom_smbb.txt
diff --git a/Documentation/devicetree/bindings/power/rt9455_charger.txt b/Documentation/devicetree/bindings/power/supply/rt9455_charger.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/rt9455_charger.txt
rename to Documentation/devicetree/bindings/power/supply/rt9455_charger.txt
diff --git a/Documentation/devicetree/bindings/power/rx51-battery.txt b/Documentation/devicetree/bindings/power/supply/rx51-battery.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/rx51-battery.txt
rename to Documentation/devicetree/bindings/power/supply/rx51-battery.txt
diff --git a/Documentation/devicetree/bindings/power_supply/sbs_sbs-battery.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/sbs_sbs-battery.txt
rename to Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
diff --git a/Documentation/devicetree/bindings/power_supply/ti,bq24735.txt b/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/ti,bq24735.txt
rename to Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
diff --git a/Documentation/devicetree/bindings/power_supply/tps65090.txt b/Documentation/devicetree/bindings/power/supply/tps65090.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/tps65090.txt
rename to Documentation/devicetree/bindings/power/supply/tps65090.txt
diff --git a/Documentation/devicetree/bindings/power_supply/tps65217_charger.txt b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/tps65217_charger.txt
rename to Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
diff --git a/Documentation/devicetree/bindings/power/twl-charger.txt b/Documentation/devicetree/bindings/power/supply/twl-charger.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/twl-charger.txt
rename to Documentation/devicetree/bindings/power/supply/twl-charger.txt
diff --git a/MAINTAINERS b/MAINTAINERS
index a5a6705f34e7..5bac2dfac445 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9066,8 +9066,7 @@ M:	David Woodhouse <dwmw2@infradead.org>
 L:	linux-pm@vger.kernel.org
 T:	git git://git.infradead.org/battery-2.6.git
 S:	Maintained
-F:	Documentation/devicetree/bindings/power/
-F:	Documentation/devicetree/bindings/power_supply/
+F:	Documentation/devicetree/bindings/power/supply/
 F:	include/linux/power_supply.h
 F:	drivers/power/supply/
 
-- 
2.8.1
