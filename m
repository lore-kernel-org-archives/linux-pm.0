From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 01/21] ARM: pxa: magician: Fix Kconfig for magician to
 always include htc-egpio
Date: Mon, 17 Aug 2015 23:56:16 +0200
Message-ID: <55D25880.3030507@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:49547 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbbHQVxY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Aug 2015 17:53:24 -0400
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The htc-egpio driver should be always included in the kernel as it
controls MMC/charging/IrDA power, which is the only way to get
an useful rootfs.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index f096836..5c7b6ee 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -294,6 +294,7 @@ config MACH_MAGICIAN
 	bool "Enable HTC Magician Support"
 	select IWMMXT
 	select PXA27x
+	select HTC_EGPIO
 
 config MACH_MIOA701
 	bool "Mitac Mio A701 Support"
-- 
1.7.12.1

