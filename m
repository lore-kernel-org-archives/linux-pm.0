From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH][RFC] ACPI: add "processor.broadcast_ppc" hook to
 broadcast _PPC to all online CPUs
Date: Mon, 11 Feb 2019 16:00:10 +0530
Message-ID: <20190211103010.qet5jvncvkdl7s5n@vireshk-i7>
References: <20190209120232.21582-1-yu.c.chen@intel.com>
 <20190211091627.homaij2rtqzrytbu@vireshk-i7>
 <CAJZ5v0gMV-GCoFcwa4zMKPf8W=o=bb6fzB7ZRAxkKUyjNwqc+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gMV-GCoFcwa4zMKPf8W=o=bb6fzB7ZRAxkKUyjNwqc+w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Chen Yu <yu.c.chen@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 11-02-19, 11:20, Rafael J. Wysocki wrote:
> On Mon, Feb 11, 2019 at 10:16 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 09-02-19, 20:02, Chen Yu wrote:
> > > On Dell Inc. XPS13 9333, the BIOS changes the value of
> > > MSR_IA32_MISC_ENABLE_TURBO_DISABLE at runtime (e.g., when
> > > the power source changes), the maximum frequency of the
> > > CPU is not updated accordingly. This is due to the policy's
> > > cpuinfo.max is not updated when _PPC notifier fires.
> > >
> > > Fix this problem by updating the policy's cpuinfo.max
> > > and broadcast the _PPC notifier to all online CPUs.
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
> > > Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> > > Originally-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > ---
> > >  drivers/acpi/processor_perflib.c | 16 ++++++++++++++--
> > >  drivers/cpufreq/cpufreq.c        |  2 ++
> > >  drivers/cpufreq/intel_pstate.c   | 15 ++++++++++++++-
> > >  3 files changed, 30 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> > > index a303fd0e108c..737dbf5aa7f7 100644
> > > --- a/drivers/acpi/processor_perflib.c
> > > +++ b/drivers/acpi/processor_perflib.c
> > > @@ -63,6 +63,10 @@ module_param(ignore_ppc, int, 0644);
> > >  MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
> > >                "limited by BIOS, this should help");
> > >
> > > +static int broadcast_ppc;
> > > +module_param(broadcast_ppc, int, 0644);
> > > +MODULE_PARM_DESC(broadcast_ppc, "Broadcast the ppc to all online CPUs");
> > > +
> > >  #define PPC_REGISTERED   1
> > >  #define PPC_IN_USE       2
> > >
> > > @@ -180,8 +184,16 @@ void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
> > >               else
> > >                       acpi_processor_ppc_ost(pr->handle, 0);
> > >       }
> > > -     if (ret >= 0)
> > > -             cpufreq_update_policy(pr->id);
> > > +     if (ret >= 0) {
> > > +             if (broadcast_ppc) {
> > > +                     int cpu;
> > > +
> > > +                     for_each_possible_cpu(cpu)
> > > +                             cpufreq_update_policy(cpu);
> > > +             } else {
> > > +                     cpufreq_update_policy(pr->id);
> > > +             }
> > > +     }
> > >  }
> > >
> > >  int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index e35a886e00bc..95e08816b512 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -2237,6 +2237,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> > >
> > >       policy->min = new_policy->min;
> > >       policy->max = new_policy->max;
> > > +     policy->cpuinfo.max_freq = new_policy->cpuinfo.max_freq;
> > > +     policy->cpuinfo.min_freq = new_policy->cpuinfo.min_freq;
> > >       trace_cpu_frequency_limits(policy);
> > >
> > >       policy->cached_target_freq = UINT_MAX;
> > > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > > index dd66decf2087..e1881313c396 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -2081,11 +2081,24 @@ static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
> > >
> > >  static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
> > >  {
> > > +     int max_freq;
> > >       struct cpudata *cpu = all_cpu_data[policy->cpu];
> > >
> > >       update_turbo_state();
> > > +     max_freq = intel_pstate_get_max_freq(cpu);
> > > +
> > > +     if (acpi_ppc && policy->max == policy->cpuinfo.max_freq &&
> > > +         max_freq != policy->cpuinfo.max_freq) {
> > > +             /*
> > > +              * System was not running under any constraints, but the
> > > +              * current max possible frequency is changed. So reset
> > > +              * policy limits.
> > > +              */
> > > +             policy->cpuinfo.max_freq = policy->max = max_freq;
> > > +     }
> > > +
> > >       cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> > > -                                  intel_pstate_get_max_freq(cpu));
> > > +                                  max_freq);
> > >
> > >       if (policy->policy != CPUFREQ_POLICY_POWERSAVE &&
> > >           policy->policy != CPUFREQ_POLICY_PERFORMANCE)
> >
> > By TURBO I believe this is about boost-frequencies and you should use
> > that infrastructure to make it work, isn't it ?
> 
> I guess you mean the the "boost" attribute in the core, but that's not
> applicable to intel_pstate.

Ahh, I missed the part that this is for the !has_target() platforms :(

-- 
viresh
