From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 5/5] cpufreq: schedutil: do not update rate limit ts when
 freq is unchanged
Date: Thu, 19 May 2016 17:37:47 -0700
Message-ID: <20160520003747.GD15383@graphite.smuckle.net>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
 <1462828814-32530-6-git-send-email-smuckle@linaro.org>
 <CAJZ5v0iwz3d6dxY-sUxbU8q1EzcO0gKX1pp-rDb8Www46Fg1uw@mail.gmail.com>
 <20160519194635.GG17223@graphite.smuckle.net>
 <CAJZ5v0gF07sox1+84eLeYPK6Ksj26s7iKU6zc=+pMOQimwUYog@mail.gmail.com>
 <20160519233408.GC15383@graphite.smuckle.net>
 <CAJZ5v0gL0xe7P7jZ=EZtFaSzE5n3ECa+tnTf0R2Th7xrB=9PgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36762 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbcETAhw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 20:37:52 -0400
Received: by mail-pf0-f181.google.com with SMTP id c189so36367795pfb.3
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 17:37:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gL0xe7P7jZ=EZtFaSzE5n3ECa+tnTf0R2Th7xrB=9PgA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>

On Fri, May 20, 2016 at 02:24:19AM +0200, Rafael J. Wysocki wrote:
> On Fri, May 20, 2016 at 1:34 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> > On Thu, May 19, 2016 at 11:15:52PM +0200, Rafael J. Wysocki wrote:
> >> But anyway this change again seems to be an optimization that might be
> >> done later to me.
> >>
> >> I guess there are many things that might be optimized in schedutil,
> >> but I'd prefer to address one item at a time, maybe going after the
> >> ones that appear most relevant first?
> >
> > Calling the last two patches in this series optimizations is a stretch
> > IMO. Issuing frequency change requests that result in the same
> > target-supported frequency is clearly unnecessary and ends up delaying
> > more urgent frequency changes, which I think is more like a bug.
> 
> The [4/5] is pulling stuff where it doesn't belong.  Simple as that.
> Frequency tables don't belong in schedutil, so don't pull them in
> there.
> 
> If you want to do that cleanly, add a call to the driver that will
> tell you what frequency would be selected by it if it were given a
> particular target.
> 
> I actually do agree with the direction of it and the [5/5], but I
> don't like cutting corners. :-)

Okay sure, makes sense and I'll work on a change to do that.

> 
> > These patches are also needed in conjunction with the first three to address
> > the remote wakeup delay.
> 
> Well, does this mean that without the [4-5/5] the rest of the series
> doesn't provide as much benefit as initially expected?

At least in my testing the last two patches were required to show the
improvement with the unit test I had developed. This is because all the
minor system activity would keep pushing the rate limit out so when the
remote cb came in it had no effect.

So the last two patches aren't a hard requirement to theoretically solve
the problem but in practice I don't think a benefit will be seen without
them.

> > Are there specific items you want to see addressed before these patches could go in?
> 
> Do you mean in addition to what I already said in my comments?

I was referring to the other possible optimizations/changes you
mentioned in schedutil that might serve as cause to defer these patches.

> 
> > I'm aware of the RT/DL support that needs improving, though
> > that should be orthogonal.
> >
> > Also if it helps, I can provide a test case and/or traces to show the
> > need for the last two patches.
> 
> Yes, that will help.

Okay I'll include a pointer to my unit test program and some trace data
in my next post.

thanks,
Steve
