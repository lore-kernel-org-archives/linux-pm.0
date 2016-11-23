From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Set EPP/EPB to 0 in performance mode
Date: Wed, 23 Nov 2016 02:41:19 +0100
Message-ID: <1503488.o2vxte9FuN@vostro.rjw.lan>
References: <1479858269-175501-1-git-send-email-srinivas.pandruvada@linux.intel.com> <CAJZ5v0i_PkFDYze-vwc=u2fY2HhjPL02ZG1xkTE2ksaQQVoecA@mail.gmail.com> <1479863762.20426.8.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48991 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752399AbcKWBdf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 20:33:35 -0500
In-Reply-To: <1479863762.20426.8.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On Tuesday, November 22, 2016 05:16:02 PM Srinivas Pandruvada wrote:
> On Wed, 2016-11-23 at 01:42 +0100, Rafael J. Wysocki wrote:
> > On Wed, Nov 23, 2016 at 12:44 AM, Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > > 
> > > When user has selected performance policy, then set the EPP (Energy
> > > Performance Preference) or EPB (Energy Performance Bias) to maximum
> > > performance mode.
> > > Also when user switch back to powersave, then restore EPP/EPB to
> > > last
> > > EPP/EPB value before entering performance mode. If user has not
> > > changed
> > > EPP/EPB manually then it will be power on default value.
> > > 
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > > .com>
> > > ---
> > > v2:
> > >         Save EPP/EPB when policy is switched to performance and
> > > restore
> > >         on entering powersave policy, when EPP/EPB is still 0.
> > > 
> > >  drivers/cpufreq/intel_pstate.c | 82
> > > ++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 82 insertions(+)
> > > 
> > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > b/drivers/cpufreq/intel_pstate.c
> > > index 72e8bbc..8e7ceef 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -243,6 +243,8 @@ struct perf_limits {
> > >   *                     when per cpu controls are enforced
> > >   * @acpi_perf_data:    Stores ACPI perf information read from _PSS
> > >   * @valid_pss_table:   Set to true for valid ACPI _PSS entries
> > > found
> > > + * @epp_saved:         Last saved HWP energy performance
> > > preference
> > > + *                     or energy performance bias
> > >   *
> > >   * This structure stores per CPU instance data for all CPUs.
> > >   */
> > > @@ -270,6 +272,7 @@ struct cpudata {
> > >         bool valid_pss_table;
> > >  #endif
> > >         unsigned int iowait_boost;
> > > +       int epp_saved;
> > >  };
> > > 
> > >  static struct cpudata **all_cpu_data;
> > > @@ -568,6 +571,48 @@ static inline void update_turbo_state(void)
> > >                  cpu->pstate.max_pstate == cpu-
> > > >pstate.turbo_pstate);
> > >  }
> > > 
> > > +static int intel_pstate_get_epb(struct cpudata *cpu_data)
> > > +{
> > > +       u64 epb;
> > > +       int ret;
> > > +
> > > +       if (!static_cpu_has(X86_FEATURE_EPB))
> > > +               return -ENXIO;
> > > +
> > > +       ret = rdmsrl_on_cpu(cpu_data->cpu,
> > > MSR_IA32_ENERGY_PERF_BIAS, &epb);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       return (int)(epb & 0x0f);
> > > +}
> > > +
> > > +static int intel_pstate_get_epp(struct cpudata *cpu_data, u64
> > > hwp_req_data)
> > > +{
> > > +       int epp;
> > > +
> > > +       if (static_cpu_has(X86_FEATURE_HWP_EPP))
> > > +               epp = (hwp_req_data >> 24) & 0xff;
> > > +       else
> > > +               /* When there is no EPP present, HWP uses EPB
> > > settings */
> > > +               epp = intel_pstate_get_epb(cpu_data);
> > > +
> > > +       return epp;
> > > +}
> > > +
> > > +static void intel_pstate_set_epb(int cpu, int pref)
> > > +{
> > > +       u64 epb;
> > > +
> > > +       if (!static_cpu_has(X86_FEATURE_EPB))
> > > +               return;
> > > +
> > > +       if (rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb))
> > > +               return;
> > > +
> > > +       epb = (epb & ~0x0f) | pref;
> > > +       wrmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, epb);
> > > +}
> > > +
> > >  static void intel_pstate_hwp_set(const struct cpumask *cpumask)
> > >  {
> > >         int min, hw_min, max, hw_max, cpu, range, adj_range;
> > > @@ -576,6 +621,8 @@ static void intel_pstate_hwp_set(const struct
> > > cpumask *cpumask)
> > > 
> > >         for_each_cpu(cpu, cpumask) {
> > >                 int max_perf_pct, min_perf_pct;
> > > +               struct cpudata *cpu_data = all_cpu_data[cpu];
> > > +               int epp;
> > > 
> > >                 if (per_cpu_limits)
> > >                         perf_limits = all_cpu_data[cpu]-
> > > >perf_limits;
> > > @@ -604,6 +651,41 @@ static void intel_pstate_hwp_set(const struct
> > > cpumask *cpumask)
> > > 
> > >                 value &= ~HWP_MAX_PERF(~0L);
> > >                 value |= HWP_MAX_PERF(max);
> > > +               if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE)
> > > {
> > > +                       epp = intel_pstate_get_epp(cpu_data,
> > > value);
> > > +                       if (epp)
> > > +                               cpu_data->epp_saved = epp;
> > I guess 0 is a valid value to save too, isn't it?
> Yes.
> 
> > 
> > > 
> > > +
> > > +                       /* If EPP read was failed, then don't try
> > > to write */
> > > +                       if (epp < 0)
> > > +                               goto skip_epp;
> > So I guess the above could be
> > 
> >                        epp = intel_pstate_get_epp(cpu_data, value);
> >                        /* If EPP read failed, then don't try to write
> > */
> >                        if (epp < 0)
> >                                goto skip_epp;
> > 
> >                       cpu_data->epp_saved = epp;
> > 
> No. We shouldn't store values to cpu_data->epp_saved  when epp = 0,
> since cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE is called multiple
> times one after other (not a one time call only after policy switch),
> if you do that cpu_data->epp_saved is overwritten immediately with 0.
> So when you actually switch to powersave policy you will restore 0.

I see.

But I think then epp_saved should be reset to 0 in the "powersave" branch
or a stale value may be restored from it at one point.

Thanks,
Rafael

