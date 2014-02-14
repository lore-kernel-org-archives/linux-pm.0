From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] cpufreq: Return error if ->get() failed in cpufreq_update_policy()
Date: Fri, 14 Feb 2014 16:30:40 +0530
Message-ID: <15ccc0609cb9ee3db0ad3a95b29bf69d11ea197c.1392375504.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:60941 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbaBNLAw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2014 06:00:52 -0500
Received: by mail-wi0-f179.google.com with SMTP id hn9so336862wib.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2014 03:00:51 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, pierre-list@ossman.eu, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_update_policy() calls cpufreq_driver->get() to get current frequency of
a CPU and it is not supposed to fail or return zero. Return error in case that
happens.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Pierre,

I don't think this will fix the issue you were facing but might supress it :)..
And so you need to understand what causes your ->get() to return zero.

@Rafael: I got to these patches while looking at code recently after Pierre
complained about. Came to this conclusion after having discussions with Srivatsa
over IRC..

 drivers/cpufreq/cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 08ca8c9..383362b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2151,6 +2151,13 @@ int cpufreq_update_policy(unsigned int cpu)
 	 */
 	if (cpufreq_driver->get) {
 		new_policy.cur = cpufreq_driver->get(cpu);
+
+		if (!new_policy.cur) {
+			pr_err("%s: ->get() returned 0 KHz\n", __func__);
+			ret = -EINVAL;
+			goto no_policy;
+		}
+
 		if (!policy->cur) {
 			pr_debug("Driver did not initialize current freq");
 			policy->cur = new_policy.cur;
-- 
1.7.12.rc2.18.g61b472e

