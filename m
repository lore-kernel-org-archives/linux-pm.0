From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH] cpufreq: cpufreq-dt: Fix arguments in clock failure error message
Date: Fri, 31 Oct 2014 18:09:33 +0530
Message-ID: <1414759173-4664-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33995 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758182AbaJaMjw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Oct 2014 08:39:52 -0400
Received: by mail-pd0-f175.google.com with SMTP id y13so7233005pdi.34
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2014 05:39:52 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc: kesavan.abhilash@gmail.com, linux-pm@vger.kernel.org

Fix the swapped arguments in the clock failure dev_err.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/cpufreq/cpufreq-dt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 23aaf40..f657c57 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -166,8 +166,8 @@ try_again:
 		if (ret == -EPROBE_DEFER)
 			dev_dbg(cpu_dev, "cpu%d clock not ready, retry\n", cpu);
 		else
-			dev_err(cpu_dev, "failed to get cpu%d clock: %d\n", ret,
-				cpu);
+			dev_err(cpu_dev, "failed to get cpu%d clock: %d\n", cpu,
+				ret);
 	} else {
 		*cdev = cpu_dev;
 		*creg = cpu_reg;
-- 
1.7.9.5

