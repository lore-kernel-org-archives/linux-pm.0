From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 10/10] cpufreq: intel_pstate: Use CPPC to get max performance
Date: Thu, 22 Sep 2016 22:58:37 +0200
Message-ID: <CAJZ5v0g5FhQWcNZdnfruxTZYPdKaCqinLnpwvuM1KiwASMdGBA@mail.gmail.com>
References: <1474485552-141429-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1474485552-141429-11-git-send-email-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0h3=JLw8mH=x4jXNec9CGZWiCt+pPmrD1L4=QutT8=g0Q@mail.gmail.com> <1474570233.3916.197.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474570233.3916.197.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, jolsa@redhat.com
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 22, 2016 at 8:50 PM, Tim Chen <tim.c.chen@linux.intel.com> wrote:
> On Wed, 2016-09-21 at 22:30 +0200, Rafael J. Wysocki wrote:
>> On Wed, Sep 21, 2016 at 9:19 PM, Srinivas Pandruvada
>> <srinivas.pandruvada@linux.intel.com> wrote:
>> >
>> >
>> > +
>> > +static void intel_pstate_check_and_enable_itmt(int cpu)
>> > +{
>> > +       /*
>> > +        * For checking whether there is any difference in the maximum
>> > +        * performance for each CPU, need to wait till we have CPPC
>> > +        * data from all CPUs called from the cpufreq core. If there is a
>> > +        * difference in the maximum performance, then we have ITMT support.
>> > +        * If ITMT is supported, update the scheduler core priority for each
>> > +        * CPU and call to enable the ITMT feature.
>> > +        */
>> > +       if (cpumask_subset(topology_core_cpumask(cpu), &cppc_read_cpu_mask)) {
>> > +               int cpu_index;
>> > +               int max_prio;
>> > +               struct cpudata *cpu;
>> > +               bool itmt_support = false;
>> > +
>> > +               cpu = all_cpu_data[cpumask_first(&cppc_read_cpu_mask)];
>> > +               max_prio = cpu->cppc_perf->highest_perf;
>> > +               for_each_cpu(cpu_index, &cppc_read_cpu_mask) {
>> > +                       cpu = all_cpu_data[cpu_index];
>> > +                       if (max_prio != cpu->cppc_perf->highest_perf) {
>> > +                               itmt_support = true;
>> > +                               break;
>> > +                       }
>> > +               }
>> > +
>> > +               if (!itmt_support)
>> > +                       return;
>> > +
>> > +               for_each_cpu(cpu_index, &cppc_read_cpu_mask) {
>> > +                       cpu = all_cpu_data[cpu_index];
>> > +                       sched_set_itmt_core_prio(cpu->cppc_perf->highest_perf,
>> > +                                                cpu_index);
>> > +               }
>> My current understanding is that we need to rebuild sched domains
>> after setting the priorities,
>
> No, that's not true.  We need to rebuild the sched domains only
> when the sched domain flags are changed, not when we are changing
> the priorities.  Only the sched domain flag is a property of
> the sched domain. CPU priority values are not part of sched domain.
>
> Morten had similar question about whether we need to rebuild sched domain
> when we change cpu priorities when we first post the patches.
> Peter has explained that it wasn't necessary.
> http://lkml.iu.edu/hypermail/linux/kernel/1608.3/01753.html

So to me this means that sched domains need to be rebuilt in two cases
by the ITMT code:
(1) When the "ITMT capable" flag changes.
(2) When the sysctl setting changes.

In which case I'm not sure why intel_pstate_check_and_enable_itmt()
has to be so complicated.

It seems to only need to (a) set the priority for the current CPU and
(b) invoke sched_set_itmt_support() (via the work item) to set the
"ITMT capable" flag if it finds out that ITMT should be enabled.

And it may be better to enable ITMT at the _OSC exchange time (if the
platform acknowledges support).

>> so what if there are two CPU packages
>> and there are highest_perf differences in both, and we first enumerate
>> the first package entirely before getting to the second one?
>>
>> In that case we'll schedule the work item after enumerating the first
>> package and it may rebuild the sched domains before all priorities are
>> set for the second package, may it not?
>
> That is not a problem.  For the second package, all the cpu priorities
> are initialized to the same value.  So even if we start to do
> asym_packing in the scheduler for the whole system,
> on the second package, all the cpus are treated equally by the scheduler.
> We will operate as if there is no favored core till we update the
> priorities of the cpu on the second package.

OK

But updating those priorities after we have set the "ITMT capable"
flag is not a problem?  Nobody is going to be confused and so on?

> That said, we don't enable ITMT automatically for 2 package system.
> So the explicit sysctl command to enable ITMT and cause the sched domain
> rebuild for 2 package system is most likely to come after
> we have discovered and set all the cpu priorities.

Right, but if that behavior is relied on, there should be a comment
about that in the code (and relying on it would be kind of fragile for
that matter).

>>
>> This seems to require some more consideration.
>>
>> >
>> > +               /*
>> > +                * Since this function is in the hotcpu notifier callback
>> > +                * path, submit a task to workqueue to call
>> > +                * sched_set_itmt_support().
>> > +                */
>> > +               schedule_work(&sched_itmt_work);
>> It doesn't make sense to do this more than once IMO and what if we
>> attempt to schedule the work item again when it has been scheduled
>> once already?  Don't we need any protection here?
>
> It is not a problem for sched_set_itmt_support to be called more than
> once.

While it is not incorrect, it also is not particularly useful to
schedule a work item just to find out later that it had nothing to do
to begin with.

Thanks,
Rafael
