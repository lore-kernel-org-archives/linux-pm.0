From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix cpuinfo_cur_freq after
 performance governor changes
Date: Mon, 24 Jul 2017 19:57:45 -0700
Message-ID: <1500951465.4920.2.camel@linux.intel.com>
References: <1500875013-123321-1-git-send-email-yehs1@lenovo.com>
         <7185077.O26hx51RqR@aspire.rjw.lan>
         <KL1PR0302MB2502C43359F4B6A738D509B992BB0@KL1PR0302MB2502.apcprd03.prod.outlook.com>
         <13292124.r3mFCOTPK8@aspire.rjw.lan>
         <KL1PR0302MB2502DDDCC1D0F4FCC2916B4392B80@KL1PR0302MB2502.apcprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60156 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932077AbdGYC5t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Jul 2017 22:57:49 -0400
In-Reply-To: <KL1PR0302MB2502DDDCC1D0F4FCC2916B4392B80@KL1PR0302MB2502.apcprd03.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Huaisheng HS1 Ye <yehs1@lenovo.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 2017-07-25 at 01:46 +0000, Huaisheng HS1 Ye wrote:
> Hi Rafael,
> 
> If you delete "get" function implement within intel_pstate, the 
> sysfs interface cpuinfo_cur_freq will display <unknown> all the
> time. 
cpuinfo_cur_freq by definition should show actual frequency HW
frequency. Unless I missed something. So Len Brown's patch should also
take care of this to get from arch specific function is available.
So in addition to Rafael's change, what about this?


diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 9bf97a3..29ec687 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -689,8 +689,13 @@ store_one(scaling_max_freq, max);
 static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
                                        char *buf)
 {
-       unsigned int cur_freq = __cpufreq_get(policy);
+       unsigned int cur_freq;
 
+       cur_freq = arch_freq_get_on_cpu(policy->cpu);
+       if (cur_freq)
+               return sprintf(buf, "%u\n", cur_freq);
+
+       cur_freq = __cpufreq_get(policy);
        if (cur_freq)
                return sprintf(buf, "%u\n", cur_freq);



Thanks,
Srinivas

> To be honest, at the beginning I have consider this way like you 
> patched, but based two reasons below, it is conservative for us to do
> that.
> 
> 1. I am worried about whether it would lead to confusion for
> customers or 
> Linux OS venders who are accustomed to cpuinfo_cur_freq.
> 2. This is the first time for me to offer patch to intel_pstate, not
> sure 
> whether it could be accepted by you.
> 
> > 
> > On Monday, July 24, 2017 03:32:47 PM Huaisheng HS1 Ye wrote:
> > > 
> > > Hi Rafael,
> > > Thanks for your reply.
> > > 
> > > > 
> > > > On Monday, July 24, 2017 05:43:14 AM Huaisheng HS1 Ye wrote:
> > > > > 
> > > > > After commit 82b4e03e01bc (intel_pstate: skip scheduler hook
> > > > > when
> > > > > in "performance" mode) Software P-state control modes
> > > > > couldn't get
> > > > > dynamic value during performance mode,
> > > > Please explain what you mean here.
> > > > 
> > > commit 82b4e03e01bc (intel_pstate: skip scheduler hook when in
> > > "performance" mode) disables intel_pstate_set_update_util_hook
> > > when
> > > current policy is performance within function
> > > intel_pstate_set_policy.
> > > It leads to Software P-states couldn't update sysfs interface
> > > cpuinfo_cur_freq's value during performance mode, because of
> > > pstate_funcs.update_util couldn't set for the given CPU.
> > > 
> > > > 
> > > > I guess you carried out some tests and the results were not as
> > > > expected, so what was the test?
> > > Exactly, we check the sysfs interface cpuinfo_cur_freq and the
> > > output
> > > of cpupower frequency-info both with performance mode.
> > OK, so what about the change below:
> > 
> > ---
> >  drivers/cpufreq/intel_pstate.c |    8 --------
> >  1 file changed, 8 deletions(-)
> > 
> > Index: linux-pm/drivers/cpufreq/intel_pstate.c
> > ==============================================================
> > =====
> > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> > +++ linux-pm/drivers/cpufreq/intel_pstate.c
> > @@ -1674,13 +1674,6 @@ static int intel_pstate_init_cpu(unsigne
> >  	return 0;
> >  }
> > 
> > -static unsigned int intel_pstate_get(unsigned int cpu_num) -{
> > -	struct cpudata *cpu = all_cpu_data[cpu_num];
> > -
> > -	return cpu ? get_avg_frequency(cpu) : 0;
> > -}
> > -
> >  static void intel_pstate_set_update_util_hook(unsigned int
> > cpu_num)  {
> >  	struct cpudata *cpu = all_cpu_data[cpu_num]; @@ -1921,7
> > +1914,6 @@
> > static struct cpufreq_driver intel_pstat
> >  	.setpolicy	= intel_pstate_set_policy,
> >  	.suspend	= intel_pstate_hwp_save_state,
> >  	.resume		= intel_pstate_resume,
> > -	.get		= intel_pstate_get,
> >  	.init		= intel_pstate_cpu_init,
> >  	.exit		= intel_pstate_cpu_exit,
> >  	.stop_cpu	= intel_pstate_stop_cpu,
