From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH v2 31/38] cpufreq: exynos4x12: Remove check for SOC_EXYNOS4412
Date: Mon, 17 Jun 2013 18:34:16 +0200
Message-ID: <1371486863-12398-32-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:10306 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab3FQQe4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2013 12:34:56 -0400
In-reply-to: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Tomasz Figa <t.figa@samsung.com>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>

Since SOC_EXYNOS4412 Kconfig symbol has been removed, it is enough to
check for SOC_EXYNOS4212 for both SoCs from Exynos4x12 series.

Cc: linux-pm@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index a924408..b214ad6 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -32,7 +32,7 @@ config ARM_EXYNOS4210_CPUFREQ
 	  SoC (S5PV310 or S5PC210).
 
 config ARM_EXYNOS4X12_CPUFREQ
-	def_bool (SOC_EXYNOS4212 || SOC_EXYNOS4412)
+	def_bool SOC_EXYNOS4212
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS4X12
 	  SoC (EXYNOS4212 or EXYNOS4412).
-- 
1.8.2.1

