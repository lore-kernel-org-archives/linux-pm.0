From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 13/16] drivers: sh: Disable legacy default PM Domain on emev2
Date: Wed,  1 Jul 2015 17:58:07 +0200
Message-ID: <1435766290-3005-14-git-send-email-geert+renesas@glider.be>
References: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

EMMA Mobile EV2 doesn't have MSTP clocks. All its device drivers manage
clocks explicitly, without relying on Runtime PM, so it doesn't need the
legacy default PM Domain.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New, extracted from "[PATCH v2 12/14] drivers: sh: Stop using
    pm_runtime.c for multi-platform shmobile with genpd".
---
 drivers/sh/pm_runtime.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index d3d1891cda3cf9a8..ad9188138ed56ffb 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -35,8 +35,7 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
 static int __init sh_pm_runtime_init(void)
 {
 	if (IS_ENABLED(CONFIG_ARCH_SHMOBILE_MULTI)) {
-		if (!of_machine_is_compatible("renesas,emev2") &&
-		    !of_machine_is_compatible("renesas,r7s72100") &&
+		if (!of_machine_is_compatible("renesas,r7s72100") &&
 #ifndef CONFIG_PM_GENERIC_DOMAINS_OF
 		    !of_machine_is_compatible("renesas,r8a73a4") &&
 		    !of_machine_is_compatible("renesas,r8a7740") &&
-- 
1.9.1

