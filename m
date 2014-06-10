From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 15/24] ARM: exynos: Leave disabling of unused pm domains to genpd
Date: Tue, 10 Jun 2014 12:51:28 +0200
Message-ID: <1402397497-26737-16-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:56472 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbaFJKwm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 06:52:42 -0400
Received: by mail-la0-f44.google.com with SMTP id hr17so3899123lab.31
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2014 03:52:41 -0700 (PDT)
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

Since genpd at late init, will try to disable unused domains we don't
need to handle it from here as well.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-exynos/exynos.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index bc43e22..82ab996 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -193,7 +193,6 @@ void __init exynos_init_late(void)
 		/* to be supported later */
 		return;
 
-	pm_genpd_poweroff_unused();
 	exynos_pm_init();
 }
 
-- 
1.7.9.5

