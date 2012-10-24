From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/2] cpufreq: Fix sparse warning by making local function static
Date: Wed, 24 Oct 2012 13:15:59 +0530
Message-ID: <40307880d764946d63459958d4b40c2f5bc4d6a0.1351064553.git.viresh.kumar@linaro.org>
References: <93ed702aba4c33d9a477c7296c59cc2882e16f82.1351064553.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:60366 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934451Ab2JXHqO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Oct 2012 03:46:14 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so134030dak.19
        for <linux-pm@vger.kernel.org>; Wed, 24 Oct 2012 00:46:14 -0700 (PDT)
In-Reply-To: <93ed702aba4c33d9a477c7296c59cc2882e16f82.1351064553.git.viresh.kumar@linaro.org>
In-Reply-To: <93ed702aba4c33d9a477c7296c59cc2882e16f82.1351064553.git.viresh.kumar@linaro.org>
References: <93ed702aba4c33d9a477c7296c59cc2882e16f82.1351064553.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, pdsw-power-team@arm.com, arvind.chauhan@arm.com, fengguang.wu@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_disabled() is a local function, so should be marked static.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f552d5f..261ef65 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -129,7 +129,7 @@ static int __init init_cpufreq_transition_notifier_list(void)
 pure_initcall(init_cpufreq_transition_notifier_list);
 
 static int off __read_mostly;
-int cpufreq_disabled(void)
+static int cpufreq_disabled(void)
 {
 	return off;
 }
-- 
1.7.12.rc2.18.g61b472e

