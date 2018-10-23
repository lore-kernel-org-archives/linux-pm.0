From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix compilation for !CONFIG_ACPI
Date: Tue, 23 Oct 2018 21:34:05 +0200
Message-ID: <20181023193405.pxfl4vyazt7rtc3x@isilmar-4.linta.de>
References: <20181023185429.GA6756@light.dominikbrodowski.net>
 <e8e018e267434cabc2b8db434a3576c082ab3fff.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e8e018e267434cabc2b8db434a3576c082ab3fff.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 23, 2018 at 12:17:28PM -0700, Srinivas Pandruvada wrote:
> On Tue, 2018-10-23 at 20:54 +0200, Dominik Brodowski wrote:
> > Fixes: 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency
> > attribute")
> Thanks for the fix.
> 
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 49c0abf2d48f..50c5699970c5 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -390,11 +390,6 @@ static int intel_pstate_get_cppc_guranteed(int
> > cpu)
> >  static void intel_pstate_set_itmt_prio(int cpu)
> >  {
> >  }
> > -
> > -static int intel_pstate_get_cppc_guranteed(int cpu)
> > -{
> > -	return -ENOTSUPP;
> > -}
> What is ACPI is defined but SCHED_MC_PRIO is not defined?
> Based on
> "select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO"
> 
> So the above is still required. correct?

Seems so, yes. Though that leads to either complicated #ifdefs or code
duplications.

In any case, I'd suggest marking at least nested #else and #endif lines
with comments denoting which #ifdef they relate to, e.g.

	#else	/* CONFIG_ACPI */
	#endif	/* CONFIG_ACPI */

Thanks,
	Dominik
