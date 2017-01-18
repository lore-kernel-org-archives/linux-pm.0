From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] power: supply: qcom_smbb: add regulator dependency
Date: Wed, 18 Jan 2017 16:12:10 +0100
Message-ID: <20170118151233.1529065-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tim Bird <tim.bird@sonymobile.com>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <stephen.boyd@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The added regulator dependency in the smbb driver causes build errors
when regulators are disabled, e.g. in randconfig build testing:

drivers/power/supply/qcom_smbb.o: In function `smbb_chg_otg_is_enabled':
qcom_smbb.c:(.text.smbb_chg_otg_is_enabled+0x18): undefined reference to `rdev_get_drvdata'
drivers/power/supply/qcom_smbb.o: In function `smbb_charger_probe':
qcom_smbb.c:(.text.smbb_charger_probe+0x410): undefined reference to `devm_regulator_register'

This adds a Kconfig dependency to avoid the link error.

Fixes: 61274eff0dde ("power: supply: qcom_smbb: Add otg regulator for control of vbus")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/supply/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 59f9841dc246..5f134cf8988c 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -404,6 +404,7 @@ config CHARGER_QCOM_SMBB
 	depends on MFD_SPMI_PMIC || COMPILE_TEST
 	depends on OF
 	depends on EXTCON
+	depends on REGULATOR
 	help
 	  Say Y to include support for the Switch-Mode Battery Charger and
 	  Boost (SMBB) hardware found in Qualcomm PM8941 PMICs.  The charger
-- 
2.9.0
