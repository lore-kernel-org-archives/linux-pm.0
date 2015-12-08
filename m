From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH][experimantal] cpufreq: governor: Use an atomic variable
 for synchronization
Date: Tue, 8 Dec 2015 12:29:05 +0530
Message-ID: <20151208065905.GA3294@ubuntu>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
 <3999637.u4UiK7zxOR@vostro.rjw.lan>
 <2389125.q3qMOpRs8O@vostro.rjw.lan>
 <4910771.IIQSzHPqps@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34807 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932460AbbLHG7M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 01:59:12 -0500
Received: by pacwq6 with SMTP id wq6so7382261pac.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2015 22:59:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4910771.IIQSzHPqps@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>

On 08-12-15, 01:39, Rafael J. Wysocki wrote:
> @@ -269,9 +259,6 @@ static void dbs_timer_handler(unsigned l
>  {
>  	struct cpu_dbs_info *cdbs = (struct cpu_dbs_info *)data;
>  	struct cpu_common_dbs_info *shared = cdbs->shared;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&shared->timer_lock, flags);
>  
>  	/*
>  	 * Timer handler isn't allowed to queue work at the moment, because:
> @@ -279,12 +266,10 @@ static void dbs_timer_handler(unsigned l
>  	 * - We are stopping the governor
>  	 * - Or we are updating the sampling rate of ondemand governor
>  	 */
> -	if (!shared->skip_work) {
> -		shared->skip_work++;
> +	if (atomic_inc_return(&shared->skip_work) > 1)
> +		atomic_dec(&shared->skip_work);
> +	else
>  		queue_work(system_wq, &shared->work);
> -	}

As explained in the other email, this is wrong..

-- 
viresh
