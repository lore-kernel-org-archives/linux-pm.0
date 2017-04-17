From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [patch 06/20] cpufreq: Use cpuhp_setup_state_nocalls_locked()
Date: Mon, 17 Apr 2017 09:44:38 +0530
Message-ID: <20170417041438.GD28191@vireshk-i7>
References: <20170415170107.643253702@linutronix.de>
 <20170415171651.746595672@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36534 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdDQEOm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 00:14:42 -0400
Received: by mail-pf0-f172.google.com with SMTP id 194so21255196pfv.3
        for <linux-pm@vger.kernel.org>; Sun, 16 Apr 2017 21:14:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170415171651.746595672@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Siewior <bigeasy@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 15-04-17, 19:01, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> cpufreq holds get_online_cpus() while invoking cpuhp_setup_state_nocalls()
> to make subsys_interface_register() and the registration of hotplug calls
> atomic versus cpu hotplug.
> 
> cpuhp_setup_state_nocalls() invokes get_online_cpus() as well. This is
> correct, but prevents the conversion of the hotplug locking to a percpu
> rwsem.
> 
> Use cpuhp_setup_state_nocalls_locked() to avoid the nested call.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> 
> ---
>  drivers/cpufreq/cpufreq.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2473,9 +2473,10 @@ int cpufreq_register_driver(struct cpufr
>  		goto err_if_unreg;
>  	}
>  
> -	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "cpufreq:online",
> -					cpuhp_cpufreq_online,
> -					cpuhp_cpufreq_offline);
> +	ret = cpuhp_setup_state_nocalls_locked(CPUHP_AP_ONLINE_DYN,
> +					       "cpufreq:online",
> +					       cpuhp_cpufreq_online,
> +					       cpuhp_cpufreq_offline);
>  	if (ret < 0)
>  		goto err_if_unreg;
>  	hp_online = ret;
> @@ -2519,7 +2520,7 @@ int cpufreq_unregister_driver(struct cpu
>  	get_online_cpus();
>  	subsys_interface_unregister(&cpufreq_interface);
>  	remove_boost_sysfs_file();
> -	cpuhp_remove_state_nocalls(hp_online);
> +	cpuhp_remove_state_nocalls_locked(hp_online);
>  
>  	write_lock_irqsave(&cpufreq_driver_lock, flags);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
