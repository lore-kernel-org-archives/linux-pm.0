From: Kevin Hilman <khilman@kernel.org>
Subject: [PATCH] PM / domains: Kconfig: always enable PM_RUNTIME when genpd enabled
Date: Thu, 13 Nov 2014 14:28:21 -0800
Message-ID: <1415917702-6742-2-git-send-email-khilman@kernel.org>
References: <1415917702-6742-1-git-send-email-khilman@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415917702-6742-1-git-send-email-khilman@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Kevin Hilman <khilman@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Kevin Hilman <khilman@linaro.org>

It makes little sense to use generic power domains without runtime PM.
Also, since the complexities of handling the !PM_RUNTIME case are
causing more trouble and confusion than they're worth, let's simplify
the world by making genpd always enable runtime PM.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 kernel/power/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 3d39cc0228e9..2a8c64d0a43c 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -271,7 +271,7 @@ config PM_CLK
 
 config PM_GENERIC_DOMAINS
 	bool
-	depends on PM
+	select PM_RUNTIME
 
 config WQ_POWER_EFFICIENT_DEFAULT
 	bool "Enable workqueue power-efficient mode by default"
-- 
2.1.3
