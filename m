From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 1/9] power/reset: brcmstb: Make the driver buildable on MIPS
Date: Tue, 25 Nov 2014 16:49:46 -0800
Message-ID: <1416962994-27095-2-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:49039 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbaKZAv0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 19:51:26 -0500
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, arnd@arndb.de, linux@prisktech.co.nz, stern@rowland.harvard.edu, gregkh@linuxfoundation.org, f.fainelli@gmail.com
Cc: grant.likely@linaro.org, robh+dt@kernel.org, computersforpeace@gmail.com, marc.ceeeee@gmail.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mips@linux-mips.org

Now that the driver doesn't use any ARM-specific headers, it is safe
to build on MIPS or with COMPILE_TEST.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/power/reset/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index f65ff49..0379846 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -39,14 +39,13 @@ config POWER_RESET_AXXIA
 	  Say Y if you have an Axxia family SoC.
 
 config POWER_RESET_BRCMSTB
-	bool "Broadcom STB reset driver" if COMPILE_TEST
-	depends on ARM
+	bool "Broadcom STB reset driver"
+	depends on ARM || MIPS || COMPILE_TEST
 	default ARCH_BRCMSTB
 	help
-	  This driver provides restart support for ARM-based Broadcom STB
-	  boards.
+	  This driver provides restart support for Broadcom STB boards.
 
-	  Say Y here if you have an ARM-based Broadcom STB board and you wish
+	  Say Y here if you have a Broadcom STB board and you wish
 	  to have restart support.
 
 config POWER_RESET_GPIO
-- 
2.1.0

