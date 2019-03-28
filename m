From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Date: Thu, 28 Mar 2019 21:23:35 +0100
Message-ID: <30926b3d-0074-8c84-a081-d3dbc9258525@linaro.org>
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-4-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328101352.25657-4-quentin.perret@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>, edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org, viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com
Cc: dietmar.eggemann@arm.com, ionela.voinescu@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 28/03/2019 11:13, Quentin Perret wrote:
> The newly introduced Energy Model framework manages power cost tables in
> a generic way. Moreover, it supports a several types of models since the
> tables can come from DT or firmware (through SCMI) for example. On the
> other hand, the cpu_cooling subsystem manages its own power cost tables
> using only DT data.
> 
> In order to avoid the duplication of data in the kernel, and in order to
> enable IPA with EMs coming from more than just DT, remove the private
> tables from cpu_cooling.c and migrate it to using the centralized EM
> framework.
> 
> The case where the thermal subsystem is used without an Energy Model
> (cpufreq_cooling_ops) is handled by looking directly at CPUFreq's
> frequency table which is already a dependency for cpu_cooling.c anyway.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/thermal/cpu_cooling.c | 231 +++++++++++-----------------------
>  1 file changed, 75 insertions(+), 156 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index f7c1f49ec87f..a74ec8269b7b 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -31,6 +31,7 @@
>  #include <linux/slab.h>
>  #include <linux/cpu.h>
>  #include <linux/cpu_cooling.h>
> +#include <linux/energy_model.h>
>  
>  #include <trace/events/thermal.h>
>  
> @@ -48,19 +49,6 @@
>   *	...
>   */
>  
> -/**
> - * struct freq_table - frequency table along with power entries
> - * @frequency:	frequency in KHz
> - * @power:	power in mW
> - *
> - * This structure is built when the cooling device registers and helps
> - * in translating frequency to power and vice versa.
> - */
> -struct freq_table {
> -	u32 frequency;
> -	u32 power;
> -};
> -
>  /**
>   * struct time_in_idle - Idle time stats
>   * @time: previous reading of the absolute time that this cpu was idle
> @@ -82,7 +70,7 @@ struct time_in_idle {
>   *	frequency.
>   * @max_level: maximum cooling level. One less than total number of valid
>   *	cpufreq frequencies.
> - * @freq_table: Freq table in descending order of frequencies
> + * @em: Reference on the Energy Model of the device
>   * @cdev: thermal_cooling_device pointer to keep track of the
>   *	registered cooling device.
>   * @policy: cpufreq policy.
> @@ -98,7 +86,7 @@ struct cpufreq_cooling_device {
>  	unsigned int cpufreq_state;
>  	unsigned int clipped_freq;
>  	unsigned int max_level;
> -	struct freq_table *freq_table;	/* In descending order */
> +	struct em_perf_domain *em;

Why do you need to add this field? it will be accessible via policy->em, no?

>  	struct thermal_cooling_device *cdev;
>  	struct cpufreq_policy *policy;
>  	struct list_head node;
> @@ -121,14 +109,14 @@ static LIST_HEAD(cpufreq_cdev_list);
>  static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
[ ... ]

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
