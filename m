From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix cpuinfo_cur_freq after performance governor changes
Date: Tue, 25 Jul 2017 17:35:34 +0200
Message-ID: <3849070.kDntuffBgp@aspire.rjw.lan>
References: <1500875013-123321-1-git-send-email-yehs1@lenovo.com> <KL1PR0302MB2502DDDCC1D0F4FCC2916B4392B80@KL1PR0302MB2502.apcprd03.prod.outlook.com> <1500951465.4920.2.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500951465.4920.2.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Huaisheng HS1 Ye <yehs1@lenovo.com>, "lenb@kernel.org" <lenb@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, July 24, 2017 07:57:45 PM Srinivas Pandruvada wrote:
> On Tue, 2017-07-25 at 01:46 +0000, Huaisheng HS1 Ye wrote:
> > Hi Rafael,
> > 
> > If you delete "get" function implement within intel_pstate, the 
> > sysfs interface cpuinfo_cur_freq will display <unknown> all the
> > time. 
> cpuinfo_cur_freq by definition should show actual frequency HW
> frequency. 

Right.

> Unless I missed something. So Len Brown's patch should also
> take care of this to get from arch specific function is available.
> So in addition to Rafael's change, what about this?
> 
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 9bf97a3..29ec687 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -689,8 +689,13 @@ store_one(scaling_max_freq, max);
>  static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
>                                         char *buf)
>  {
> -       unsigned int cur_freq = __cpufreq_get(policy);
> +       unsigned int cur_freq;
>  
> +       cur_freq = arch_freq_get_on_cpu(policy->cpu);
> +       if (cur_freq)
> +               return sprintf(buf, "%u\n", cur_freq);
> +
> +       cur_freq = __cpufreq_get(policy);
>         if (cur_freq)
>                 return sprintf(buf, "%u\n", cur_freq);
> 

So also by definition cpuinfo_cur_freq should not return the same thing as
scaling_cur_freq.

I actually would like cpuinfo_cur_freq to not be present at all, I need to
check why it still shows up if ->get is not present.

Thanks,
Rafael
