From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 14/14] ARM: shmobile: R-Mobile: Use CPG Clock Domain attach/detach helpers
Date: Thu, 28 May 2015 20:53:39 +0200
Message-ID: <1432839219-475-15-git-send-email-geert+renesas@glider.be>
References: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:60779 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810AbbE1Sxx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2015 14:53:53 -0400
In-Reply-To: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The R-Mobile PM Domain driver manages both power domains and a clock
domain.

The clock domain part is very similar to the CPG Clock Domain, which is
used on shmobile SoCs without device power domains, except for the way
how clocks suitable for power management are selected:
  - The former uses the first clock tied to the device through the NULL
    con_id, which is a relic from the legacy pm_clk_notifier-based
    method in drivers/sh/pm_runtime.c,
  - The latter looks for suitable clocks in DT, which is more
    future-proof.

Hence switch to using the CPG Clock Domain helpers for DT-based
multi-platform builds.

The old method, using a NULL con_id, is still used for legacy builds.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 arch/arm/mach-shmobile/pm-rmobile.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 747d557b7016ec6d..cac564c5348cd851 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -12,6 +12,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
+#include <linux/clk/shmobile.h>
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/of.h>
@@ -118,6 +119,7 @@ static bool rmobile_pd_active_wakeup(struct device *dev)
 	return true;
 }
 
+#ifdef CONFIG_ARCH_SHMOBILE_LEGACY
 static int rmobile_pd_attach_dev(struct generic_pm_domain *domain,
 				 struct device *dev)
 {
@@ -147,6 +149,10 @@ static void rmobile_pd_detach_dev(struct generic_pm_domain *domain,
 {
 	pm_clk_destroy(dev);
 }
+#else /* CONFIG_ARCH_SHMOBILE_LEGACY */
+#define rmobile_pd_attach_dev	cpg_mstp_attach_dev
+#define rmobile_pd_detach_dev	cpg_mstp_detach_dev
+#endif /* CONFIG_ARCH_SHMOBILE_LEGACY */
 
 static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 {
-- 
1.9.1

