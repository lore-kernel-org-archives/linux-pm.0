From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH 4/4] cpuidle/menu: add per cpu pm_qos_resume_latency
 consideration
Date: Wed, 31 Aug 2016 18:46:10 +0800
Message-ID: <57C6B572.80106@linaro.org>
References: <1472114562-2736-1-git-send-email-alex.shi@linaro.org>
 <1472114562-2736-4-git-send-email-alex.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472114562-2736-4-git-send-email-alex.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: open list <linux-kernel@vger.kernel.org>
Cc: linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

Is there any concern on this patch?

Regards
Alex


On 08/25/2016 04:42 PM, Alex Shi wrote:
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
> The 0 value of pm_qos_resume_latency is for no limitation according ABI
> definition. So set the value 1 could get the 0 latency if it's needed.
> 
> Signed-off-by: Alex Shi <alex.shi@linaro.org>
> To: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Alex Shi <alex.shi@linaro.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/menu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index bb58e2a..e354880 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/cpuidle.h>
> +#include <linux/cpu.h>
>  #include <linux/pm_qos.h>
>  #include <linux/time.h>
>  #include <linux/ktime.h>
> @@ -281,17 +282,23 @@ again:
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
>  	/* Special case when user has set very strict latency requirement */
>  	if (unlikely(latency_req == 0))
>  		return 0;
> 
