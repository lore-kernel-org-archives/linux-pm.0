From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: governor: Always schedule work on the CPU
 running update
Date: Tue, 22 Mar 2016 08:21:12 +0530
Message-ID: <20160322025112.GQ27778@vireshk-i7>
References: <3454445.v5QdUCRORG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33700 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238AbcCVCvP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 22:51:15 -0400
Received: by mail-pf0-f176.google.com with SMTP id 4so158323579pfd.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2016 19:51:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3454445.v5QdUCRORG@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 22-03-16, 01:17, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify dbs_irq_work() to always schedule the process-context work
> on the current CPU which also ran the dbs_update_util_handler()
> that the irq_work being handled came from.
> 
> This causes the entire frequency update handling (involving the
> "ondemand" or "conservative" governors) to be carried out by the
> CPU whose frequency is to be updated and reduces the overall amount
> of inter-CPU noise related to cpufreq.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
> @@ -245,7 +245,7 @@ static void dbs_irq_work(struct irq_work
>  	struct policy_dbs_info *policy_dbs;
>  
>  	policy_dbs = container_of(irq_work, struct policy_dbs_info, irq_work);
> -	schedule_work(&policy_dbs->work);
> +	schedule_work_on(smp_processor_id(), &policy_dbs->work);
>  }
>  
>  static void dbs_update_util_handler(struct update_util_data *data, u64 time,

queue_work() used to queue the work on local cpu by default, has that
changed now ?

-- 
viresh
