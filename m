From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: governor: split cpufreq_governor_dbs()
Date: Thu, 4 Jun 2015 15:47:06 +0530
Message-ID: <20150604101706.GB743@linux>
References: <cover.1433326032.git.viresh.kumar@linaro.org>
 <6880bd7b6e6e7968f008d6328ab15353d99ccd57.1433326032.git.viresh.kumar@linaro.org>
 <5570229F.3080808@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36267 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbbFDKRM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 06:17:12 -0400
Received: by pabqy3 with SMTP id qy3so26674444pab.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2015 03:17:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5570229F.3080808@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 04-06-15, 15:34, Preeti U Murthy wrote:
> > +	if (dbs_data) {
> > +		WARN_ON(have_governor_per_policy());
> 
> Shouldn't this be outside this loop ? We warn here and allocate dbs_dta

Loop ? Its just an 'if' block :)

> freshly in the current code for the case where governor is per policy.

So what we are doing in the current code is equally disgusting. We
already have a pointer and we overwrite it.

> 
> > +		dbs_data->usage_count++;
> 
> Besides, in the case where a governor exists per policy, we will end up
> incrementing the usage_count to more than 1 under this condition, which
> does not make sense.

So, the only sane option here is to return an error immediately I
think.

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index ed849a8777dd..57a39f8a92b7 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -247,7 +247,8 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
 	int ret;
 
 	if (dbs_data) {
-		WARN_ON(have_governor_per_policy());
+		if (WARN_ON(have_governor_per_policy()))
+			return -EINVAL;
 		dbs_data->usage_count++;
 		policy->governor_data = dbs_data;
 		return 0;
@@ -276,24 +277,28 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
 					latency * LATENCY_MULTIPLIER));
 
 	if (!have_governor_per_policy()) {
-		WARN_ON(cpufreq_get_global_kobject());
+		if (WARN_ON(cpufreq_get_global_kobject())) {
+			ret = -EINVAL;
+			goto cdata_exit;
+		}
 		cdata->gdbs_data = dbs_data;
 	}
 
 	ret = sysfs_create_group(get_governor_parent_kobj(policy),
 				 get_sysfs_attr(dbs_data));
 	if (ret)
-		goto cdata_exit;
+		goto put_kobj;
 
 	policy->governor_data = dbs_data;
 
 	return 0;
 
-cdata_exit:
+put_kobj:
 	if (!have_governor_per_policy()) {
 		cdata->gdbs_data = NULL;
 		cpufreq_put_global_kobject();
 	}
+cdata_exit:
 	cdata->exit(dbs_data, !policy->governor->initialized);
 free_dbs_data:
 	kfree(dbs_data);

-- 
viresh
