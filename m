From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 07/14] cpufreq: Don't allow updating inactive policies from sysfs
Date: Mon, 18 May 2015 10:43:30 +0530
Message-ID: <427de81ba345cbaba7e36435e825a4234f0f9514.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36787 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbbERFOR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 01:14:17 -0400
Received: by pdfh10 with SMTP id h10so133408958pdf.3
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2015 22:14:17 -0700 (PDT)
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

Later commits would change the way policies are managed today. Policies
wouldn't be freed on cpu hotplug (currently they aren't freed only for
suspend), and while the CPU is offline, the sysfs cpufreq files would
still be present.

User may accidentally try to update the sysfs files in following
directory: '/sys/devices/system/cpu/cpuX/cpufreq/'. And that would
result in undefined behavior as policy wouldn't be active then.

Apart from updating the store() routine, we also update __cpufreq_get()
which can call cpufreq_out_of_sync(). The later routine tries to update
policy->cur and starts notifying kernel about it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c08de5e985c7..983961ba2f72 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -875,11 +875,18 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 
 	down_write(&policy->rwsem);
 
+	/* Updating inactive policies is invalid, so avoid doing that. */
+	if (unlikely(policy_is_inactive(policy))) {
+		ret = -EPERM;
+		goto unlock_policy_rwsem;
+	}
+
 	if (fattr->store)
 		ret = fattr->store(policy, buf, count);
 	else
 		ret = -EIO;
 
+unlock_policy_rwsem:
 	up_write(&policy->rwsem);
 
 	up_read(&cpufreq_rwsem);
@@ -1607,6 +1614,10 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
 
 	ret_freq = cpufreq_driver->get(policy->cpu);
 
+	/* Updating inactive policies is invalid, so avoid doing that. */
+	if (unlikely(policy_is_inactive(policy)))
+		return ret_freq;
+
 	if (ret_freq && policy->cur &&
 		!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
 		/* verify no discrepancy between actual and
-- 
2.4.0

