From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6/7] drivers: sh: Disable PM runtime for multi-platform sh73a0 with genpd
Date: Wed, 19 Nov 2014 16:57:33 +0100
Message-ID: <1416412654-6508-7-git-send-email-geert+renesas@glider.be>
References: <1416412654-6508-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1416412654-6508-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Philipp Zabel <philipp.zabel@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

If the default PM domain using PM_CLK is used for PM runtime, the real PM
domain(s) cannot be registered from DT later.

Hence do not enable it when running a multi-platform kernel with genpd
support on an sh73a0. The R-Mobile PM domain driver will take care of
PM runtime management of the module clocks.

The default PM domain is still needed for:
  - platforms without genpd support,
  - the legacy (non-DT) case, where genpd may take over later, except
    for the C5 "always on" PM domain.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/sh/pm_runtime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index 85cc89fd3e7d7cb7..2e6f1efadedca1b0 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -83,6 +83,7 @@ static int __init sh_pm_runtime_init(void)
 		    !of_machine_is_compatible("renesas,r8a73a4") &&
 #ifndef CONFIG_PM_GENERIC_DOMAINS_OF
 		    !of_machine_is_compatible("renesas,r8a7740") &&
+		    !of_machine_is_compatible("renesas,sh73a0") &&
 #endif
 		    !of_machine_is_compatible("renesas,r8a7778") &&
 		    !of_machine_is_compatible("renesas,r8a7779") &&
@@ -91,8 +92,7 @@ static int __init sh_pm_runtime_init(void)
 		    !of_machine_is_compatible("renesas,r8a7792") &&
 		    !of_machine_is_compatible("renesas,r8a7793") &&
 		    !of_machine_is_compatible("renesas,r8a7794") &&
-		    !of_machine_is_compatible("renesas,sh7372") &&
-		    !of_machine_is_compatible("renesas,sh73a0"))
+		    !of_machine_is_compatible("renesas,sh7372"))
 			return 0;
 	}
 
-- 
1.9.1

