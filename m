From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 7/7][Resend] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Wed, 30 Mar 2016 03:12:40 +0200
Message-ID: <CAJZ5v0jEueokR+bZJVRjQtmUe6BeKqUgnjWy9BZm4nGnKjT9mg@mail.gmail.com>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
	<6666532.7ULg06hQ7e@vostro.rjw.lan>
	<20160328090333.GK32495@vireshk-i7>
	<2253696.9jRPsKRmxz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:36434 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbcC3BMm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 21:12:42 -0400
In-Reply-To: <2253696.9jRPsKRmxz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Tue, Mar 29, 2016 at 2:58 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, March 28, 2016 02:33:33 PM Viresh Kumar wrote:
>> On 22-03-16, 02:54, Rafael J. Wysocki wrote:

[cut]

>> > +static unsigned int sugov_next_freq_shared(struct sugov_policy *sg_policy,
>> > +                                      unsigned long util, unsigned long max)
>> > +{
>> > +   struct cpufreq_policy *policy = sg_policy->policy;
>> > +   unsigned int max_f = policy->cpuinfo.max_freq;
>> > +   u64 last_freq_update_time = sg_policy->last_freq_update_time;
>> > +   unsigned int j;
>> > +
>> > +   if (util == ULONG_MAX)
>> > +           return max_f;
>> > +
>> > +   for_each_cpu(j, policy->cpus) {
>> > +           struct sugov_cpu *j_sg_cpu;
>> > +           unsigned long j_util, j_max;
>> > +           u64 delta_ns;
>> > +
>> > +           if (j == smp_processor_id())
>> > +                   continue;
>>
>> Why skip local CPU completely ?
>
> Because the original util and max come from it.
>
>> And if we really want to do that, what about something like for_each_cpu_and_not
>> to kill the unnecessary if {} statement ?
>
> That will work.

Except that for_each_cpu_and_not is not defined as of today.

I guess I can play with cpumasks, but then I'm not sure that will end
up actually more efficient.
