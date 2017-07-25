From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix cpuinfo_cur_freq after
 performance governor changes
Date: Tue, 25 Jul 2017 07:37:32 -0700
Message-ID: <1500993452.4920.9.camel@linux.intel.com>
References: <1500875013-123321-1-git-send-email-yehs1@lenovo.com>
         <7185077.O26hx51RqR@aspire.rjw.lan>
         <KL1PR0302MB2502C43359F4B6A738D509B992BB0@KL1PR0302MB2502.apcprd03.prod.outlook.com>
         <13292124.r3mFCOTPK8@aspire.rjw.lan>
         <KL1PR0302MB2502DDDCC1D0F4FCC2916B4392B80@KL1PR0302MB2502.apcprd03.prod.outlook.com>
         <1500951465.4920.2.camel@linux.intel.com>
         <KL1PR0302MB2502B85BBFF7B8BB79BE40D692B80@KL1PR0302MB2502.apcprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <KL1PR0302MB2502B85BBFF7B8BB79BE40D692B80@KL1PR0302MB2502.apcprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huaisheng HS1 Ye <yehs1@lenovo.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, NingTing Cheng <chengnt@lenovo.com>
List-Id: linux-pm@vger.kernel.org

Hi Huaisheng,

On Tue, 2017-07-25 at 07:03 +0000, Huaisheng HS1 Ye wrote:
> Hi Srinivas,
> Your idea is great, but your patch at cpufreq.c will force all
> platforms to use scaling_cur_freq as first choice when userspace
> wants to access cpuinfo_cur_freq. It is ok for intel x86 platfrom but
> hard to say with other platforms.
arch_freq_get_on_cpu is only implemented on x86, for other platforms it
will not change behavior. I didn't understand your comment about first
choice.

Thanks,
Srinivas


