From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 12/16] cpuidle: coupled: Convert to hotplug state machine
Date: Tue, 23 Aug 2016 16:24:52 +0200
Message-ID: <57BC5CB4.409@linaro.org>
References: <20160818125731.27256-1-bigeasy@linutronix.de>
 <20160818125731.27256-13-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36951 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757968AbcHWOY5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2016 10:24:57 -0400
Received: by mail-wm0-f47.google.com with SMTP id i5so198587097wmg.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2016 07:24:56 -0700 (PDT)
In-Reply-To: <20160818125731.27256-13-bigeasy@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 08/18/2016 02:57 PM, Sebastian Andrzej Siewior wrote:
> Install the callbacks via the state machine.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

[ ... ]

> -
>  	mutex_lock(&cpuidle_lock);
>  
>  	dev = per_cpu(cpuidle_devices, cpu);
>  	if (!dev || !dev->coupled)
>  		goto out;
>  
> -	switch (action & ~CPU_TASKS_FROZEN) {
> -	case CPU_UP_PREPARE:
> -	case CPU_DOWN_PREPARE:
> -		cpuidle_coupled_prevent_idle(dev->coupled);
> -		break;
> -	case CPU_ONLINE:
> -	case CPU_DEAD:
> -		cpuidle_coupled_update_online_cpus(dev->coupled);
> -		/* Fall through */
> -	case CPU_UP_CANCELED:
> -	case CPU_DOWN_FAILED:
> -		cpuidle_coupled_allow_idle(dev->coupled);
> -		break;
> -	}
> -
> +	cpuidle_coupled_update_online_cpus(dev->coupled);
> +	cpuidle_coupled_allow_idle(dev->coupled);
>  out:
>  	mutex_unlock(&cpuidle_lock);
> -	return NOTIFY_OK;
> +	return 0;

You can remove the useless label 'out':

if (dev && dev->coupled) {
	cpuidle_coupled_update_online_cpus(dev->coupled);
	cpuidle_coupled_allow_idle(dev->coupled);
}

>  }
>  
> -static struct notifier_block cpuidle_coupled_cpu_notifier = {
> -	.notifier_call = cpuidle_coupled_cpu_notify,
> -};
> +static int coupled_cpu_up_prepare(unsigned int cpu)
> +{
> +	struct cpuidle_device *dev;
> +
> +	mutex_lock(&cpuidle_lock);
> +
> +	dev = per_cpu(cpuidle_devices, cpu);
> +	if (!dev || !dev->coupled)
> +		goto out;
> +
> +	cpuidle_coupled_prevent_idle(dev->coupled);
> +out:
> +	mutex_unlock(&cpuidle_lock);
> +	return 0;

Same comment here.

> +}
>  
>  static int __init cpuidle_coupled_init(void)
>  {
> -	return register_cpu_notifier(&cpuidle_coupled_cpu_notifier);
> +	int ret;
> +
> +	ret = cpuhp_setup_state_nocalls(CPUHP_CPUIDLE_COUPLED_PREPARE,
> +					"CPUIDLE_COUPLED_PREPARE",
> +					coupled_cpu_up_prepare,
> +					coupled_cpu_online);
> +	if (ret)
> +		goto err;

There is nothing to undo here.

	if (ret)
		return ret;

> +	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +					"CPUIDLE_COUPLED_ONLINE",
> +					coupled_cpu_online,
> +					coupled_cpu_up_prepare);
> +	if (ret < 0)
> +		goto err;

	if (ret)
		cpuhp_remove_state_nocalls(
			CPUHP_CPUIDLE_COUPLED_PREPARE);
		
	return ret;

> +	return 0;
> +err:
> +	cpuhp_remove_state_nocalls(CPUHP_CPUIDLE_COUPLED_PREPARE);
> +	return ret;

  ^^^^^ zaaap !



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

