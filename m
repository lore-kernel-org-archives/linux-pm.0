From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 5/5] cpufreq: schedutil: do not update rate limit ts when
 freq is unchanged
Date: Fri, 20 May 2016 02:37:17 +0200
Message-ID: <CAJZ5v0i0AGZVEYgJzDRVJHqCjAGDXhCeQ4gJBn77z_5cCh2Mqg@mail.gmail.com>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
	<1462828814-32530-6-git-send-email-smuckle@linaro.org>
	<CAJZ5v0iwz3d6dxY-sUxbU8q1EzcO0gKX1pp-rDb8Www46Fg1uw@mail.gmail.com>
	<20160519194635.GG17223@graphite.smuckle.net>
	<CAJZ5v0gF07sox1+84eLeYPK6Ksj26s7iKU6zc=+pMOQimwUYog@mail.gmail.com>
	<20160519233408.GC15383@graphite.smuckle.net>
	<CAJZ5v0gL0xe7P7jZ=EZtFaSzE5n3ECa+tnTf0R2Th7xrB=9PgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37007 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755342AbcETAhT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 20:37:19 -0400
In-Reply-To: <CAJZ5v0gL0xe7P7jZ=EZtFaSzE5n3ECa+tnTf0R2Th7xrB=9PgA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>

On Fri, May 20, 2016 at 2:24 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, May 20, 2016 at 1:34 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
>> On Thu, May 19, 2016 at 11:15:52PM +0200, Rafael J. Wysocki wrote:
>>> But anyway this change again seems to be an optimization that might be
>>> done later to me.
>>>
>>> I guess there are many things that might be optimized in schedutil,
>>> but I'd prefer to address one item at a time, maybe going after the
>>> ones that appear most relevant first?
>>
>> Calling the last two patches in this series optimizations is a stretch
>> IMO. Issuing frequency change requests that result in the same
>> target-supported frequency is clearly unnecessary and ends up delaying
>> more urgent frequency changes, which I think is more like a bug.
>
> The [4/5] is pulling stuff where it doesn't belong.  Simple as that.
> Frequency tables don't belong in schedutil, so don't pull them in
> there.
>
> If you want to do that cleanly, add a call to the driver that will
> tell you what frequency would be selected by it if it were given a
> particular target.

Also I think that it would be good to avoid walking the frequency
table twice in case we end up wanting to update the frequency after
all.  With the [4/5] we'd do it once in get_next_freq() and then once
more in cpufreq_driver_fast_switch(), for example, and walking the
frequency table may be more expensive that doing the switch in the
first place.