> I modified it like that, it looks more reasonable. How about that?
> 
> Hi Rafael,
> Deleting "get" function pointer within intel_pstate would lead to
> sysfs interface cpuinfo_cur_freq disappearing, because of
> cpufreq_add_dev_interface will check "cpufreq_driver->get" for it.
> Perhaps just return 0 with in intel_pstate_get would be a workaround
> for this issue, how about it?
> 
> I have tested this patch based on Purley platform, both Hardware and
> Software P-states works correct, we could get accurate and same
> frequency from cpuinfo_cur_freq and scaling_cur_freq.
> 
>  drivers/cpufreq/cpufreq.c      | 4 ++++
>  drivers/cpufreq/intel_pstate.c | 8 +++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 9bf97a3..922f9d9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -694,6 +694,10 @@ static ssize_t show_cpuinfo_cur_freq(struct
> cpufreq_policy *policy,
>  	if (cur_freq)
>  		return sprintf(buf, "%u\n", cur_freq);
>  
> +	cur_freq = arch_freq_get_on_cpu(policy->cpu);
> +	if (cur_freq)
> +		return sprintf(buf, "%u\n", cur_freq);
> +
>  	return sprintf(buf, "<unknown>\n");
>  }
>  
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 6cd5035..33e6c10 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1924,9 +1924,11 @@ static int intel_pstate_init_cpu(unsigned int
> cpunum)
>  
>  static unsigned int intel_pstate_get(unsigned int cpu_num)
>  {
> -	struct cpudata *cpu = all_cpu_data[cpu_num];
> -
> -	return cpu ? get_avg_frequency(cpu) : 0;
> +	/*
> +	 * Use frequency from scaling_cur_freq, reserve this
> function
> +	 * for existing of sysfs cpuinfo_cur_freq.
> +	 */
> +	return 0;
>  }
>  
>  static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
> 
> 
> > 
> > On Tue, 2017-07-25 at 01:46 +0000, Huaisheng HS1 Ye wrote:
> > > 
> > > Hi Rafael,
> > > 
> > > If you delete "get" function implement within intel_pstate, the
> > > sysfs
> > > interface cpuinfo_cur_freq will display <unknown> all the time.
> > cpuinfo_cur_freq by definition should show actual frequency HW
> > frequency.
> > Unless I missed something. So Len Brown's patch should also take
> > care of this
> > to get from arch specific function is available.
> > So in addition to Rafael's change, what about this?
> > 
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index
> > 9bf97a3..29ec687 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -689,8 +689,13 @@ store_one(scaling_max_freq, max);
> >  static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy
> > *policy,
> >                                         char *buf)
> >  {
> > -       unsigned int cur_freq = __cpufreq_get(policy);
> > +       unsigned int cur_freq;
> > 
> > +       cur_freq = arch_freq_get_on_cpu(policy->cpu);
> > +       if (cur_freq)
> > +               return sprintf(buf, "%u\n", cur_freq);
> > +
> > +       cur_freq = __cpufreq_get(policy);
> >         if (cur_freq)
> >                 return sprintf(buf, "%u\n", cur_freq);
> > 
> > 
> > 
> > Thanks,
> > Srinivas
> > 
> > > 
> > > To be honest, at the beginning I have consider this way like you
> > > patched, but based two reasons below, it is conservative for us
> > > to do
> > > that.
> > > 
> > > 1. I am worried about whether it would lead to confusion for
> > > customers
> > > or Linux OS venders who are accustomed to cpuinfo_cur_freq.
> > > 2. This is the first time for me to offer patch to intel_pstate,
> > > not
> > > sure whether it could be accepted by you.
> > > 
> > > > 
> > > > 
> > > > On Monday, July 24, 2017 03:32:47 PM Huaisheng HS1 Ye wrote:
> > > > > 
> > > > > 
> > > > > Hi Rafael,
> > > > > Thanks for your reply.
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > On Monday, July 24, 2017 05:43:14 AM Huaisheng HS1 Ye
> > > > > > wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > After commit 82b4e03e01bc (intel_pstate: skip scheduler
> > > > > > > hook
> > > > > > > when in "performance" mode) Software P-state control
> > > > > > > modes
> > > > > > > couldn't get dynamic value during performance mode,
> > > > > > Please explain what you mean here.
> > > > > > 
> > > > > commit 82b4e03e01bc (intel_pstate: skip scheduler hook when
> > > > > in
> > > > > "performance" mode) disables
> > > > > intel_pstate_set_update_util_hook
> > > > > when current policy is performance within function
> > > > > intel_pstate_set_policy.
> > > > > It leads to Software P-states couldn't update sysfs interface
> > > > > cpuinfo_cur_freq's value during performance mode, because of
> > > > > pstate_funcs.update_util couldn't set for the given CPU.
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > I guess you carried out some tests and the results were not
> > > > > > as
> > > > > > expected, so what was the test?
> > > > > Exactly, we check the sysfs interface cpuinfo_cur_freq and
> > > > > the
> > > > > output of cpupower frequency-info both with performance mode.
> > > > OK, so what about the change below:
> > > > 
> > > > ---
> > > >  drivers/cpufreq/intel_pstate.c |    8 --------
> > > >  1 file changed, 8 deletions(-)
> > > > 
> > > > Index: linux-pm/drivers/cpufreq/intel_pstate.c
> > > > 
> > ==============================================================
> > > 
> > > > 
> > > > =====
> > > > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> > > > +++ linux-pm/drivers/cpufreq/intel_pstate.c
> > > > @@ -1674,13 +1674,6 @@ static int intel_pstate_init_cpu(unsigne
> > > >  	return 0;
> > > >  }
> > > > 
> > > > -static unsigned int intel_pstate_get(unsigned int cpu_num) -{
> > > > -	struct cpudata *cpu = all_cpu_data[cpu_num];
> > > > -
> > > > -	return cpu ? get_avg_frequency(cpu) : 0;
> > > > -}
> > > > -
> > > >  static void intel_pstate_set_update_util_hook(unsigned int
> > > > cpu_num)  {
> > > >  	struct cpudata *cpu = all_cpu_data[cpu_num]; @@
> > > > -1921,7
> > > > +1914,6 @@
> > > > static struct cpufreq_driver intel_pstat
> > > >  	.setpolicy	= intel_pstate_set_policy,
> > > >  	.suspend	= intel_pstate_hwp_save_state,
> > > >  	.resume		= intel_pstate_resume,
> > > > -	.get		= intel_pstate_get,
> > > >  	.init		= intel_pstate_cpu_init,
> > > >  	.exit		= intel_pstate_cpu_exit,
> > > >  	.stop_cpu	= intel_pstate_stop_cpu,
