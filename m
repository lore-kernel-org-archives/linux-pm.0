From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: enable HWP before manipulating on
 corresponding registers
Date: Fri, 26 Jan 2018 14:35:17 +0800
Message-ID: <20180126063517.GA16756@yu-chen.sh.intel.com>
References: <20180125110802.15141-1-yu.c.chen@intel.com>
 <1516920299.16193.21.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516920299.16193.21.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 25, 2018 at 02:44:59PM -0800, Srinivas Pandruvada wrote:
> On Thu, 2018-01-25 at 19:08 +0800, Yu Chen wrote:
> 
> Thanks for debugging.
> 
> > The following warning was triggered after resumed from S3 -
> > if all the nonboot CPUs were put offline before suspend:
> > 
> > [ 1840.329515] unchecked MSR access error: RDMSR from 0x771 at rIP:
> > 0xffffffff86061e3a (native_read_msr+0xa/0x30)
> [...]
> 
> [ 1840.329556]  acpi_processor_ppc_has_changed+0x65/0x80
> 
> This is the problem. You are getting a _PPC during resume which needs
> _PSS table to really do anything.
>
OK.
> So the correct fix should not in intel_pstate IMO but
> 
> diff --git a/drivers/acpi/processor_perflib.c
> b/drivers/acpi/processor_perflib.c
> index 18b72ee..c7cf48a 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -159,7 +159,7 @@ void acpi_processor_ppc_has_changed(struct
> acpi_processor *pr, int event_flag)
>  {
>         int ret;
>  
> -       if (ignore_ppc) {
> +       if (ignore_ppc || !pr->performance) {
>                 /*
>                  * Only when it is notification event, the _OST object
>                  * will be evaluated. Otherwise it is skipped.
> 
> 
> ...
> Since we don't call acpi_processor_register_performance(), the pr-
> >performance will be NULL. When this is NULL we don't need to do PPC
> change notification.
> Even if we register performance, processing a PPC notification is
> complex as we have to wait for PPC=0 before enabling HWP otherwise we
> will be stuck with low performance (The event may not come once in HWP
> is in control).
> 
OK.
> The important bug which you identified need a fix in resume when
> maxcpus=1.
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 93a0e88..10e5efc 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -779,13 +779,16 @@ static int intel_pstate_hwp_save_state(struct
> cpufreq_policy *policy)
>         return 0;
>  }
>  
> +static void intel_pstate_hwp_enable(struct cpudata *cpudata);
> +
>  static int intel_pstate_resume(struct cpufreq_policy *policy)
>  {
>         if (!hwp_active)
>                 return 0;
>  
>         mutex_lock(&intel_pstate_limits_lock);
> -
> +       if (!policy->cpu)
The 'if' statement might not be needed, as intel_pstate_resume()
is always invoked on boot cpu IMO.
Thanks,
Yu
> +               intel_pstate_hwp_enable(all_cpu_data[policy->cpu]);
>         all_cpu_data[policy->cpu]->epp_policy = 0;
>         intel_pstate_hwp_set(policy->cpu);
> 
