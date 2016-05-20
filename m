From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 5/5] cpufreq: schedutil: do not update rate limit ts when
 freq is unchanged
Date: Fri, 20 May 2016 02:24:19 +0200
Message-ID: <CAJZ5v0gL0xe7P7jZ=EZtFaSzE5n3ECa+tnTf0R2Th7xrB=9PgA@mail.gmail.com>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
	<1462828814-32530-6-git-send-email-smuckle@linaro.org>
	<CAJZ5v0iwz3d6dxY-sUxbU8q1EzcO0gKX1pp-rDb8Www46Fg1uw@mail.gmail.com>
	<20160519194635.GG17223@graphite.smuckle.net>
	<CAJZ5v0gF07sox1+84eLeYPK6Ksj26s7iKU6zc=+pMOQimwUYog@mail.gmail.com>
	<20160519233408.GC15383@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36545 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868AbcETAYV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 20:24:21 -0400
In-Reply-To: <20160519233408.GC15383@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>

On Fri, May 20, 2016 at 1:34 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> On Thu, May 19, 2016 at 11:15:52PM +0200, Rafael J. Wysocki wrote:
>> But anyway this change again seems to be an optimization that might be
>> done later to me.
>>
>> I guess there are many things that might be optimized in schedutil,
>> but I'd prefer to address one item at a time, maybe going after the
>> ones that appear most relevant first?
>
> Calling the last two patches in this series optimizations is a stretch
> IMO. Issuing frequency change requests that result in the same
> target-supported frequency is clearly unnecessary and ends up delaying
> more urgent frequency changes, which I think is more like a bug.

The [4/5] is pulling stuff where it doesn't belong.  Simple as that.
Frequency tables don't belong in schedutil, so don't pull them in
there.

If you want to do that cleanly, add a call to the driver that will
tell you what frequency would be selected by it if it were given a
particular target.

I actually do agree with the direction of it and the [5/5], but I
don't like cutting corners. :-)

> These patches are also needed in conjunction with the first three to address
> the remote wakeup delay.

Well, does this mean that without the [4-5/5] the rest of the series
doesn't provide as much benefit as initially expected?

> Are there specific items you want to see addressed before these patches could go in?

Do you mean in addition to what I already said in my comments?

> I'm aware of the RT/DL support that needs improving, though
> that should be orthogonal.
>
> Also if it helps, I can provide a test case and/or traces to show the
> need for the last two patches.

Yes, that will help.

Thanks,
Rafael
