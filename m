From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND 04/11] cpufreq: Remove extra blank line
Date: Thu, 03 Oct 2013 12:56:39 +0530
Message-ID: <524D1C2F.6060600@linux.vnet.ibm.com>
References: <cover.1380703248.git.viresh.kumar@linaro.org> <f70f2486e3107448d1d3b835b78ad20724fdd252.1380703248.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:41026 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab3JCHau (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 03:30:50 -0400
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 3 Oct 2013 13:00:47 +0530
In-Reply-To: <f70f2486e3107448d1d3b835b78ad20724fdd252.1380703248.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 10/02/2013 02:13 PM, Viresh Kumar wrote:
> We don't need a blank line just at start of a block, lets remove it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

> ---
>  drivers/cpufreq/cpufreq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d80cbe6..d149caa 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1155,7 +1155,6 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
>  		if (!frozen)
>  			sysfs_remove_link(&dev->kobj, "cpufreq");
>  	} else if (cpus > 1) {
> -
>  		new_cpu = cpufreq_nominate_new_policy_cpu(policy, cpu, frozen);
>  		if (new_cpu >= 0) {
>  			update_policy_cpu(policy, new_cpu);
> 

