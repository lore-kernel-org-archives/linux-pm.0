From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Race condition in cpufreq
Date: Fri, 21 Nov 2014 10:18:59 +0530
Message-ID: <CAOh2x=kcpe1RC2L_P8g=gzKP+T-v+w4sYicCtXFAp_mM2uc_VQ@mail.gmail.com>
References: <CAKZGPAMLm0iHRgfojbxP+Tzbt4eUFovM3NYz83Lnexw3G2QiYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKZGPAMLm0iHRgfojbxP+Tzbt4eUFovM3NYz83Lnexw3G2QiYA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Arun KS <arunks.linux@gmail.com>
Cc: cpufreq <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

please use the right list for cpufreq stuff. Also, cc maintainers if
you want quick replies to your mail.

On Wed, Nov 19, 2014 at 11:25 AM, Arun KS <arunks.linux@gmail.com> wrote:
> Hello,
>
> Seen a race condition in cpufrequency driver.
>
> cpu2 is being hot-plugged out. And this started at say, 20th msec.
> -000|context_switch(inline)
> -000|need_resched()
> -001|preempt_schedule(inline)
> -001|preempt_schedule()
> -002|static_key_false(inline)
> -002|trace_sched_cpu_hotplug(inline)
> -002|cpu_down(cpu = 2, ?)
> -003|cpu_down(cpu = 2)
> -004|update_offline_cores(?)
> -005|do_hotplug(?)
> -006|kthread(_create = 0xEE85BEBC)
>
> cpu1 is updating the governor at say 60th msec.
> echo "some_governor" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> at 60th msec, cpu2 is already hot-plugged but CPU_POST_DEAD has not
> called because __cpu_down was scheduled out at cpu_hotplug_done(while
> unlocking mutex)
>
> now store_scaling_governor calls cpufreq_set_policy
> CPUFREQ_GOV_START iterates through all cpus in policy->cpus(which is
> not the correct one now, because cpu2 is already hot-plugged out(DEAD)
> but not updated in policy->cpus).
>
> One suggestion is to use CPU_DEAD instead of CPU_POST_DEAD in cpufreq.c
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 644b54e..5fdaf06 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2325,7 +2325,7 @@ static int cpufreq_cpu_callback(struct
> notifier_block *nfb,
>                         __cpufreq_remove_dev_prepare(dev, NULL);
>                         break;
>
> -               case CPU_POST_DEAD:
> +               case CPU_DEAD:
>                         __cpufreq_remove_dev_finish(dev, NULL);
>                         break;
>
> Or add a mutex to serialize the context.
> Appreciate your valuable comments.

What kernel version are you using? Sometime back this patch
addressed this problem:

commit 4f750c930822b92df74327a4d1364eff87701360
Author: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Date:   Sat Sep 7 01:23:43 2013 +0530

    cpufreq: Synchronize the cpufreq store_*() routines with CPU hotplug

    The functions that are used to write to cpufreq sysfs files (such as
    store_scaling_max_freq()) are not hotplug safe. They can race with CPU
    hotplug tasks and lead to problems such as trying to acquire an already
    destroyed timer-mutex etc.

    Eg:

        __cpufreq_remove_dev()
         __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
           policy->governor->governor(policy, CPUFREQ_GOV_STOP);
            cpufreq_governor_dbs()
             case CPUFREQ_GOV_STOP:
              mutex_destroy(&cpu_cdbs->timer_mutex)
              cpu_cdbs->cur_policy = NULL;
          <PREEMPT>
        store()
         __cpufreq_set_policy()
          __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
            policy->governor->governor(policy, CPUFREQ_GOV_LIMITS);
             case CPUFREQ_GOV_LIMITS:
              mutex_lock(&cpu_cdbs->timer_mutex); <-- Warning (destroyed mutex)
               if (policy->max < cpu_cdbs->cur_policy->cur) <-
cur_policy == NULL

    So use get_online_cpus()/put_online_cpus() in the store_*() functions, to
    synchronize with CPU hotplug. However, there is an additional point to note
    here: some parts of the CPU teardown in the cpufreq subsystem are done in
    the CPU_POST_DEAD stage, with cpu_hotplug.lock *released*. So, using the
    get/put_online_cpus() functions alone is insufficient; we should also ensure
    that we don't race with those latter steps in the hotplug sequence. We can
    easily achieve this by checking if the CPU is online before proceeding with
    the store, since the CPU would have been marked offline by the time the
    CPU_POST_DEAD notifiers are executed.
