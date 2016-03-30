From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Update][PATCH v7 7/7] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Wed, 30 Mar 2016 19:24:04 +0200
Message-ID: <CAJZ5v0gztvG4u=euSA0W+3Pt4dPZ58JCSJPTCbXvfVt_Zid38Q@mail.gmail.com>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
	<6666532.7ULg06hQ7e@vostro.rjw.lan>
	<145931680.Kk1xSBT0Ro@vostro.rjw.lan>
	<20160330053011.GF8773@vireshk-i7>
	<CAJZ5v0iB_7zZSu5-H-px7NYiaZ_P6DW3dqx-bKs7eohWudwxvQ@mail.gmail.com>
	<56FC0773.6060605@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:36746 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072AbcC3RYM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 13:24:12 -0400
In-Reply-To: <56FC0773.6060605@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Wed, Mar 30, 2016 at 7:05 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
> On 03/30/2016 04:31 AM, Rafael J. Wysocki wrote:
>>>> >> +static int sugov_limits(struct cpufreq_policy *policy)
>>>> >> +{
>>>> >> +     struct sugov_policy *sg_policy = policy->governor_data;
>>>> >> +
>>>> >> +     if (!policy->fast_switch_enabled) {
>>>> >> +             mutex_lock(&sg_policy->work_lock);
>>>> >> +
>>>> >> +             if (policy->max < policy->cur)
>>>> >> +                     __cpufreq_driver_target(policy, policy->max,
>>>> >> +                                             CPUFREQ_RELATION_H);
>>>> >> +             else if (policy->min > policy->cur)
>>>> >> +                     __cpufreq_driver_target(policy, policy->min,
>>>> >> +                                             CPUFREQ_RELATION_L);
>>>> >> +
>>>> >> +             mutex_unlock(&sg_policy->work_lock);
>>>> >> +     }
>>>> >> +
>>>> >> +     sg_policy->need_freq_update = true;
>>> >
>>> > I am wondering why we need to do this for !fast_switch_enabled case?
>>
>> That will cause the rate limit to be ignored in the utilization update
>> handler which may be necessary if it is set to a relatively large
>> value (like 1 s).
>
> But why is that necessary for !fast_switch_enabled? In that case the
> frequency has been adjusted to satisfy the new limits here, so ignoring
> the rate limit shouldn't be necessary. In other words why not
>
> } else {
>         sg_policy->need_freq_update = true;
> }

My thinking here was that the governor might decide to use something
different from the limit enforced here, so it would be good to make it
do so as soon as possible.  In particular in the
non-frequency-invariant utilization case in which new frequency
depends on the current one.

That said i'm not particularly opposed to making that change if that's
preferred.

Thanks,
Rafael
