From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] hwrandom / exynos / PM: Use CONFIG_PM in #ifdef
Date: Wed, 03 Dec 2014 02:40:35 +0100
Message-ID: <1743562.8SOccckWiK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55098 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751005AbaLCBTK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 20:19:10 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-samsung-soc@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

CONFIG_PM is defined as the alternative of CONFIG_PM_RUNTIME and
CONFIG_PM_SLEEP, so it can be used instead of that.

Besides, after commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
PM_SLEEP is selected) PM_RUNTIME is always set if PM is set, so
using the alternative isn't even necessary.

Use CONFIG_PM instead of it in drivers/char/hw_random/exynos-rng.c.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Please let me know if it is OK to take this one into linux-pm.

---
 drivers/char/hw_random/exynos-rng.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/char/hw_random/exynos-rng.c
===================================================================
--- linux-pm.orig/drivers/char/hw_random/exynos-rng.c
+++ linux-pm/drivers/char/hw_random/exynos-rng.c
@@ -143,7 +143,7 @@ static int exynos_rng_remove(struct plat
 	return 0;
 }
 
-#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
+#ifdef CONFIG_PM
 static int exynos_rng_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);

