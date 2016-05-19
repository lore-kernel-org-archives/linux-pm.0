From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 4/5] cpufreq: schedutil: map raw required frequency to
 CPU-supported frequency
Date: Thu, 19 May 2016 23:07:41 +0200
Message-ID: <CAJZ5v0iTJEyNky=_w1ti9Np4gdVA6a1fSg0UcDOK9gAgOQv_qA@mail.gmail.com>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
	<1462828814-32530-5-git-send-email-smuckle@linaro.org>
	<CAJZ5v0iNc767ANwQpju4D9XMfjADuZrfvuQvQ_CBmcDKUAuEAA@mail.gmail.com>
	<20160519193547.GF17223@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36053 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932710AbcESVHn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 17:07:43 -0400
In-Reply-To: <20160519193547.GF17223@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>

On Thu, May 19, 2016 at 9:35 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
> On Thu, May 19, 2016 at 01:37:40AM +0200, Rafael J. Wysocki wrote:
>> On Mon, May 9, 2016 at 11:20 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
>> > The mechanisms for remote CPU updates and slow-path frequency
>> > transitions are relatively expensive - the former is an IPI while the
>> > latter requires waking up a thread to do work. These activities should
>> > be avoided if they are not necessary. To that end, calculate the
>> > actual target-supported frequency required by the new utilization
>> > value in schedutil. If it is the same as the previously requested
>> > frequency then there is no need to continue with the update.
>>
>> Unless the max/min limits changed in the meantime, right?
>
> Right, I'll amend the commit text. The functionality is correct AFAICS.
>
>> >
>> > Signed-off-by: Steve Muckle <smuckle@linaro.org>
>> > ---
>> >  kernel/sched/cpufreq_schedutil.c | 14 +++++++++++++-
>> >  1 file changed, 13 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> > index 6cb2ecc204ec..e185075fcb5c 100644
>> > --- a/kernel/sched/cpufreq_schedutil.c
>> > +++ b/kernel/sched/cpufreq_schedutil.c
>> > @@ -153,14 +153,26 @@ static void sugov_update_commit(struct sugov_cpu *sg_cpu, int cpu, u64 time,
>> >   * next_freq = C * curr_freq * util_raw / max
>> >   *
>> >   * Take C = 1.25 for the frequency tipping point at (util / max) = 0.8.
>> > + *
>> > + * The lowest target-supported frequency which is equal or greater than the raw
>> > + * next_freq (as calculated above) is returned, or the CPU's max_freq if such
>> > + * a target-supported frequency does not exist.
>> >   */
>> >  static unsigned int get_next_freq(struct cpufreq_policy *policy,
>> >                                   unsigned long util, unsigned long max)
>> >  {
>> > +       struct cpufreq_frequency_table *entry;
>> >         unsigned int freq = arch_scale_freq_invariant() ?
>> >                                 policy->cpuinfo.max_freq : policy->cur;
>> > +       unsigned int target_freq = UINT_MAX;
>> > +
>> > +       freq = (freq + (freq >> 2)) * util / max;
>> > +
>> > +       cpufreq_for_each_valid_entry(entry, policy->freq_table)
>> > +               if (entry->frequency >= freq && entry->frequency < target_freq)
>> > +                       target_freq = entry->frequency;
>>
>> Please don't assume that every driver will have a frequency table.
>> That may not be the case in the future (and I'm not even sure about
>> the existing CPPC driver for that matter).
>
> For platforms without a frequency table I guess we can just continue
> with the current behavior, passing in the raw calculated frequency. I'll
> make this change.
>
> At some point I imagine those platforms will want to somehow achieve
> similar behavior to avoid very small transitions that do not result in
> real benefit. Maybe some sort of threshold % in the schedutil down the
> road.

So honestly, I'd like to defer this particular optimization for the time being.
