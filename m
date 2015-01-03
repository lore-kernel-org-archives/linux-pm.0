From: Paolo Teti <paolo.teti@gmail.com>
Subject: [PATCH 1/1] cpufreq: s3c64xx: force regulator descriptor to NULL when disabled
Date: Sat,  3 Jan 2015 16:29:34 +0100
Message-ID: <1420298974-3478-1-git-send-email-paolo.teti@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33337 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbbACPaJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jan 2015 10:30:09 -0500
Received: by mail-wg0-f45.google.com with SMTP id b13so25335317wgh.4
        for <linux-pm@vger.kernel.org>; Sat, 03 Jan 2015 07:30:08 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Paolo Teti <paolo.teti@gmail.com>

Be sure 'vddarm' is NULL when regulator is disabled, otherwise few line
later this test

if (!vddarm && freq->frequency > clk_get_rate(policy->clk) / 1000)

may be false braking assumption that if not regulator is available
the maximum frequency We can support is the start-up frequency.

Signed-off-by: Paolo Teti <paolo.teti@gmail.com>
---
 drivers/cpufreq/s3c64xx-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index 176e84c..8a9e082 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -175,6 +175,8 @@ static int s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
 	} else {
 		s3c64xx_cpufreq_config_regulator();
 	}
+#else
+	vddarm = NULL;
 #endif
 
 	cpufreq_for_each_entry(freq, s3c64xx_freq_table) {
-- 
1.9.1

