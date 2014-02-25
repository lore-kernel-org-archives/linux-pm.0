From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] cpufreq: Return error if ->get() failed in cpufreq_update_policy()
Date: Tue, 25 Feb 2014 14:29:44 +0530
Message-ID: <79539d6c5c04165da855863c4015f90b278d86d1.1393318725.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:62001 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbaBYI7v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2014 03:59:51 -0500
Received: by mail-wi0-f172.google.com with SMTP id e4so4104106wiv.11
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2014 00:59:50 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_update_policy() calls cpufreq_driver->get() to get current frequency of
a CPU and it is not supposed to fail or return zero. Return error in case that
happens.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- Fixed return error to EIO instead of EINVAL
- Added WARN_ON() to flag get() failing and hence removed the print message as
  well which was earlier printed during errors.
 drivers/cpufreq/cpufreq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c755b5f..bf80502 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2139,6 +2139,11 @@ int cpufreq_update_policy(unsigned int cpu)
 	 */
 	if (cpufreq_driver->get) {
 		new_policy.cur = cpufreq_driver->get(cpu);
+		if (WARN_ON(!new_policy.cur)) {
+			ret = -EIO;
+			goto no_policy;
+		}
+
 		if (!policy->cur) {
 			pr_debug("Driver did not initialize current freq");
 			policy->cur = new_policy.cur;
-- 
1.7.12.rc2.18.g61b472e

