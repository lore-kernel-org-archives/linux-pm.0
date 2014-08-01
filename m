From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 1/1] cpufreq: s5pv210: Fix section mismatch warning
Date: Fri,  1 Aug 2014 16:44:51 +0530
Message-ID: <1406891691-27708-1-git-send-email-sachin.kamat@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:55530 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbaHALPW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Aug 2014 07:15:22 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so5596438pac.17
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2014 04:15:22 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, tomasz.figa@gmail.com, kgene.kim@samsung.com, spk.linux@gmail.com

struct s5pv210_driver is registered in probe function which
does not have __init annotation. However s5pv210_driver contains
the pointer to s5pv210_cpu_init() which is annotated with __init
which causes the following section mismatch warning:
WARNING: drivers/cpufreq/built-in.o(.data+0xc3c): Section mismatch in reference from the variable s5pv210_driver to the function .init.text:s5pv210_cpu_init()

Fixed by removing the annotation for s5pv210_cpu_init.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 9a68225..3f9791f 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -501,7 +501,7 @@ static int check_mem_type(void __iomem *dmc_reg)
 	return val >> 8;
 }
 
-static int __init s5pv210_cpu_init(struct cpufreq_policy *policy)
+static int s5pv210_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned long mem_type;
 	int ret;
-- 
1.8.1.2

