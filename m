From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/11] cpufreq: elanfreq: Use 'index' only to index into policy->freq_table
Date: Thu,  2 Jun 2016 19:49:05 +0530
Message-ID: <9f63bf6fdb8b90b64e5423803f3b38b29a11646b.1464876460.git.viresh.kumar@linaro.org>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35011 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161131AbcFBOTh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 10:19:37 -0400
Received: by mail-pf0-f170.google.com with SMTP id g64so31984823pfb.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2016 07:19:36 -0700 (PDT)
In-Reply-To: <cover.1464876460.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464876460.git.viresh.kumar@linaro.org>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Shawn Guo <shawn.guo@freescale.com>, Steven Miao <realmz6@gmail.com>

Later patches would make changes in cpufreq core, after which
policy->freq_table may be reordered by cpufreq core and it wouldn't be
safe anymore to use 'index' for any other local arrays.

To prepare for that, use policy->freq_table[index].driver_data for other
driver specific usage of 'index'. The 'driver_data' fields are already
set properly by the driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/elanfreq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index bfce11cba1df..bd4a51091986 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -108,9 +108,15 @@ static unsigned int elanfreq_get_cpu_frequency(unsigned int cpu)
 
 
 static int elanfreq_target(struct cpufreq_policy *policy,
-			    unsigned int state)
+			    unsigned int index)
 {
 	/*
+	 * policy->freq_table may be sorted differently, get the index value we
+	 * are concerned about.
+	 */
+	unsigned int state = policy->freq_table[index].driver_data;
+
+	/*
 	 * Access to the Elan's internal registers is indexed via
 	 * 0x22: Chip Setup & Control Register Index Register (CSCI)
 	 * 0x23: Chip Setup & Control Register Data  Register (CSCD)
-- 
2.7.1.410.g6faf27b

