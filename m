From: Luca Abeni <luca.abeni@unitn.it>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in
 scale_rt_capacity
Date: Tue, 15 Dec 2015 14:18:11 +0100
Message-ID: <56701313.8000800@unitn.it>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org>
 <20151214151729.GQ6357@twins.programming.kicks-ass.net>
 <CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com>
 <20151214221231.39b5bc4e@luca-1225C>
 <CAKfTPtDT----aVGF-3T90PZQQvsOJay_Y-js19W+NNZpvk7J_w@mail.gmail.com>
 <566FD446.1080004@unitn.it>
 <20151215122015.GA6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35337 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405AbbLONSO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 08:18:14 -0500
Received: by mail-wm0-f49.google.com with SMTP id p66so90450399wmp.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2015 05:18:13 -0800 (PST)
In-Reply-To: <20151215122015.GA6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On 12/15/2015 01:20 PM, Peter Zijlstra wrote:
> On Tue, Dec 15, 2015 at 09:50:14AM +0100, Luca Abeni wrote:
>> On 12/15/2015 05:59 AM, Vincent Guittot wrote:
>
>>> The 2nd definition is used to compute the remaining capacity for the
>>> CFS scheduler. This one doesn't need to be updated at each wake/sleep
>>> of a deadline task but should reflect the capacity used by deadline in
>>> a larger time scale. The latter will be used by the CFS scheduler  at
>>> the periodic load balance pace
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
Ah, ok. Thanks for explaining.
So, I agree that this patch is not a good idea for estimating the average
utilisation needed by CFS.



				Luca
