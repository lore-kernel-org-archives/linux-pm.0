From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 2/6] ARM: mxs: select syscon for platform
Date: Wed, 29 Apr 2015 22:32:23 +0000
Message-ID: <1430346747-28728-3-git-send-email-stefan.wahren@i2se.com>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:53933 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbbD2WeL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2015 18:34:11 -0400
In-Reply-To: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, fabio.estevam@freescale.com, sebastien.szymanski@armadeus.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

Select syscon for the MXS platform because it's required by the
power subsystem.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/mach-mxs/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 8479413..bf04d38 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -17,6 +17,7 @@ config ARCH_MXS
 	depends on ARCH_MULTI_V5
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_MMIO
+	select MFD_SYSCON
 	select PINCTRL
 	select SOC_BUS
 	select SOC_IMX23
-- 
1.7.9.5

