From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v3 10/26] ARM: pxa: magician: Optimize Samsung LCD refresh to
 50Hz
Date: Thu, 17 Sep 2015 06:57:59 +0200
Message-ID: <55FA4857.5030904@tul.cz>
References: <cover.1442462898.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:37103 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbbIQE6G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Sep 2015 00:58:06 -0400
In-Reply-To: <cover.1442462898.git.petr.cvek@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, lee.jones@linaro.org, sameo@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, g.liakhovetski@gmx.de
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Change the default Samsung LCD refresh from an unrealistic 117Hz to 50Hz
as no video applications on the HTC Magician can work that fast.

The optimalization lowers the RAM latency at least by 3%.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 14d1f55..2c487ae 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -317,7 +317,7 @@ static struct pxafb_mode_info toppoly_modes[] = {
 
 static struct pxafb_mode_info samsung_modes[] = {
 	{
-		.pixclock	= 96153,
+		.pixclock	= 226469,
 		.bpp		= 16,
 		.xres		= 240,
 		.yres		= 320,
-- 
1.7.12.1

