From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: Avoid double kobject_put() for the same kobject
 in error code path
Date: Fri, 02 Aug 2013 12:24:01 +0530
Message-ID: <51FB5789.6030401@linux.vnet.ibm.com>
References: <2204970.DYsqYi7YjZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:35342 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab3HBG5m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Aug 2013 02:57:42 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 2 Aug 2013 12:22:13 +0530
In-Reply-To: <2204970.DYsqYi7YjZ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, cpufreq@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

On 08/02/2013 03:01 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The only case triggering a jump to the err_out_unregister label in
> __cpufreq_add_dev() is when cpufreq_add_dev_interface() fails.
> However, if cpufreq_add_dev_interface() fails, it calls kobject_put()
> for the policy kobject in its error code path and since that causes
> the kobject's refcount to become 0, the additional kobject_put() for
> the same kobject under err_out_unregister and the
> wait_for_completion() following it are pointless, so drop them.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

> ---
>  drivers/cpufreq/cpufreq.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1109,9 +1109,6 @@ err_out_unregister:
>  	}
>  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> 
> -	kobject_put(&policy->kobj);
> -	wait_for_completion(&policy->kobj_unregister);
> -
>  err_set_policy_cpu:
>  	per_cpu(cpufreq_policy_cpu, cpu) = -1;
>  	cpufreq_policy_free(policy);
> 

