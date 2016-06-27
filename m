From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V4 1/2] cpufreq: Handle sorted frequency tables more efficiently
Date: Mon, 27 Jun 2016 02:28:39 +0200
Message-ID: <CAJZ5v0jOH1k=FaAHaCLHnp=9MKjUM0v6WJ-HSUFHTy_dsL_KRg@mail.gmail.com>
References: <cover.1465295033.git.viresh.kumar@linaro.org> <c80f4bf69bd4eb739038cb0f91392fad9cfde59f.1465295033.git.viresh.kumar@linaro.org>
 <15131722.y1kqigY9Ad@vostro.rjw.lan> <20160626103840.GA32206@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36278 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbcF0A2l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Jun 2016 20:28:41 -0400
In-Reply-To: <20160626103840.GA32206@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>

On Sun, Jun 26, 2016 at 12:38 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Rafael,
>
> Thanks for having a look at this..
>
> On 23-06-16, 02:28, Rafael J. Wysocki wrote:
>> On Tuesday, June 07, 2016 03:55:14 PM Viresh Kumar wrote:
>> > +/* Find lowest freq at or above target in a table in ascending order */
>> > +static inline int cpufreq_table_find_index_al(struct cpufreq_policy *policy,
>> > +                                         unsigned int target_freq)
>> > +{
>> > +   struct cpufreq_frequency_table *table = policy->freq_table;
>> > +   unsigned int freq;
>> > +   int i, best = -1;
>> > +
>> > +   for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
>> > +           freq = table[i].frequency;
>> > +
>> > +           if (freq_is_invalid(policy, freq))
>> > +                   continue;
>> > +
>> > +           if (freq >= target_freq)
>> > +                   return i;
>> > +
>> > +           best = i;
>> > +   }
>> > +
>> > +   if (best == -1) {
>> > +           WARN(1, "Invalid frequency table: %d\n", policy->cpu);
>>
>> After a successful cpufreq_table_validate_and_show() that should be impossible,
>> shouldn't it?
>
> This shouldn't be possible unless cpufreq_table_validate_and_show() has a bug,
> or somehow that routine isn't called.

If it isn't called, the information on whether or not the table is
sorted may very well be bogus.

And it can double check the table right away to catch possible bugs
instead of running an additional if () every time a frequency is
selected.

> Though, to catch such bugs, what about WARN_ON(best == -1); ? The WARN() will
> have an unlikely() statement as well to optimize it and we can catch the bugs as
> well.
>
> Or if you think we should just remove them..

I would just drop those checks or do them once upfront.

>> > +/* Find highest freq at or below target in a table in descending order */
>> > +static inline int cpufreq_table_find_index_dh(struct cpufreq_policy *policy,
>> > +                                         unsigned int target_freq)
>> > +{
>> > +   struct cpufreq_frequency_table *table = policy->freq_table;
>> > +   unsigned int freq;
>> > +   int i, best = -1;
>> > +
>> > +   for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
>> > +           freq = table[i].frequency;
>> > +
>> > +           if (freq_is_invalid(policy, freq))
>> > +                   continue;
>> > +
>> > +           if (freq <= target_freq)
>> > +                   return i;
>> > +
>> > +           best = i;
>> > +   }
>> > +
>> > +   if (best == -1) {
>> > +           WARN(1, "Invalid frequency table: %d\n", policy->cpu);
>> > +           return -EINVAL;
>> > +   }
>> > +
>> > +   return best;
>> > +}
>>
>> I still don't see a reason for min/max checking in these routines.
>>
>> So what is the reason?
>
> These routines are all part of the existing API cpufreq_frequency_table_target()
> and that always had these checks.

Well, that's one of the reasons I've actively avoided that stuff in
the acpi-cpufreq's fast switch callback. :-)

> Over that, not all of its callers are ensuring
> that the target-freq is clamped before this routine is called. And so we need to
> make sure that these routines return a frequency between min/max only.
>
> What do you say ?

I think that the min/max checks at that level are just bogus, because
they are racy and that may lead to a situation where none of the
frequencies appears to be suitable while at least one of them must be.

So IMO all of the callers should be made clamp the target frequency
between min and max and those checks should be dropped from the
low-level helpers.

Thanks,
Rafael
