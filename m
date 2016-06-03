From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 7/9] cpufreq: maple: Use 'index' only to index into policy->freq_table
Date: Fri,  3 Jun 2016 19:05:13 +0530
Message-ID: <f7c6bb5b5b2c22a5b929d5a116e1c91220154c29.1464960877.git.viresh.kumar@linaro.org>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36783 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932953AbcFCNfw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jun 2016 09:35:52 -0400
Received: by mail-pa0-f49.google.com with SMTP id te7so11416015pab.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Jun 2016 06:35:52 -0700 (PDT)
In-Reply-To: <cover.1464960877.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464960877.git.viresh.kumar@linaro.org>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Steven Miao <realmz6@gmail.com>

Later patches would make changes in cpufreq core, after which
policy->freq_table may be reordered by cpufreq core and it wouldn't be
safe anymore to use 'index' for any other local arrays.

To prepare for that, use policy->freq_table[index].driver_data for other
driver specific usage of 'index'. The 'driver_data' fields are already
set properly by the driver.

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/maple-cpufreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
index d9df89392b84..8ce92ee7dd8d 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -133,6 +133,12 @@ static int maple_scom_query_freq(void)
 static int maple_cpufreq_target(struct cpufreq_policy *policy,
 	unsigned int index)
 {
+	/*
+	 * policy->freq_table may be sorted differently, get the index value we
+	 * are concerned about.
+	 */
+	index = policy->freq_table[index].driver_data;
+
 	return maple_scom_switch_freq(index);
 }
 
-- 
2.7.1.410.g6faf27b

