From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] cpuidle: Add "cpuidle.use_deepest" to bypass governor and
 allow HW to go deep
Date: Thu, 9 Nov 2017 08:51:04 +0100
Message-ID: <CAKfTPtDkdom+YQieLQ=H8cG0_34g2dADYbDz7-i2iVY4JyOvsQ@mail.gmail.com>
References: <1d81edef71c936099f8bb9d16162f8e70fbe401c.1510212816.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1d81edef71c936099f8bb9d16162f8e70fbe401c.1510212816.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: thomas.ilsche@tu-dresden.de, dsmythies@telus.net, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, jacob.jun.pan@linux.intel.com, linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Len

On 9 November 2017 at 08:38, Len Brown <lenb@kernel.org> wrote:
> From: Len Brown <len.brown@intel.com>
>
> While there are several mechanisms (cmdline, sysfs, PM_QOS) to limit
> cpuidle to shallow idle states, there is no simple mechanism
> to give the hardware permission to enter the deeptest state permitted by PM_QOS.

and by per device resume latency QoS

>
> Here we create the "cpuidle.use_deepest" modparam to provide this capability.
>
> "cpuidle.use_deepest=Y" can be set at boot-time, and
> /sys/module/cpuidle/use_deepest can be modified (with Y/N) at run-time.
>
> n.b.
>
> Within the constraints of PM_QOS, this mechanism gives the hardware
> permission to choose the deeptest power savings and highest latency
> state available.  And so choice will depend on the particular hardware.
>
> Also, if PM_QOS is not informed of latency constraints, it can't help.
> In that case, using this mechanism may result in entering high-latency
> states that impact performance.
>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>  drivers/cpuidle/cpuidle.c                       | 19 ++++++++++++++++
>  include/linux/cpuidle.h                         |  7 ++++++
>  kernel/sched/idle.c                             | 30 +++++++++++++++++++------
>  4 files changed, 53 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 05496622b4ef..20f70de688bf 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -659,6 +659,10 @@
>         cpuidle.off=1   [CPU_IDLE]
>                         disable the cpuidle sub-system
>
> +       cpuidle.use_deepest=Y   [CPU_IDLE]
> +                       Ignore cpuidle governor, always choose deepest
> +                       PM_QOS-legal CPU idle power saving state.
> +
>         cpufreq.off=1   [CPU_FREQ]
>                         disable the cpufreq sub-system
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 484cc8909d5c..afee5aab7719 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -34,6 +34,7 @@ LIST_HEAD(cpuidle_detected_devices);
>
>  static int enabled_devices;
>  static int off __read_mostly;
> +static bool use_deepest __read_mostly;
>  static int initialized __read_mostly;
>
>  int cpuidle_disabled(void)
> @@ -116,6 +117,10 @@ void cpuidle_use_deepest_state(bool enable)
>         preempt_enable();
>  }
>
> +bool cpuidle_using_deepest_state(void)
> +{
> +       return use_deepest;
> +}
>  /**
>   * cpuidle_find_deepest_state - Find the deepest available idle state.
>   * @drv: cpuidle driver for the given CPU.
> @@ -127,6 +132,19 @@ int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>         return find_deepest_state(drv, dev, UINT_MAX, 0, false);
>  }
>
> +/**
> + * cpuidle_find_deepest_state_qos - Find the deepest available idle state.
> + * @drv: cpuidle driver for the given CPU.
> + * @dev: cpuidle device for the given CPU.
> + * Honors PM_QOS
> + */
> +int cpuidle_find_deepest_state_qos(struct cpuidle_driver *drv,
> +                              struct cpuidle_device *dev)
> +{
> +       return find_deepest_state(drv, dev,
> +                       pm_qos_request(PM_QOS_CPU_DMA_LATENCY), 0, false);

You should also take into account per device latency  like in menu governor:
dev_pm_qos_raw_read_value(device);


> +}
> +
>  #ifdef CONFIG_SUSPEND
>  static void enter_s2idle_proper(struct cpuidle_driver *drv,
>                                 struct cpuidle_device *dev, int index)
> @@ -681,4 +699,5 @@ static int __init cpuidle_init(void)
>  }
>
>  module_param(off, int, 0444);
> +module_param(use_deepest, bool, 0644);
>  core_initcall(cpuidle_init);
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 8f7788d23b57..e3c2c9d1898f 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -198,19 +198,26 @@ static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
>  #ifdef CONFIG_CPU_IDLE
>  extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>                                       struct cpuidle_device *dev);
> +extern int cpuidle_find_deepest_state_qos(struct cpuidle_driver *drv,
> +                                     struct cpuidle_device *dev);
>  extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
>                                 struct cpuidle_device *dev);
>  extern void cpuidle_use_deepest_state(bool enable);
> +extern bool cpuidle_using_deepest_state(void);
>  #else
>  static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>                                              struct cpuidle_device *dev)
>  {return -ENODEV; }
> +static inline int cpuidle_find_deepest_state_qos(struct cpuidle_driver *drv,
> +                                            struct cpuidle_device *dev)
> +{return -ENODEV; }
>  static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
>                                        struct cpuidle_device *dev)
>  {return -ENODEV; }
>  static inline void cpuidle_use_deepest_state(bool enable)
>  {
>  }
> +static inline bool cpuidle_using_deepest_state(void) {return false; }
>  #endif
>
>  /* kernel/sched/idle.c */
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 257f4f0b4532..6c7348ae28ec 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -167,17 +167,33 @@ static void cpuidle_idle_call(void)
>          * until a proper wakeup interrupt happens.
>          */
>
> -       if (idle_should_enter_s2idle() || dev->use_deepest_state) {
> -               if (idle_should_enter_s2idle()) {
> -                       entered_state = cpuidle_enter_s2idle(drv, dev);
> -                       if (entered_state > 0) {
> -                               local_irq_enable();
> -                               goto exit_idle;
> -                       }
> +       if (idle_should_enter_s2idle()) {
> +               entered_state = cpuidle_enter_s2idle(drv, dev);
> +               if (entered_state > 0) {
> +                       local_irq_enable();
> +                       goto exit_idle;
>                 }
> +       }
>
> +       /*
> +        * cpuidle_dev->user_deepest_state is per-device, and thus per-CPU.
> +        * it is used to force power-savings, and thus does not obey PM_QOS.
> +        */
> +
> +       if (dev->use_deepest_state) {
>                 next_state = cpuidle_find_deepest_state(drv, dev);
>                 call_cpuidle(drv, dev, next_state);
> +       }
> +
> +       /*
> +        * cpuidle_using_deepest_state() is system-wide, applying to all CPUs.
> +        * When activated, Linux gives the hardware permission to go as deep
> +        * as PM_QOS allows.
> +        */
> +
> +       else if (cpuidle_using_deepest_state()) {
> +               next_state = cpuidle_find_deepest_state_qos(drv, dev);
> +               call_cpuidle(drv, dev, next_state);
>         } else {
>                 /*
>                  * Ask the cpuidle framework to choose a convenient idle state.
> --
> 2.14.0-rc0
>
