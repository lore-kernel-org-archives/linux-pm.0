From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH RESEND 09/11] cpufreq: rewrite cpufreq_driver->flags using shift operator
Date: Wed,  2 Oct 2013 14:13:17 +0530
Message-ID: <7b34bf61846bed19e4a7e8ee18a55e717c570fef.1380703248.git.viresh.kumar@linaro.org>
References: <cover.1380703248.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:64503 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab3JBIoj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2013 04:44:39 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so583686pdj.36
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2013 01:44:38 -0700 (PDT)
In-Reply-To: <cover.1380703248.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380703248.git.viresh.kumar@linaro.org>
References: <cover.1380703248.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Currently cpufreq_driver's flags are defined directly using 0x1, 0x2, 0x4, 0x8,
etc.. As the list grows it doesn't stays much readable..

Lets use bitwise shift operator << to generate these numbers for respective
positions.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/cpufreq.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index a72bac2..9321059 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -225,13 +225,14 @@ struct cpufreq_driver {
 };
 
 /* flags */
-#define CPUFREQ_STICKY		0x01	/* the driver isn't removed even if
-					 * all ->init() calls failed */
-#define CPUFREQ_CONST_LOOPS	0x02	/* loops_per_jiffy or other kernel
-					 * "constants" aren't affected by
-					 * frequency transitions */
-#define CPUFREQ_PM_NO_WARN	0x04	/* don't warn on suspend/resume speed
-					 * mismatches */
+#define CPUFREQ_STICKY		(1 << 0)	/* driver isn't removed even if
+						   all ->init() calls failed */
+#define CPUFREQ_CONST_LOOPS	(1 << 1)	/* loops_per_jiffy or other
+						   kernel "constants" aren't
+						   affected by frequency
+						   transitions */
+#define CPUFREQ_PM_NO_WARN	(1 << 2)	/* don't warn on suspend/resume
+						   speed mismatches */
 
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
-- 
1.7.12.rc2.18.g61b472e

