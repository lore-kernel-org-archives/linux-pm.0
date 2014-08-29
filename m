From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 08/11] [WIP] ARM: shmobile: r8a7740: Add D4 pm domain support
Date: Fri, 29 Aug 2014 15:50:14 +0200
Message-ID: <1409320217-13278-9-git-send-email-geert+renesas@glider.be>
References: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add support for the D4 power domain.
This domain contains the Coresight-ETM hardware block.

FIXME: D4 is not added, as this breaks resume (dbg_cpu_pm_notify() calls
       reset_ctrl_regs(), which crashes as D4 is powered down, and commit
       0d352e3d006c9589 ("ARM: hw_breakpoint: trap undef instruction
       exceptions in reset_ctrl_regs") doesn't seem to work...)

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-r8a7740.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 86b2df8b5391..cbdb87c67711 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -40,6 +40,9 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 //		.genpd.name	= "A4MP",
 //		.bit_shift	= 2,
 //	}, {
+//		.genpd.name	= "D4",
+//		.bit_shift	= 3,
+//	}, {
 		.genpd.name	= "A3RV",
 		.bit_shift	= 6,
 	}, {
-- 
1.7.9.5

