From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 10/16] cpuidle: pseries: Convert to hotplug state machine
Date: Mon, 22 Aug 2016 18:09:47 +0200
Message-ID: <57BB23CB.2080908@linaro.org>
References: <20160818125731.27256-1-bigeasy@linutronix.de>
 <20160818125731.27256-11-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160818125731.27256-11-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/18/2016 02:57 PM, Sebastian Andrzej Siewior wrote:
> Install the callbacks via the state machine.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 5811954809af..baecc4faf028 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -19,6 +19,7 @@ enum cpuhp_state {
>  	CPUHP_MM_WRITEBACK_DEAD,
>  	CPUHP_SOFTIRQ_DEAD,
>  	CPUHP_NET_MVNETA_DEAD,
> +	CPUHP_CPUIDLE_PSERIES_DEAD,

Can't we directly merge these into CPUHP_CPUIDLE_DEAD instead ? Or is it
planned to be done separately ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
