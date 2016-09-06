From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 12/21] cpufreq: Convert to hotplug state machine
Date: Tue, 6 Sep 2016 23:27:46 +0200
Message-ID: <CAJZ5v0i8o4Bnmvpmn+=8snEzfmBPxqcV9iGVSh62Wf0X86j8BA@mail.gmail.com>
References: <20160906170457.32393-1-bigeasy@linutronix.de> <20160906170457.32393-13-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160906170457.32393-13-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 6, 2016 at 7:04 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Install the callbacks via the state machine.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/cpufreq/cpufreq.c | 38 ++++++++++++--------------------------
>  1 file changed, 12 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 3dd4884c6f9e..e0bc632a259e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1358,7 +1358,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>         return add_cpu_dev_symlink(policy, cpu);
>  }
>
> -static void cpufreq_offline(unsigned int cpu)
> +static int cpufreq_offline(unsigned int cpu)
>  {
>         struct cpufreq_policy *policy;
>         int ret;
> @@ -1368,7 +1368,7 @@ static void cpufreq_offline(unsigned int cpu)
>         policy = cpufreq_cpu_get_raw(cpu);
>         if (!policy) {
>                 pr_debug("%s: No cpu_data found\n", __func__);
> -               return;
> +               return 0;
>         }
>
>         down_write(&policy->rwsem);
> @@ -1417,6 +1417,7 @@ static void cpufreq_offline(unsigned int cpu)
>
>  unlock:
>         up_write(&policy->rwsem);
> +       return 0;
>  }
>
>  /**
> @@ -2332,28 +2333,6 @@ int cpufreq_update_policy(unsigned int cpu)
>  }
>  EXPORT_SYMBOL(cpufreq_update_policy);
>
> -static int cpufreq_cpu_callback(struct notifier_block *nfb,
> -                                       unsigned long action, void *hcpu)
> -{
> -       unsigned int cpu = (unsigned long)hcpu;
> -
> -       switch (action & ~CPU_TASKS_FROZEN) {
> -       case CPU_ONLINE:
> -       case CPU_DOWN_FAILED:
> -               cpufreq_online(cpu);
> -               break;
> -
> -       case CPU_DOWN_PREPARE:
> -               cpufreq_offline(cpu);
> -               break;
> -       }
> -       return NOTIFY_OK;
> -}
> -
> -static struct notifier_block __refdata cpufreq_cpu_notifier = {
> -       .notifier_call = cpufreq_cpu_callback,
> -};
> -
>  /*********************************************************************
>   *               BOOST                                              *
>   *********************************************************************/
> @@ -2455,6 +2434,7 @@ EXPORT_SYMBOL_GPL(cpufreq_boost_enabled);
>  /*********************************************************************
>   *               REGISTER / UNREGISTER CPUFREQ DRIVER                *
>   *********************************************************************/
> +static enum cpuhp_state hp_online;
>
>  /**
>   * cpufreq_register_driver - register a CPU Frequency driver
> @@ -2517,7 +2497,13 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>                 goto err_if_unreg;
>         }
>
> -       register_hotcpu_notifier(&cpufreq_cpu_notifier);
> +       ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "cpufreq:online",
> +                                       cpufreq_online,
> +                                       cpufreq_offline);
> +       if (ret < 0)
> +               goto err_if_unreg;
> +       hp_online = ret;

hp_online is enum cpuhp_state (and we pass it to
cpuhp_remove_state_nocalls(() later on), but
cpuhp_setup_state_nocalls() returns an int (and that should be 0 if it
is not an error code AFAICS), so is this actually correct?

Thanks,
Rafael
