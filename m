From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: schedutil: Always trace frequency if it does not change
Date: Wed, 22 Mar 2017 18:13:21 +0100
Message-ID: <CAJZ5v0gpF_8qCW8Qtxr+MCpJwz9r+OHhMRvaG3QOYxYBFhw3Dg@mail.gmail.com>
References: <10655562.4O9KtquB0A@aspire.rjw.lan> <20170322092951.GX5680@worktop>
 <CAJZ5v0jFDQ9fxHwVWM_Dg-Or5y6o_YJ5=sdyQDZ3Dt0U2bqy_A@mail.gmail.com> <20170322142116.qpe2faqwbmlmhft7@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36319 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760279AbdCVRN2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 13:13:28 -0400
In-Reply-To: <20170322142116.qpe2faqwbmlmhft7@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>

On Wed, Mar 22, 2017 at 3:21 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Mar 22, 2017 at 01:52:04PM +0100, Rafael J. Wysocki wrote:
>> On Wed, Mar 22, 2017 at 10:29 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
>> > So why not fix the tools?
>>
>> Because I can't.
>>
>> I just can't go and fix all of the tools binaries that people use out
>> there and I want them to use recent kernels at the same time.
>>
>
> Thing is; you're now letting random tracepoint user dictate kernel
> implementation. That's a bad state to be in.

Fair enough.

Admittedly, I was sort of divided on whether or not to drop the
trace_cpu_frequency() call entirely and now I see another reason to do
that.  There is a change queued up for 4.12 that will cause the
tracepoint to be triggered more often totally in vain which I don't
think is a good thing at all.  So I'll send a v2 dropping that call
and we'll see if anyone complains.
