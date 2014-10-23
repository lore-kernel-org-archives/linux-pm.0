From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 04/11] ARM: shmobile: armadillo800eva legacy: Add missing A4S pm domain devices
Date: Thu, 23 Oct 2014 13:18:54 +0200
Message-ID: <1414063141-8856-5-git-send-email-geert+renesas@glider.be>
References: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Commit 8459293c27bcd13a ("ARM: shmobile: r8a7740: add A4S pm domain
support") added the A4S power domain, but forgot to hook up the GbEther
hardware block.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,
v2:
  - No changes.
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 64a68450c28a072c..735036038951868d 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1234,6 +1234,7 @@ static void __init eva_init(void)
 	static struct pm_domain_device domain_devices[] __initdata = {
 		{ "A4LC", &lcdc0_device },
 		{ "A4LC", &hdmi_lcdc_device },
+		{ "A4S",  &sh_eth_device },
 		{ "A3SP", &pwm_device },
 		{ "A3SP", &sdhi0_device },
 		{ "A3SP", &sh_mmcif_device },
-- 
1.9.1

