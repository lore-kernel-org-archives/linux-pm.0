From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 5/5] cpufreq: schedutil: do not update rate limit ts when
 freq is unchanged
Date: Fri, 20 May 2016 13:39:48 +0200
Message-ID: <CAJZ5v0i5Ly1KyjmSC59jVTSxaShURgi=OAsn0nK3FTjFEz7NYg@mail.gmail.com>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
	<1462828814-32530-6-git-send-email-smuckle@linaro.org>
	<CAJZ5v0iwz3d6dxY-sUxbU8q1EzcO0gKX1pp-rDb8Www46Fg1uw@mail.gmail.com>
	<20160519194635.GG17223@graphite.smuckle.net>
	<CAJZ5v0gF07sox1+84eLeYPK6Ksj26s7iKU6zc=+pMOQimwUYog@mail.gmail.com>
	<20160519233408.GC15383@graphite.smuckle.net>
	<CAJZ5v0gL0xe7P7jZ=EZtFaSzE5n3ECa+tnTf0R2Th7xrB=9PgA@mail.gmail.com>
	<CAJZ5v0i0AGZVEYgJzDRVJHqCjAGDXhCeQ4gJBn77z_5cCh2Mqg@mail.gmail.com>
	<20160520004056.GE15383@graphite.smuckle.net>
	<CAJZ5v0gHYXsYrb5xGKZzFNP=QRvmah5uVDUAxjd1bFij2XznuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33956 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936AbcETLju (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 07:39:50 -0400
In-Reply-To: <CAJZ5v0gHYXsYrb5xGKZzFNP=QRvmah5uVDUAxjd1bFij2XznuA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>

On Fri, May 20, 2016 at 2:46 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, May 20, 2016 at 2:40 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
>> On Fri, May 20, 2016 at 02:37:17AM +0200, Rafael J. Wysocki wrote:
>>> Also I think that it would be good to avoid walking the frequency
>>> table twice in case we end up wanting to update the frequency after
>>> all.  With the [4/5] we'd do it once in get_next_freq() and then once
>>> more in cpufreq_driver_fast_switch(), for example, and walking the
>>> frequency table may be more expensive that doing the switch in the
>>> first place.
>>
>> If a driver API is added to return the platform frequency associated
>> with a target frequency, what do you think about requiring the
>> fast_switch API to take a target-supported frequency?
>
> That doesn't help much, because it generally would need to find a
> table entry corresponding to it anyway, to find the actual command
> value to write to a register, for example.
>
> But the driver could be smart and cache the value returned from the
> new callback along with the command value associated with it.  If
> invoked with that particular frequency, it would use the cached
> command.  Otherwise, it would walk the table.

It also makes sense to save both the "raw" value computed by
get_next_freq() and the corresponding "driver" value, because if the
current "raw" value is equal to the previous "raw" value, it shouldn't
be necessary to walk the frequency table at all (as the previous
"driver" value would then be equal to the current "driver" value too).

So maybe the "driver" value should only be checked after the "raw"
value check in sugov_update_commit() or equivalent?
