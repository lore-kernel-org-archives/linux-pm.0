From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC/RFT] [PATCH 07/10] cpufreq: intel_pstate: HWP boost
 performance on busy task migrate
Date: Wed, 16 May 2018 13:59:02 -0700
Message-ID: <1526504342.61700.87.camel@linux.intel.com>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
         <20180516044911.28797-8-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0ixBnniXkaKJPywCsPkNp33BY7yDGnnMJ5kavP_g4ULFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0ixBnniXkaKJPywCsPkNp33BY7yDGnnMJ5kavP_g4ULFg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mel Gorman <mgorman@techsingularity.net>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2018-05-16 at 11:49 +0200, Rafael J. Wysocki wrote:
> On Wed, May 16, 2018 at 6:49 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > When a busy task migrates to a new CPU boost HWP prformance to max.
> > This
> > helps workloads on servers with per core P-states, which saturates
> > all
> > CPUs and then they migrate frequently. But changing limits has
> > extra over
> > head of issuing new HWP Request MSR, which takes 1000+
> > cycles. So this change limits setting HWP Request MSR.
> > Rate control in setting HWP Requests:
> > - If the current performance is around P1, simply ignore.
> > - Once set wait till hold time, till remove boost. While the boost
> >  is on, another flags is notified, it will prolong boost.
> > - The task migrates needs to have some utilzation which is more
> > than threshold utilization, which will trigger P-state above
> > minimum.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 37
> > ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 36 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index d418265..ec455af 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -227,6 +227,7 @@ struct global_params {
> >   *                     defines callback and arguments
> >   * @hwp_boost_active:  HWP performance is boosted on this CPU
> >   * @last_io_update:    Last time when IO wake flag was set
> > + * @migrate_hint:      Set when scheduler indicates thread
> > migration
> >   *
> >   * This structure stores per CPU instance data for all CPUs.
> >   */
> > @@ -263,6 +264,7 @@ struct cpudata {
> >         call_single_data_t csd;
> >         bool hwp_boost_active;
> >         u64 last_io_update;
> > +       bool migrate_hint;
> 
> Why do you need this in the struct?
> 
> It looks like it only is used locally in
> intel_pstate_update_util_hwp().
It is required as we set just set a flag for the new CPU in its cpudata
that a task is migrated on it. We update performance on the next tick
on local cpu only when the rq utilization is updated to check whether
it is worth boosting.

Thanks,
Srinivas
