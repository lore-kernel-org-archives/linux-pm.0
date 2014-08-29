From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 01/11] ARM: shmobile: r8a7740: Add missing A3SP pm domain devices
Date: Fri, 29 Aug 2014 15:50:07 +0200
Message-ID: <1409320217-13278-2-git-send-email-geert+renesas@glider.be>
References: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:46352 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbaH2Nub (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Aug 2014 09:50:31 -0400
In-Reply-To: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

Commit 802a5639aa7041b2 ("ARM: shmobile: r8a7740: add A3SP pm domain
support") added the A3SP power domain, but forgot to hook up the IPPMU,
DMAC0/1/2, and USBDMAC hardware blocks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/setup-r8a7740.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 8894e1b7ab0e..6992d4013ef0 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -756,6 +756,11 @@ void __init r8a7740_add_standard_devices(void)
 		{ "A3SP", &scif7_device },
 		{ "A3SP", &scif8_device },
 		{ "A3SP", &i2c1_device },
+		{ "A3SP", &ipmmu_device },
+		{ "A3SP", &dma0_device },
+		{ "A3SP", &dma1_device },
+		{ "A3SP", &dma2_device },
+		{ "A3SP", &usb_dma_device },
 	};
 
 	/* I2C work-around */
-- 
1.7.9.5

