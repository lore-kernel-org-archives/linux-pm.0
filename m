From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: create link to policy only for registered CPUs
Date: Fri, 9 Sep 2016 17:04:59 +0530
Message-ID: <20160909113459.GG18547@vireshk-i7>
References: <20160819110032.GM1041@n2100.armlinux.org.uk>
 <a0469c333e08b3953bfe9e8356c6919c26578349.1473414746.git.viresh.kumar@linaro.org>
 <20160909111620.GQ1041@n2100.armlinux.org.uk>
 <20160909112204.GE18547@vireshk-i7>
 <20160909112841.GS1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35340 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbcIILfF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2016 07:35:05 -0400
Received: by mail-pf0-f178.google.com with SMTP id w87so28791300pfk.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Sep 2016 04:35:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160909112841.GS1041@n2100.armlinux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 09-09-16, 12:28, Russell King - ARM Linux wrote:
> On Fri, Sep 09, 2016 at 04:52:04PM +0530, Viresh Kumar wrote:
> > Thanks for testing it.. You need another patch from Rafael, which
> > should be in linux-next by now..
> > 
> > commit 3689ad7ed6a8 ("cpufreq: Drop unnecessary check from
> > cpufreq_policy_alloc()")
> > 
> > Both patches combined will fix the problem you were getting.
> 
> Please send me this other patch.  Seems absurd to fix a reported problem
> without copying appropriate patches to the reporter...

It got merged separately, and yes you should have been cc'd for that
as well.

Please find it attached now..

-- 
viresh

--vkogqOf2sHV7VnPd
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-cpufreq-Drop-unnecessary-check-from-cpufreq_policy_a.patch"

>From 3689ad7ed6a836c4eec5e7bdd17a11a79591bef9 Mon Sep 17 00:00:00 2001
Message-Id: <3689ad7ed6a836c4eec5e7bdd17a11a79591bef9.1473420826.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Wed, 31 Aug 2016 03:11:31 +0200
Subject: [PATCH] cpufreq: Drop unnecessary check from cpufreq_policy_alloc()

Since cpufreq_policy_alloc() doesn't use its dev variable for
anything useful, drop that variable from there along with the
NULL check against it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 3dd4884c6f9e..13fb589b6d2c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1073,13 +1073,9 @@ static void handle_update(struct work_struct *work)
 
 static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 {
-	struct device *dev = get_cpu_device(cpu);
 	struct cpufreq_policy *policy;
 	int ret;
 
-	if (WARN_ON(!dev))
-		return NULL;
-
 	policy = kzalloc(sizeof(*policy), GFP_KERNEL);
 	if (!policy)
 		return NULL;
-- 
2.7.1.410.g6faf27b


--vkogqOf2sHV7VnPd--
