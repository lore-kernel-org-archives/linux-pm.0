From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in scale_rt_capacity
Date: Tue, 15 Dec 2015 13:46:53 +0100
Message-ID: <CAKfTPtC5xNG3nJ6BJnTwcd2sxz_ctZkzWHXMBcfRKov7m=ePjg@mail.gmail.com>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org> <20151214151729.GQ6357@twins.programming.kicks-ass.net>
 <CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com>
 <20151214221231.39b5bc4e@luca-1225C> <CAKfTPtDT----aVGF-3T90PZQQvsOJay_Y-js19W+NNZpvk7J_w@mail.gmail.com>
 <566FD446.1080004@unitn.it> <20151215122015.GA6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34963 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbbLOMrO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 07:47:14 -0500
Received: by mail-lf0-f47.google.com with SMTP id l133so5492177lfd.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2015 04:47:13 -0800 (PST)
In-Reply-To: <20151215122015.GA6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Luca Abeni <luca.abeni@unitn.it>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On 15 December 2015 at 13:20, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Dec 15, 2015 at 09:50:14AM +0100, Luca Abeni wrote:
>> On 12/15/2015 05:59 AM, Vincent Guittot wrote:
>
>> >The 2nd definition is used to compute the remaining capacity for the
>> >CFS scheduler. This one doesn't need to be updated at each wake/sleep
>> >of a deadline task but should reflect the capacity used by deadline in
>> >a larger time scale. The latter will be used by the CFS scheduler  at
>> >the periodic load balance pace
>
>> Ok, so as I wrote above this really looks like an average utilisation.
>> My impression (but I do not know the CFS code too much) is that the mainline
>> kernel is currently doing the right thing to compute it, so maybe there is no
>> need to change the current code in this regard.
>> If the current code is not acceptable for some reason, an alternative would
>> be to measure the active utilisation for frequency scaling, and then apply a
>> low-pass filter to it for CFS.
>
> So CFS really only needs a 'vague' average idea on how much time it will
> not get. Its best effort etc., so being a little wrong isn't a problem.
>
> The current code suffices, but I think the reason its been changed in
> this series is that they want/need separate tracking for fifo/rr and
> deadline in the next patch, and taking out deadline like proposed was
> the easiest way of achieving that.

yes. you're right. The goal was to minimize the overhead for tracking
separately  fifo/rr and deadline.


>
>
