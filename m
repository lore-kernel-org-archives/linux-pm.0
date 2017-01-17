From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/3] cpuidle/menu: add per cpu pm_qos_resume_latency
 consideration
Date: Tue, 17 Jan 2017 10:38:37 +0100
Message-ID: <20170117093837.GA2085@mai>
References: <1484227624-6740-1-git-send-email-alex.shi@linaro.org>
 <1484227624-6740-4-git-send-email-alex.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484227624-6740-4-git-send-email-alex.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 12, 2017 at 09:27:04PM +0800, Alex Shi wrote:
> Kernel or user may have special requirement on cpu response time, like
> if a interrupt is pinned to a cpu, we don't want the cpu goes too deep
> sleep. This patch can prevent this thing happen by consider per cpu
> resume_latency setting in cpu sleep state selection in menu governor.
> 
> The pm_qos_resume_latency ask device to give reponse in this time. That's
> similar with cpu cstates' entry_latency + exit_latency. But since
> most of cpu cstate either has no entry_latency or add it into exit_latency
> So, we just can restrict this time requirement as states exit_latency.
> 
> We can set a wanted latency value according to the value of
> /sys/devices/system/cpu/cpuX/cpuidle/stateX/latency. to just a bit
> less than related state's latency value. Then cpu can get to this state
> or higher.
> 
> Signed-off-by: Alex Shi <alex.shi@linaro.org>
> To: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/menu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 07e36bb..8d6d25c 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -19,6 +19,7 @@
>  #include <linux/tick.h>
>  #include <linux/sched.h>
>  #include <linux/math64.h>
> +#include <linux/cpu.h>
>  
>  /*
>   * Please note when changing the tuning values:
> @@ -280,17 +281,23 @@ static unsigned int get_typical_interval(struct menu_device *data)
>  static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  {
>  	struct menu_device *data = this_cpu_ptr(&menu_devices);
> +	struct device *device = get_cpu_device(dev->cpu);
>  	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
>  	int i;
>  	unsigned int interactivity_req;
>  	unsigned int expected_interval;
>  	unsigned long nr_iowaiters, cpu_load;
> +	int resume_latency = dev_pm_qos_read_value(device);
>  
>  	if (data->needs_update) {
>  		menu_update(drv, dev);
>  		data->needs_update = 0;
>  	}
>  
> +	/* resume_latency is 0 means no restriction */
> +	if (resume_latency && resume_latency < latency_req)
> +		latency_req = resume_latency;
> +

Calling dev_pm_qos_read_value() after checking latency_req is different from
zero would make more sense. If a zero latency is expected, no need to add an
overhead as we will return zero in all the cases.

	if (unlikely(latency_req == 0))
		return 0;

	device = get_cpu_device(dev->cpu);

	resume_latency = dev_pm_qos_read_value(device);
	if (resume_latency)
		latency_req = min(latency_req, resume_latency);

That said, I have the feeling that is taking the wrong direction. Each time we
are entering idle, we check the latencies. Entering idle can be done thousand
of times per second. Wouldn't make sense to disable the states not fulfilling
the constraints at the moment the latencies are changed ? As the idle states
have increasing exit latencies, setting an idle state limit to disable all
states after that limit may be more efficient than checking again and again in
the idle path, no ?

For example, a zero PM_QOS_CPU_DMA_LATENCY latency should prevent to enter the
select's idle routine.

>  	/* Special case when user has set very strict latency requirement */
>  	if (unlikely(latency_req == 0))
>  		return 0;
> -- 
> 2.8.1.101.g72d917a
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
