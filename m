From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Fix compilation for !CONFIG_ACPI
Date: Fri, 26 Oct 2018 11:24:25 +0200
Message-ID: <32781963.NEgFcAD2pt@aspire.rjw.lan>
References: <20181023185429.GA6756@light.dominikbrodowski.net> <20181023195403.GA3094@light.dominikbrodowski.net> <af0dac7535332ecedeab9f04654fbb1d5a21e1a2.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <af0dac7535332ecedeab9f04654fbb1d5a21e1a2.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@vger.kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, October 23, 2018 11:52:12 PM CEST Srinivas Pandruvada wrote:
> On Tue, 2018-10-23 at 21:54 +0200, Dominik Brodowski wrote:
> > While at it, add a few comments which config options #ifdef
> > and #else statements refer to.
> > 
> > Fixes: 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency
> > attribute")
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 49c0abf2d48f..9578312e43f2 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -386,16 +386,11 @@ static int intel_pstate_get_cppc_guranteed(int
> > cpu)
> >  	return cppc_perf.guaranteed_perf;
> >  }
> >  
> > -#else
> > +#else /* CONFIG_ACPI_CPPC_LIB */
> >  static void intel_pstate_set_itmt_prio(int cpu)
> >  {
> >  }
> > -
> > -static int intel_pstate_get_cppc_guranteed(int cpu)
> > -{
> > -	return -ENOTSUPP;
> > -}
> > -#endif
> > +#endif /* CONFIG_ACPI_CPPC_LIB */
> >  
> >  static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy
> > *policy)
> >  {
> > @@ -477,7 +472,7 @@ static void intel_pstate_exit_perf_limits(struct
> > cpufreq_policy *policy)
> >  
> >  	acpi_processor_unregister_performance(policy->cpu);
> >  }
> > -#else
> > +#else /* CONFIG_ACPI */
> >  static inline void intel_pstate_init_acpi_perf_limits(struct
> > cpufreq_policy *policy)
> >  {
> >  }
> > @@ -490,7 +485,14 @@ static inline bool
> > intel_pstate_acpi_pm_profile_server(void)
> >  {
> >  	return false;
> >  }
> > -#endif
> > +#endif /* CONFIG_ACPI */
> > +
> > +#ifndef CONFIG_ACPI_CPPC_LIB
> > +static int intel_pstate_get_cppc_guranteed(int cpu)
> > +{
> > +	return -ENOTSUPP;
> > +}
> > +#endif /* CONFIG_ACPI_CPPC_LIB */
> >  
> >  static inline void update_turbo_state(void)
> >  {
> 
> 

Patch applied, thanks!
