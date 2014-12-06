From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] video / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Sat, 06 Dec 2014 03:36:46 +0100
Message-ID: <19160360.7uJRUqlDQg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57757 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752054AbaLFCPT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Dec 2014 21:15:19 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
depending on CONFIG_PM_RUNTIME may now be changed to depend on
CONFIG_PM.

The alternative of CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME may be
replaced with CONFIG_PM too.

Make these changes in 2 files under drivers/video/.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
PM_SLEEP is selected) which is only in linux-next at the moment (via the
linux-pm tree).

Please let me know if it is OK to take this one into linux-pm.

---
 drivers/video/fbdev/s3c-fb.c          |    2 +-
 drivers/video/fbdev/sh_mobile_meram.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/video/fbdev/sh_mobile_meram.c
===================================================================
--- linux-pm.orig/drivers/video/fbdev/sh_mobile_meram.c
+++ linux-pm/drivers/video/fbdev/sh_mobile_meram.c
@@ -569,7 +569,7 @@ EXPORT_SYMBOL_GPL(sh_mobile_meram_cache_
  * Power management
  */
 
-#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
+#ifdef CONFIG_PM
 static int sh_mobile_meram_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -612,7 +612,7 @@ static int sh_mobile_meram_resume(struct
 		meram_write_reg(priv->base, common_regs[i], priv->regs[i]);
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP || CONFIG_PM_RUNTIME */
+#endif /* CONFIG_PM */
 
 static UNIVERSAL_DEV_PM_OPS(sh_mobile_meram_dev_pm_ops,
 			    sh_mobile_meram_suspend,
Index: linux-pm/drivers/video/fbdev/s3c-fb.c
===================================================================
--- linux-pm.orig/drivers/video/fbdev/s3c-fb.c
+++ linux-pm/drivers/video/fbdev/s3c-fb.c
@@ -1630,7 +1630,7 @@ static int s3c_fb_resume(struct device *
 }
 #endif
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static int s3c_fb_runtime_suspend(struct device *dev)
 {
 	struct s3c_fb *sfb = dev_get_drvdata(dev);

