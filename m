From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 4/8] cpufreq/schedutil: sysfs capacity margin tunable
Date: Wed, 16 Mar 2016 15:05:06 -0700
Message-ID: <20160316220506.11016.7525@quark.deferred.io>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-5-git-send-email-mturquette+renesas@baylibre.com>
 <20160315212047.GE6344@twins.programming.kicks-ass.net>
 <20160315214043.30639.75507@quark.deferred.io>
 <20160315214821.GM6344@twins.programming.kicks-ass.net>
 <20160315223701.30639.43127@quark.deferred.io> <56E8D4D9.1060202@linaro.org>
 <20160316080503.GS6344@twins.programming.kicks-ass.net>
 <20160316100257.GC18212@e106622-lin> <56E99E25.9070002@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32854 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965441AbcCPWFM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 18:05:12 -0400
Received: by mail-pf0-f182.google.com with SMTP id 124so91397835pfg.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 15:05:12 -0700 (PDT)
In-Reply-To: <56E99E25.9070002@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>, Patrick Bellasi <patrick.bellasi@arm.com>

Quoting Steve Muckle (2016-03-16 10:55:49)
> On 03/16/2016 03:02 AM, Juri Lelli wrote:
> > Hi,
> > 
> > On 16/03/16 09:05, Peter Zijlstra wrote:
> >> On Tue, Mar 15, 2016 at 08:36:57PM -0700, Steve Muckle wrote:
> >>>> Then again, maybe this knob will be part of the mythical
> >>>> power-vs-performance slider?
> >>>
> >>> Patrick Bellasi's schedtune series [0] (which I think is the referenced
> >>> mythical slider) aims to provide a more sophisticated interface for
> >>> tuning scheduler-driven frequency selection. In addition to a global
> >>> boost value it includes a cgroup controller as well for per-task tuning.
> >>>
> >>> I would definitely expect the margin/boost value to be modified at
> >>> runtime, for example if the battery is running low, or the user wants
> >>> 100% performance for a while, or the userspace framework wants to
> >>> temporarily tailor the performance level for a particular set of tasks, etc.
> >>
> >> OK, so how about we start with it as a debug knob, and once we have
> >> experience and feel like it is indeed a useful runtime knob, we upgrade
> >> it to ABI.
> >>
> > 
> > I tend to agree here. To me the margin is something that we need to make
> > this thing work and to get acceptable performance out of the box. So we
> > can play with it while debugging, but I consider the schedtune slider as
> > the way to tune the system at runtime.
> 
> Could the default schedtune value not serve as the out of the box margin?

It can. Let's keep the kernel interfaces in patch #2 for changing the
margin/threshold, and schedtune can call these interfaces.

Regards,
Mike

> 
> Regardless I agree that a debug interface is the way to go for now while
> we figure things out.
> 
