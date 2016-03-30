From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 3/4] ARM: exynos: exynos-cpufreq platform device isn't supported anymore
Date: Wed, 30 Mar 2016 13:45:27 +0530
Message-ID: <abff8b995fce34ea80c68c5d11ccb8a525fb81fa.1459325515.git.viresh.kumar@linaro.org>
References: <cover.1459325515.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34989 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360AbcC3IPp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 04:15:45 -0400
Received: by mail-pf0-f181.google.com with SMTP id n5so36142707pfn.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2016 01:15:45 -0700 (PDT)
In-Reply-To: <cover.1459325515.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1459325515.git.viresh.kumar@linaro.org>
References: <cover.1459325515.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, mmcclint@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

The driver is removed long back and we don't support this device
anymore. Stop adding it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-exynos/exynos.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index bbf51a46f772..4dfce1069406 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -232,12 +232,8 @@ static void __init exynos_cpufreq_init(void)
 	const struct of_device_id *match;
 
 	match = of_match_node(exynos_cpufreq_matches, root);
-	if (!match) {
-		platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
-		return;
-	}
-
-	platform_device_register_simple(match->data, -1, NULL, 0);
+	if (match)
+		platform_device_register_simple(match->data, -1, NULL, 0);
 }
 
 static void __init exynos_dt_machine_init(void)
-- 
2.7.1.410.g6faf27b

