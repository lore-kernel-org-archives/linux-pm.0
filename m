From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 08/11] ARM: shmobile: r8a7740: Add D4 pm domain support
Date: Thu, 25 Sep 2014 18:15:39 +0200
Message-ID: <1411661742-4767-9-git-send-email-geert+renesas@glider.be>
References: <1411661742-4767-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1411661742-4767-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add support for the D4 power domain.
This domain contains the Coresight-ETM hardware block.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "[PATCH] ARM: hw_breakpoint: Trap undef instruction
exceptions on wake-up", or an alternative solution. Else resuming from
s2ram will cause a crash.

v2:
  - Really add D4 and drop the FIXME, as a fix for the crash is
    available.
---
 arch/arm/mach-shmobile/pm-r8a7740.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 081a4f9726a0c909..6697ac00eff72957 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -40,6 +40,9 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 		.genpd.name	= "A4MP",
 		.bit_shift	= 2,
 	}, {
+		.genpd.name	= "D4",
+		.bit_shift	= 3,
+	}, {
 		.genpd.name	= "A3RV",
 		.bit_shift	= 6,
 	}, {
-- 
1.9.1

