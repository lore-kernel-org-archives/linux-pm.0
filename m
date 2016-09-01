From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 2/2] sched: cpufreq: use rt_avg as estimate of required
 RT CPU capacity
Date: Thu, 1 Sep 2016 14:48:51 -0700
Message-ID: <20160901214851.GP5599@graphite.smuckle.net>
References: <1472236848-17038-1-git-send-email-smuckle@linaro.org>
 <1472236848-17038-3-git-send-email-smuckle@linaro.org>
 <20160831143907.GX10121@twins.programming.kicks-ass.net>
 <20160831150846.GN5599@graphite.smuckle.net>
 <alpine.DEB.2.20.1608311812040.5647@nanos>
 <20160831164009.GF10153@twins.programming.kicks-ass.net>
 <20160831170002.GK9337@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33567 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753943AbcIAVsz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Sep 2016 17:48:55 -0400
Received: by mail-pf0-f178.google.com with SMTP id g202so12143489pfb.0
        for <linux-pm@vger.kernel.org>; Thu, 01 Sep 2016 14:48:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160831170002.GK9337@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <Juri.Lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On Wed, Aug 31, 2016 at 06:00:02PM +0100, Juri Lelli wrote:
> > Another problem is that we have many semi related knobs; we have the
> > global RT runtime limit knob, but that doesn't affect cpufreq (maybe it
> > should)
> 
> Maybe we could create this sort of link when using the cgroup RT
> throttling interface as well? It should still then fit well once we
> replace the underlying mechanism with DL reservations. And, AFAIK, the
> interface is used by Android folks already.

I'm not sure how the upper bounds can be used to infer CPU frequency...
On my Nexus 6p (an Android device), the global RT runtime limit
seems to be set at 950ms/1sec, the root cgroup is set to 800ms/1sec, and
bg_non_interactive is set at 700ms/1sec.

