From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/3] cpufreq: s3c2440: Remove hardware.h inclusion
Date: Fri,  3 Jan 2014 14:57:35 +0530
Message-ID: <1388741257-26438-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36934 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbaACJb1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jan 2014 04:31:27 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so15266667pde.27
        for <linux-pm@vger.kernel.org>; Fri, 03 Jan 2014 01:31:26 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, sachin.kamat@linaro.org, patches@linaro.org

The contents of this header file are not referenced in the driver.
Remove its inclusion.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/cpufreq/s3c2440-cpufreq.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/s3c2440-cpufreq.c b/drivers/cpufreq/s3c2440-cpufreq.c
index 72b2cc8a5a85..717ef04ec90e 100644
--- a/drivers/cpufreq/s3c2440-cpufreq.c
+++ b/drivers/cpufreq/s3c2440-cpufreq.c
@@ -22,8 +22,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
-
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-- 
1.7.9.5

