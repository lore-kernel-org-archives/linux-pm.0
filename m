From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] cpufreq: dt: add Socionext UniPhier SoCs support
Date: Thu, 27 Oct 2016 01:41:33 +0900
Message-ID: <1477500093-12796-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from conuserg-08.nifty.com ([210.131.2.75]:31478 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbcJZQmM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2016 12:42:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org

Add compatible strings for Pro5, PXs2, LD6b, LD11, LD20 SoCs to use
the generic cpufreq driver.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/cpufreq/cpufreq-dt-platdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 7126762..f3c9a0e 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -72,6 +72,12 @@
 
 	{ .compatible = "sigma,tango4" },
 
+	{ .compatible = "socionext,uniphier-pro5", },
+	{ .compatible = "socionext,uniphier-pxs2", },
+	{ .compatible = "socionext,uniphier-ld6b", },
+	{ .compatible = "socionext,uniphier-ld11", },
+	{ .compatible = "socionext,uniphier-ld20", },
+
 	{ .compatible = "ti,am33xx", },
 	{ .compatible = "ti,dra7", },
 	{ .compatible = "ti,omap2", },
-- 
1.9.1

