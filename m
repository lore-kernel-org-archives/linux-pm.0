From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Update][PATCH 1/2] cpufreq: intel_pstate: Per CPU P-State limits
Date: Thu, 13 Oct 2016 02:16:26 +0200
Message-ID: <CAJZ5v0gOqjE_FD+AQQ8fpbnnm7cbjaft8Dw1vCjF3r3_Y5wCSQ@mail.gmail.com>
References: <1476299241-87924-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <3832699.WyNH3AWCH1@vostro.rjw.lan> <1476314165.59335.137.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35483 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932966AbcJMAQ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2016 20:16:28 -0400
Received: by mail-qt0-f193.google.com with SMTP id g49so2146901qtc.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2016 17:16:28 -0700 (PDT)
In-Reply-To: <1476314165.59335.137.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

On Thu, Oct 13, 2016 at 1:16 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> Hi,
>
> On Thu, 2016-10-13 at 00:26 +0200, Rafael J. Wysocki wrote:
>
> [...]
>
>>
>> I have a couple of comments to the details, but let me start with a
>> high-level view.
>> I would do this quite differently.  There is quite a bit of a
>> headache with
>> keeping the global settings (intel_pstate/max(min)_perf_pct) and the
>> per-policy
>> scaling_max(min)_freq in sync and I'm not sure this really is
>> necessary.
>> Moreover, all of these updates are asynchronous with respect to the
>> scheduler
>> callback anyway, so there are races this synchronization between the
>> settings
>> doesn't cover.  IMO, it would be sufficient to combine the two in
>> intel_pstate_get_min_max() only where the limits to apply for the
>> given CPU are
>> computed.
>>
>> So if limits->max_sysfs_perf is there (in addition to or even instead
>> of
>> limits->max_sysfs_pct), intel_pstate_get_min_max() can be something
>> like:
>
> Idea is to preserve current functionality.
>
> The problem with approach is that limits are changed via cpufreq sysfs,
> the intel_pstate sysfs doesn't reflect that. This is the value it is
> displaying currently so keeping the same functionality.
>
> Currently we know from Intel P-state sysfs the limited performance
> value irrespective of which sysfs did. So I don't want to break this
> behavior (There are tools reading intel_pstate sysfs for current limits
> to get to next quickly to meet thermal deadline, also cpufreq sysfs
> limits can change without tools knowledge by say thermal or _PPC, so
> the intel P-state sysfs is a common place now).

Sigh.  OK

Why don't we update the effective min and max (stored in static
variables) when (a) the global sysfs is written to and (b) on updates
via ->set_policy()?

That would allow us to avoid the loops over online CPUs when updating
the global sysfs settings.

> For the sync issue with scheduler callbacks, the effect will see in
> next cycle. Anyway limits don't need to be instantaneous.

Sure.

> static void intel_pstate_get_min_max(struct cpudata *cpu, int *min,
>> int *max)
>>
> Better to avoid more comparisons in fast path function.

Yeah, in general.  Except when there's too much pain with that which
clearly is the case here to me. :-)

>
> [...]
>
>> > @@ -569,12 +566,12 @@ static void intel_pstate_hwp_set(const struct
>> > cpumask *cpumask)
>> >             range = hw_max - hw_min;
>> >
>> >             rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
>> > -           adj_range = limits->min_perf_pct * range / 100;
>> > +           adj_range = all_cpu_data[cpu]->min_perf_pct *
>> > range / 100;
>> >             min = hw_min + adj_range;
>> >             value &= ~HWP_MIN_PERF(~0L);
>> >             value |= HWP_MIN_PERF(min);
>> >
>> > -           adj_range = limits->max_perf_pct * range / 100;
>> > +           adj_range = all_cpu_data[cpu]->max_perf_pct *
>> > range / 100;
>> >             max = hw_min + adj_range;
>> >             if (limits->no_turbo) {
>> >                     hw_max = HWP_GUARANTEED_PERF(cap);
>>
>> I'd change this as I said in the beginning.
> This needs to be done irrespective of the way choose. The HWP requests
> are per CPU.

It looks like I commented a wrong function.  I meant intel_pstate_get_min_max().

>> >
>> >
> [...]
>> > + * since that is what can be be most constrained min performance
>> > limit.
>> > + */
>>
>> Generally, if you add a comment to a function, there's no reason why
>> it should
>> not be a proper kerneldoc.
> I can add that.
>
>> > [...]
>
>> > +   for_each_online_cpu(cpu_index) {
>>
>> Iterating over online CPUs generally requires CPU online/offline to
>> be locked.
>>
>> Otherwise the CPU you are dealing with at the moment may go away from
>> under you.
>
> We are updating memory variables only which are not per_cpu variable.
> When offline is done the stop() callback will be called where the mutex
> will prevent race. I can add get/put_online, this is an overkill as
> user can get during next read. Also there is still a small window after
> put_online_cpu() and sysfs return to user mode, where offline can still
> happen, so it doesn't take care of all cases.

Well, what if cpu_online_mask is updated while you are looking at it?
Is that guaranteed to always be consistent without the online/offline
locking?

Anyway, I'd prefer to avoid doing those loops entirely.

>>
> [...]
>
>> > +           struct cpudata *cpu = all_cpu_data[cpu_index];
>> >
>> > +static ssize_t show_min_perf_pct(struct kobject *kobj,
>> > +                            struct attribute *attr, char
>> > *buf)
>> > +{
>> > +   int max_perf, min_perf;
>> > +
>> > +   get_max_min_perf(&max_perf, &min_perf);
>> > +
>> > +   return sprintf(buf, "%d\n", min_perf);
>> > +}
>>
>> From the above two we can simply return the last value written to
>> them IMO.
> Most of the time it will be last value unless someone changed the
> cpufreq policy anyway.
>
>>
>> That would be less confusing to users than returning some effective
>> value
>> depending on the per-policy settings.
> This is what returned now. Currently cpupower utility is used by many
> to limit performance via cpufreq sysfs and we return the reduced value
> via sysfs read here.

OK

Thanks,
Rafael
