From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] power: reset: Add MFD_SYSCON depends for brcmstb
Date: Thu, 30 Apr 2015 12:55:02 -0700
Message-ID: <1430423702-6320-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33344 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbD3TzN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2015 15:55:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, computersforpeace@gmail.com, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>

The Broadcom STB reboot driver depends on MFD_SYSCON, it uses
syscon_regmap_lookup_by_phandle() which will not lookup syscon phandles
if MFD_SYSCON is disabled, and instead will return -ENOSYS since it is
turned into an inline stub.

Fixes: 030494e75064c ("power: reset: Add reboot driver for brcmstb")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Sebastian,

Could you queue this as a fix for 4.1? Thanks!

 drivers/power/reset/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 028e76504519..f37135c312fd 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -41,6 +41,7 @@ config POWER_RESET_AXXIA
 config POWER_RESET_BRCMSTB
 	bool "Broadcom STB reset driver" if COMPILE_TEST
 	depends on ARM
+	depends on MFD_SYSCON
 	default ARCH_BRCMSTB
 	help
 	  This driver provides restart support for ARM-based Broadcom STB
-- 
2.1.0

