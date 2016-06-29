From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] power: qcom-smbb: add extcon dependency
Date: Wed, 29 Jun 2016 16:30:02 +0200
Message-ID: <20160629143056.7405-1-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:50578 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbcF2OaQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2016 10:30:16 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Courtney Cavin <courtney.cavin@sonymobile.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Building the smbb driver without extcon results in a link failure:

drivers/power/built-in.o: In function `smbb_usb_valid_handler':
:(.text+0x3190): undefined reference to `extcon_set_cable_state_'
drivers/power/built-in.o: In function `smbb_charger_probe':
:(.text+0x3880): undefined reference to `devm_extcon_dev_allocate'
:(.text+0x3898): undefined reference to `devm_extcon_dev_register'

This adds a Kconfig dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 56d7df8716b2 ("power: Add Qualcomm SMBB driver")
---
 drivers/power/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 0f11a0f4c369..acd4a1524a1e 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -394,6 +394,7 @@ config CHARGER_QCOM_SMBB
 	tristate "Qualcomm Switch-Mode Battery Charger and Boost"
 	depends on MFD_SPMI_PMIC || COMPILE_TEST
 	depends on OF
+	depends on EXTCON
 	help
 	  Say Y to include support for the Switch-Mode Battery Charger and
 	  Boost (SMBB) hardware found in Qualcomm PM8941 PMICs.  The charger
-- 
2.9.0

