From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in
 scale_rt_capacity
Date: Tue, 15 Dec 2015 13:41:44 +0100
Message-ID: <20151215124144.GD6357@twins.programming.kicks-ass.net>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org>
 <20151214151729.GQ6357@twins.programming.kicks-ass.net>
 <CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com>
 <20151214165128.GU6357@twins.programming.kicks-ass.net>
 <CAKfTPtCRGuWY8aXCKVHumM3nLODsWm55ZHhkBm4v5HzPEn+J_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56936 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685AbbLOMlu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 07:41:50 -0500
Content-Disposition: inline
In-Reply-To: <CAKfTPtCRGuWY8aXCKVHumM3nLODsWm55ZHhkBm4v5HzPEn+J_g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Luca Abeni <luca.abeni@unitn.it>

On Tue, Dec 15, 2015 at 05:43:44AM +0100, Vincent Guittot wrote:
> On 14 December 2015 at 17:51, Peter Zijlstra <peterz@infradead.org> wrote:

> > No, since the WCET can and _will_ happen, its the best you can do with
> > cpufreq. If you were to set it lower you could not be able to execute
> > correctly in your 'never' tail cases.
> 
> In the context of frequency scaling, This mean that we will never
> reach low frequency

Only if you've stuffed your machine full of deadline tasks, if you take
Luca's example of the I/B frame decoder thingy, then even the WCET for
the I frames should not be very much (albeit significantly more than B
frames).

So while the WCET is pessimistic compared to the avg case, most CPUs can
do video decoding without much effort at all, so even the WCET for the
I-frames might allow us to drop to the lowest cpufreq.

Now, if you were to decode 10 streams at the same time, different story
of course ;-)
