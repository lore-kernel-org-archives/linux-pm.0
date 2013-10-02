From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH RESEND 05/11] cpufreq: don't break string in print statements
Date: Wed,  2 Oct 2013 14:13:13 +0530
Message-ID: <0b5dc6e2bb455632b4167b2f2b818649ba7cb4ef.1380703248.git.viresh.kumar@linaro.org>
References: <cover.1380703248.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:52123 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608Ab3JBIoQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2013 04:44:16 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so732451pab.36
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2013 01:44:15 -0700 (PDT)
In-Reply-To: <cover.1380703248.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380703248.git.viresh.kumar@linaro.org>
References: <cover.1380703248.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

As a rule its better not to break string (quoted inside "") in a print statement
even if it crosses 80 column boundary as that may introduce unwanted bugs and so
this patch rewrites one of the print statements..

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d149caa..065b4dd 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1160,8 +1160,8 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 			update_policy_cpu(policy, new_cpu);
 
 			if (!frozen) {
-				pr_debug("%s: policy Kobject moved to cpu: %d "
-					 "from: %d\n",__func__, new_cpu, cpu);
+				pr_debug("%s: policy Kobject moved to cpu: %d from: %d\n",
+						__func__, new_cpu, cpu);
 			}
 		}
 	}
-- 
1.7.12.rc2.18.g61b472e

