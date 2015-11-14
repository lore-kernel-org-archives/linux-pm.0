From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 2/3] cpufreq: intel_pstate: wrong flag checking for
 no_acpi_perf
Date: Fri, 13 Nov 2015 16:35:54 -0800
Message-ID: <1447461354.3190.0.camel@linux.intel.com>
References: <1447124291-14059-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1447124291-14059-3-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <2898952.tN20UOVv0J@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7212 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752306AbbKNAhf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 13 Nov 2015 19:37:35 -0500
In-Reply-To: <2898952.tN20UOVv0J@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: rafael.j.wysocki@intel.com, lenlenb@kernel.org, linux-pm@vger.kernel.org

On Sat, 2015-11-14 at 01:46 +0100, Rafael J. Wysocki wrote:
> On Monday, November 09, 2015 06:58:10 PM Srinivas Pandruvada wrote:
> > The checking of no_acpi_perf flag is wrong. Since there is null
> > check in acpi_processor_unregister_performance this doesn't cause
> > any issue when this flag is 0.
> > 
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index a0b8180..69dc9b5 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -328,7 +328,7 @@ static int intel_pstate_exit_perf_limits(struct
> > cpufreq_policy *policy)
> >  {
> >  	struct cpudata *cpu;
> >  
> > -	if (!no_acpi_perf)
> > +	if (no_acpi_perf)
> >  		return 0;
> >  
> >  	cpu = all_cpu_data[policy->cpu];
> 
> While the patch is correct, the changelog doesn't make a lot of sense
> to me
> to be honest.
> 
> In addition to that, the cpu variable here is actually not used, so
> what
> about doing something like the below instead here?
Sure, I will resubmit this.

Thanks,
Srinivas

---
>  drivers/cpufreq/intel_pstate.c |    6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -326,13 +326,9 @@ static int intel_pstate_init_perf_limits
>  
>  static int intel_pstate_exit_perf_limits(struct cpufreq_policy
> *policy)
>  {
> -	struct cpudata *cpu;
> -
>  	if (!no_acpi_perf)
> -		return 0;
> +		acpi_processor_unregister_performance(policy->cpu);
>  
> -	cpu = all_cpu_data[policy->cpu];
> -	acpi_processor_unregister_performance(policy->cpu);
>  	return 0;
>  }
>  
> 
