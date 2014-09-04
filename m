From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/3] smp: Adding new function wake_up_all_idle_cpus()
Date: Thu, 04 Sep 2014 14:56:17 +0200
Message-ID: <54086171.20107@linaro.org>
References: <1409815075-4180-1-git-send-email-chuansheng.liu@intel.com> <1409815075-4180-2-git-send-email-chuansheng.liu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409815075-4180-2-git-send-email-chuansheng.liu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuansheng Liu <chuansheng.liu@intel.com>, peterz@infradead.org, luto@amacapital.net, rjw@rjwysocki.net, mingo@redhat.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, changcheng.liu@intel.com, xiaoming.wang@intel.com, souvik.k.chakravarty@intel.com
List-Id: linux-pm@vger.kernel.org

On 09/04/2014 09:17 AM, Chuansheng Liu wrote:
> Currently kick_all_cpus_sync() can break non-polling idle cpus
> thru IPI interrupts.
>
> But sometimes we need to break the polling idle cpus immediately
> to reselect the suitable c-state, also for non-idle cpus, we need
> to do nothing if we try to wake up them.
>
> Here adding one new function wake_up_all_idle_cpus() to let all cpus
> out of idle based on function wake_up_if_idle().

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> ---
>   include/linux/smp.h |    2 ++
>   kernel/smp.c        |   22 ++++++++++++++++++++++
>   2 files changed, 24 insertions(+)
>
> diff --git a/include/linux/smp.h b/include/linux/smp.h
> index 34347f2..93dff5f 100644
> --- a/include/linux/smp.h
> +++ b/include/linux/smp.h
> @@ -100,6 +100,7 @@ int smp_call_function_any(const struct cpumask *m=
ask,
>   			  smp_call_func_t func, void *info, int wait);
>
>   void kick_all_cpus_sync(void);
> +void wake_up_all_idle_cpus(void);
>
>   /*
>    * Generic and arch helpers
> @@ -148,6 +149,7 @@ smp_call_function_any(const struct cpumask *mask,=
 smp_call_func_t func,
>   }
>
>   static inline void kick_all_cpus_sync(void) {  }
> +static inline void wake_up_all_idle_cpus(void) {  }
>
>   #endif /* !SMP */
>
> diff --git a/kernel/smp.c b/kernel/smp.c
> index aff8aa1..9e0d0b2 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -13,6 +13,7 @@
>   #include <linux/gfp.h>
>   #include <linux/smp.h>
>   #include <linux/cpu.h>
> +#include <linux/sched.h>
>
>   #include "smpboot.h"
>
> @@ -699,3 +700,24 @@ void kick_all_cpus_sync(void)
>   	smp_call_function(do_nothing, NULL, 1);
>   }
>   EXPORT_SYMBOL_GPL(kick_all_cpus_sync);
> +
> +/**
> + * wake_up_all_idle_cpus - break all cpus out of idle
> + * wake_up_all_idle_cpus try to break all cpus which is in idle stat=
e even
> + * including idle polling cpus, for non-idle cpus, we will do nothin=
g
> + * for them.
> + */
> +void wake_up_all_idle_cpus(void)
> +{
> +	int cpu;
> +
> +	preempt_disable();
> +	for_each_online_cpu(cpu) {
> +		if (cpu =3D=3D smp_processor_id())
> +			continue;
> +
> +		wake_up_if_idle(cpu);
> +	}
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL_GPL(wake_up_all_idle_cpus);
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
