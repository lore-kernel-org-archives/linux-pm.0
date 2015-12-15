From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in scale_rt_capacity
Date: Tue, 15 Dec 2015 13:58:42 +0100
Message-ID: <CAKfTPtDY1OxMuGqVed_jvEpDjNThhptWmLPi6pi2aJCD+4dQRQ@mail.gmail.com>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org> <20151214151729.GQ6357@twins.programming.kicks-ass.net>
 <CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com>
 <20151214221231.39b5bc4e@luca-1225C> <CAKfTPtDT----aVGF-3T90PZQQvsOJay_Y-js19W+NNZpvk7J_w@mail.gmail.com>
 <566FD446.1080004@unitn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34565 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932266AbbLOM7F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 07:59:05 -0500
Received: by mail-lf0-f46.google.com with SMTP id y184so5769010lfc.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2015 04:59:03 -0800 (PST)
In-Reply-To: <566FD446.1080004@unitn.it>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Luca Abeni <luca.abeni@unitn.it>
Cc: Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On 15 December 2015 at 09:50, Luca Abeni <luca.abeni@unitn.it> wrote:
> On 12/15/2015 05:59 AM, Vincent Guittot wrote:
> [...]
>>>>>
>>>>> So I don't think this is right. AFAICT this projects the WCET as the
>>>>> amount of time actually used by DL. This will, under many
>>>>> circumstances, vastly overestimate the amount of time actually
>>>>> spend on it. Therefore unduly pessimisme the fair capacity of this
>>>>> CPU.
>>>>
>>>>

[snip]

>> The 2nd definition is used to compute the remaining capacity for the
>> CFS scheduler. This one doesn't need to be updated at each wake/sleep
>> of a deadline task but should reflect the capacity used by deadline in
>> a larger time scale. The latter will be used by the CFS scheduler  at
>> the periodic load balance pace
>
> Ok, so as I wrote above this really looks like an average utilisation.
> My impression (but I do not know the CFS code too much) is that the mainline
> kernel is currently doing the right thing to compute it, so maybe there is
> no
> need to change the current code in this regard.
> If the current code is not acceptable for some reason, an alternative would
> be to measure the active utilisation for frequency scaling, and then apply a
> low-pass filter to it for CFS.

In this case, it's probably easier to split what is already done into
a rt_avg metric  and a dl_avg metric

Vincent
>
>
>                                 Luca
>
>
>>
>>> As done, for example, here:
>>> https://github.com/lucabe72/linux-reclaiming/tree/track-utilisation-v2
>>> (in particular, see
>>>
>>> https://github.com/lucabe72/linux-reclaiming/commit/49fc786a1c453148625f064fa38ea538470df55b
>>> )
>>> I understand this approach might look too complex... But I think it is
>>> much less pessimistic while still being "safe".
>>> If there is something that I can do to make that code more acceptable,
>>> let me know.
>>>
>>>
>>>                          Luca
>
>
