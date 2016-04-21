From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/10] cpufreq: mvebu: Use generic platdev driver
Date: Thu, 21 Apr 2016 14:29:02 +0530
Message-ID: <1c2cc13d812e04f231ddd4313e3ba6a54fb4632c.1461228504.git.viresh.kumar@linaro.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33420 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbcDUI74 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 04:59:56 -0400
Received: by mail-pf0-f182.google.com with SMTP id 184so28329189pff.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2016 01:59:55 -0700 (PDT)
In-Reply-To: <cover.1461228504.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461228504.git.viresh.kumar@linaro.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, sboyd@codeaurora.org, arnd.bergmann@linaro.org, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-mvebu/pmsu.c           | 2 --
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 79d0a5d9da8e..f24f46776fbb 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -685,8 +685,6 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
 				__func__, ret);
 	}
-
-	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 	return 0;
 }
 
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 69b2a222c84e..5704a92c52dc 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -33,6 +33,8 @@ static const struct of_device_id machines[] = {
 
 	{ .compatible = "marvell,berlin", },
 
+	{ .compatible = "marvell,armadaxp", },
+
 	{ .compatible = "samsung,exynos3250", },
 	{ .compatible = "samsung,exynos4210", },
 	{ .compatible = "samsung,exynos4212", },
-- 
2.7.1.410.g6faf27b

