From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/5] cpufreq: schedutil: support scheduler cpufreq
 callbacks on remote CPUs
Date: Fri, 20 May 2016 01:14:56 +0200
Message-ID: <CAJZ5v0hCqGq_Q73ioVjFs-nYj60BbUOaYJ42_s_n4N+YZDgdmA@mail.gmail.com>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
	<1462828814-32530-3-git-send-email-smuckle@linaro.org>
	<CAJZ5v0jcFNdYMXdaBDaTzyxCaPn9=q2YxUMqziEaprwiOm=5dA@mail.gmail.com>
	<20160519184055.GD17223@graphite.smuckle.net>
	<CAJZ5v0jt6r38kiAE=Qf3y8vpquMdQnnLEDqjg2v7QoKgKzOcuw@mail.gmail.com>
	<20160519225939.GA15383@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34476 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492AbcESXO6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 19:14:58 -0400
In-Reply-To: <20160519225939.GA15383@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>

On Fri, May 20, 2016 at 12:59 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> On Thu, May 19, 2016 at 10:55:23PM +0200, Rafael J. Wysocki wrote:
>> >> > +static inline bool sugov_queue_remote_callback(struct sugov_policy *sg_policy,
>> >> > +                                        int cpu)
>> >> > +{
>> >> > +       struct cpufreq_policy *policy = sg_policy->policy;
>> >> > +
>> >> > +       if (!cpumask_test_cpu(smp_processor_id(), policy->cpus)) {
>> >>
>> >> This check is overkill for policies that aren't shared (and we have a
>> >> special case for them already).
>> >
>> > I don't see why it is overkill -
>>
>> Because it requires more computation, memory accesses etc than simply
>> comparing smp_processor_id() with cpu.
>
> Do you have a preference on how to restructure this?

Not really.

> Otherwise I'll create a second version of sugov_update_commit, factoring out as much of
> it as I can into two inline sub-functions.

I guess in that case it might be better to fold the
sugov_update_commit() code into its callers and then factor out common
stuff into sub-functions called from there.
