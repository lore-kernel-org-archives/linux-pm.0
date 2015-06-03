From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] drivers/cpufreq: include <module.h> for modular exynos-cpufreq.c code
Date: Wed, 3 Jun 2015 17:18:18 -0400
Message-ID: <1433366298-30016-1-git-send-email-paul.gortmaker@windriver.com>
References: <1430444867-22342-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:59700 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbbFCVTC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2015 17:19:02 -0400
In-Reply-To: <1430444867-22342-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org

This file is built off of a tristate Kconfig option ("ARM_EXYNOS_CPUFREQ")
and also contains modular function calls so it should explicitly include
module.h to avoid compile breakage during pending header shuffles.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[ patch will be appended to the implicit include fixup series, see:
  https://lkml.kernel.org/r/1430444867-22342-1-git-send-email-paul.gortmaker@windriver.com
  for the original series posting.]

 drivers/cpufreq/exynos-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 82d2fbb20f7e..4c157302365f 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -10,6 +10,7 @@
 */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-- 
2.2.1

