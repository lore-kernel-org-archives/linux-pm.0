From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] fix cpufreq/cpufreq.c some coding style issues
Date: Mon, 24 Aug 2015 09:54:58 +0530
Message-ID: <20150824042458.GB5375@linux>
References: <1440344359-7051-1-git-send-email-falakreyaz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36267 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbbHXEZD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2015 00:25:03 -0400
Received: by padfo6 with SMTP id fo6so7450448pad.3
        for <linux-pm@vger.kernel.org>; Sun, 23 Aug 2015 21:25:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1440344359-7051-1-git-send-email-falakreyaz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Muhammad Falak R Wani <falakreyaz@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 23-08-15, 21:09, Muhammad Falak R Wani wrote:
> Hi,
> 
> 	This patch fixes issues in coding style, of a missing blank line after
> declarations.
> 
> Best,
> mfrw

This is as ugly as it could be. Please go through
Documentation/SubmittingPatches and other related stuff to see you to
send patches.

> Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 8ae655c..5aea659 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -718,6 +718,7 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
>  {
>  	unsigned int limit;
>  	int ret;
> +
>  	if (cpufreq_driver->bios_limit) {
>  		ret = cpufreq_driver->bios_limit(policy->cpu, &limit);
>  		if (!ret)
> @@ -815,6 +816,7 @@ unlock:
>  static void cpufreq_sysfs_release(struct kobject *kobj)
>  {
>  	struct cpufreq_policy *policy = to_policy(kobj);
> +
>  	pr_debug("last reference is dropped\n");
>  	complete(&policy->kobj_unregister);
>  }
> @@ -2129,6 +2131,7 @@ EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);
>  int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
>  {
>  	struct cpufreq_policy *cpu_policy;
> +
>  	if (!policy)
>  		return -EINVAL;

And then these changes are all trivial and not at all important. We
don't want a patch for that even if checkpatch complains.

-- 
viresh
