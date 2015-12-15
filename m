From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in
 scale_rt_capacity
Date: Tue, 15 Dec 2015 13:23:04 +0100
Message-ID: <20151215122304.GB6357@twins.programming.kicks-ass.net>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org>
 <20151214151729.GQ6357@twins.programming.kicks-ass.net>
 <CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com>
 <20151214221231.39b5bc4e@luca-1225C>
 <CAKfTPtDT----aVGF-3T90PZQQvsOJay_Y-js19W+NNZpvk7J_w@mail.gmail.com>
 <566FD446.1080004@unitn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45035 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857AbbLOMXM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 07:23:12 -0500
Content-Disposition: inline
In-Reply-To: <566FD446.1080004@unitn.it>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Luca Abeni <luca.abeni@unitn.it>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Tue, Dec 15, 2015 at 09:50:14AM +0100, Luca Abeni wrote:
> Strictly speaking, the active utilisation must be updated when a task
> wakes up and when a task sleeps/terminates (but when a task sleeps/terminates
> you cannot decrease the active utilisation immediately: you have to wait
> some time because the task might already have used part of its "future
> utilisation").
> The active utilisation must not be updated when a task is throttled: a
> task is throttled when its current runtime is 0, so it already used all
> of its utilisation for the current period (think about two tasks with
> runtime=50ms and period 100ms: they consume 100% of the time on a CPU,
> and when the first task consumed all of its runtime, you cannot decrease
> the active utilisation).

Hehe, this reminds me of the lag tracking in EEVDF/WF2Q/BFQ etc., that
had similar issues.
