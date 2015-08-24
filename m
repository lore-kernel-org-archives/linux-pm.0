From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RESEND PATCH] cpufreq: cpufreq: Fix coding style issues
Date: Mon, 24 Aug 2015 09:55:51 +0530
Message-ID: <20150824042551.GC5375@linux>
References: <1440348235-7789-1-git-send-email-falakreyaz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35146 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbbHXEZz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2015 00:25:55 -0400
Received: by pdob1 with SMTP id b1so48449426pdo.2
        for <linux-pm@vger.kernel.org>; Sun, 23 Aug 2015 21:25:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1440348235-7789-1-git-send-email-falakreyaz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Muhammad Falak R Wani <falakreyaz@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 23-08-15, 22:13, Muhammad Falak R Wani wrote:
> This patch introduces a blank line after declarations, which
> fix the checkpatch.pl warnings at 3 places.
> 
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

We don't really need a patch for this, unless Rafael wants to apply
this one :)

-- 
viresh
