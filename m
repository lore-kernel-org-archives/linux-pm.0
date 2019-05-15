From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 2/3] PM / EM: Expose perf domain struct
Date: Wed, 15 May 2019 11:06:18 +0200
Message-ID: <0ced18eb-e424-fe6b-b11e-165a3c108170@linaro.org>
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-3-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515082318.7993-3-quentin.perret@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>, edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org, viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com
Cc: dietmar.eggemann@arm.com, ionela.voinescu@arm.com, mka@chromium.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 15/05/2019 10:23, Quentin Perret wrote:
> In the current state, the perf_domain struct is fully defined only when
> CONFIG_ENERGY_MODEL=y. Since we need to write code that compiles both
> with or without that option in the thermal framework, make sure to
> actually define the struct regardless of the config option. That allows
> to avoid using stubbed accessor functions all the time in code paths
> that use the EM.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>

This patch implies the cpu cooling device can be set without the energy
model.

Isn't it possible to make a strong dependency for the cpu cooling device
on the energy model option, add the energy model as default on arm arch
and drop this patch?

After all, the cpu cooling is using the em framework.

> ---
>  include/linux/energy_model.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index aa027f7bcb3e..fb32b86a467d 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -9,7 +9,6 @@
>  #include <linux/sched/topology.h>
>  #include <linux/types.h>
>  
> -#ifdef CONFIG_ENERGY_MODEL
>  /**
>   * em_cap_state - Capacity state of a performance domain
>   * @frequency:	The CPU frequency in KHz, for consistency with CPUFreq
> @@ -40,6 +39,7 @@ struct em_perf_domain {
>  	unsigned long cpus[0];
>  };
>  
> +#ifdef CONFIG_ENERGY_MODEL
>  #define EM_CPU_MAX_POWER 0xFFFF
>  
>  struct em_data_callback {
> @@ -160,7 +160,6 @@ static inline int em_pd_nr_cap_states(struct em_perf_domain *pd)
>  }
>  
>  #else
> -struct em_perf_domain {};
>  struct em_data_callback {};
>  #define EM_DATA_CB(_active_power_cb) { }
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
