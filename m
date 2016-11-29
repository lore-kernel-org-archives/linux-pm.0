From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: Allow inactive opp_device to be present in dev
 list
Date: Tue, 29 Nov 2016 12:56:38 -0800
Message-ID: <20161129205638.GB6095@codeaurora.org>
References: <2fe61813c867c173ddfcb0b9cabc00a65997a935.1480056714.git.viresh.kumar@linaro.org>
 <20161129024647.GY6095@codeaurora.org>
 <20161129051115.GE3288@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161129051115.GE3288@vireshk-i7>
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, jy0922.shim@samsung.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/29, Viresh Kumar wrote:
> On 28-11-16, 18:46, Stephen Boyd wrote:
> > Anyway, rant over, how about handing out the opp table pointer to
> > the caller so they can pass it back in when they call the put
> > side? That should fix the same problem if I understand correctly.
> 
> Hmm, so the problem is that all below routines (and their callers) need to get
> updated:
> 
> int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
> void dev_pm_opp_put_supported_hw(struct device *dev);
> int dev_pm_opp_set_prop_name(struct device *dev, const char *name);
> void dev_pm_opp_put_prop_name(struct device *dev);
> struct opp_table *dev_pm_opp_set_regulator(struct device *dev, const char *name);
> void dev_pm_opp_put_regulator(struct opp_table *opp_table);
> 
> And that will make it difficult to get it back to stable kernels, specially
> because they were all added in different kernel releases after 4.4.

Why do we care? The put variants of the prop and supported_hw
functions are never called, so we're not going to hit this
problem there. Sure the code is broken, but nobody is using the
code in mainline so there isn't anything to backport to stable
urgently.

> 
> And we also need to fix them properly, with something like a cookie instead of a
> plain opp_table pointer.

Perhaps this means my approach in using opp_table is undesirable
for some reason? Care to elaborate why?

> 
> I suggest this patch for the time being, with a big FIXME in it, so that we can
> get it to stable kernels.
> 
> -------------------------8<-------------------------
> 
> diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
> index 8c3434bdb26d..2e96efdb10b2 100644
> --- a/drivers/base/power/opp/cpu.c
> +++ b/drivers/base/power/opp/cpu.c
> @@ -118,26 +118,45 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
>  EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
>  #endif /* CONFIG_CPU_FREQ */
>  
> +void _cpu_remove_table(unsigned int cpu, bool of)

static?

> +{
> +       struct device *cpu_dev = get_cpu_device(cpu);
> +
> +       if (!cpu_dev) {
> +               pr_err("%s: failed to get cpu%d device\n", __func__, cpu);
> +               return;
> +       }
> +
> +       if (of)
> +               dev_pm_opp_of_remove_table(cpu_dev);
> +       else
> +               dev_pm_opp_remove_table(cpu_dev);
> +}
> +
>  void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
>  {
>         struct device *cpu_dev;
> -       int cpu;
> +       int cpu, first_cpu;
>  
>         WARN_ON(cpumask_empty(cpumask));
>  
> -       for_each_cpu(cpu, cpumask) {
> -               cpu_dev = get_cpu_device(cpu);
> -               if (!cpu_dev) {
> -                       pr_err("%s: failed to get cpu%d device\n", __func__,
> -                              cpu);
> -                       continue;
> -               }
> -
> -               if (of)
> -                       dev_pm_opp_of_remove_table(cpu_dev);
> -               else
> -                       dev_pm_opp_remove_table(cpu_dev);
> -       }
> +       /*
> +        * The first cpu in the cpumask is important as that is used to create
> +        * the opp-table initially and routines like dev_pm_opp_put_regulator()
> +        * will expect the list-dev for the first CPU to be present while such
> +        * routines are called, otherwise we will fail to find the opp-table for
> +        * such devices.

This seems a lot like the patch from Joonyoung. It would be good
to add a note that the patch is based on that one and also a
reported-by tag.

Also, this approach is brittle as it requires that the first
device in the mask be used for the set/put APIs, when that could
be any of the devices. I'd prefer we used my patch because it
isn't as easy to break and more directly fixes the problem at
hand.

> +        *
> +        * FIXME: Cleanup this mess and implement cookie based solutions instead
> +        * of working on the device pointer.
> +        */
> +       first_cpu = cpumask_first(cpumask);
> +       cpumask_clear_cpu(first_cpu, cpumask);
> +
> +       for_each_cpu(cpu, cpumask)
> +               _cpu_remove_table(cpu, of);
> +
> +       _cpu_remove_table(first_cpu, of);
>  }

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
