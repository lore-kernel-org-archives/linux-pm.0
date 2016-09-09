From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/3] cpufreq: dt: Update kconfig description
Date: Fri,  9 Sep 2016 16:48:07 +0530
Message-ID: <e18de40d985244d3a2078c15ed71935becb21694.1473419844.git.viresh.kumar@linaro.org>
References: <1f5ea403f4a540a0187586e60b4f3a934fa0fc7d.1473419844.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36660 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753820AbcIILSS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2016 07:18:18 -0400
Received: by mail-pa0-f42.google.com with SMTP id id6so27589697pad.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Sep 2016 04:18:18 -0700 (PDT)
In-Reply-To: <1f5ea403f4a540a0187586e60b4f3a934fa0fc7d.1473419844.git.viresh.kumar@linaro.org>
In-Reply-To: <1f5ea403f4a540a0187586e60b4f3a934fa0fc7d.1473419844.git.viresh.kumar@linaro.org>
References: <1f5ea403f4a540a0187586e60b4f3a934fa0fc7d.1473419844.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Juri.Lelli@arm.com, arnd.bergmann@linaro.org

The cpufreq DT driver also supports systems that have multiple
clock/voltage domains for CPUs, i.e. multiple policy systems.

The description of the Kconfig entry was never updated after the driver
was modified to support such systems, fix it.

Reported-by: Juri Lelli <Juri.Lelli@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 4dc95250cf4e..d8b164a7c4e5 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -222,7 +222,7 @@ config CPUFREQ_DT
 	help
 	  This adds a generic DT based cpufreq driver for frequency management.
 	  It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
-	  systems which share clock and voltage across all CPUs.
+	  systems.
 
 	  If in doubt, say N.
 
-- 
2.7.1.410.g6faf27b

