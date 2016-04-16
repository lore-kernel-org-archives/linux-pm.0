From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] thermal: tegra: mark PM functions __maybe_unused
Date: Sat, 16 Apr 2016 22:19:33 +0200
Message-ID: <1460838026-1242452-1-git-send-email-arnd@arndb.de>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

After the PM support has been added to this driver, we get
a harmless warning when that support is disabled at compile
time:

drivers/thermal/tegra/soctherm.c:641:12: error: 'soctherm_resume' defined but not used [-Werror=unused-function]
 static int soctherm_resume(struct device *dev)

This marks the two PM functions as __maybe_unused to shut up
the warning. This is preferred over adding an #ifdef around
them, as it is harder to get wrong, and provides better
compile-time coverage.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Fixes: a134b4143b65 ("thermal: tegra: add PM support")
---
 drivers/thermal/tegra/soctherm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 559c74279eb8..be829d6e131c 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -629,7 +629,7 @@ static int tegra_soctherm_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int soctherm_suspend(struct device *dev)
+static int __maybe_unused soctherm_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 
@@ -638,7 +638,7 @@ static int soctherm_suspend(struct device *dev)
 	return 0;
 }
 
-static int soctherm_resume(struct device *dev)
+static int __maybe_unused soctherm_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
-- 
2.7.0
