From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 1/2] sched/fair: move cpufreq hook to update_cfs_rq_load_avg()
Date: Thu, 31 Mar 2016 11:50:40 +0200
Message-ID: <CAKfTPtCuDQz8KxndwA1Kx4Xe-DohuUOhYXXabBDsp7r8j6cPgw@mail.gmail.com>
References: <1458606068-7476-1-git-send-email-smuckle@linaro.org>
 <56F91D56.4020007@arm.com> <56F95D10.4070400@linaro.org> <56F97856.4040804@arm.com>
 <56F98832.3030207@linaro.org> <20160330193544.GD407@worktop>
 <CAKfTPtCPfd2-jGDn-9ZLjNKTni4czuvrkH7KFh5L2EtDeTQE5A@mail.gmail.com> <20160331093408.GB12845@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33985 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbcCaJvH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 05:51:07 -0400
Received: by mail-lf0-f52.google.com with SMTP id c62so55581913lfc.1
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2016 02:51:01 -0700 (PDT)
In-Reply-To: <20160331093408.GB12845@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On 31 March 2016 at 11:34, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Mar 31, 2016 at 11:27:22AM +0200, Vincent Guittot wrote:
>> On 30 March 2016 at 21:35, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Mon, Mar 28, 2016 at 12:38:26PM -0700, Steve Muckle wrote:
>> >> Without covering all the paths where CFS utilization changes it's
>> >> possible to have to wait up to a tick to act on some changes, since the
>> >> tick is the only guaranteed regularly-occurring instance of the hook.
>> >> That's an unacceptable amount of latency IMO...
>> >
>> > Note that even with your patches that might still be the case. Remote
>> > wakeups might not happen on the destination CPU at all, so it might not
>> > be until the next tick (which always happens locally) that we'll
>> > 'observe' the utilization change brought with the wakeups.
>> >
>> > We could force all the remote wakeups to IPI the destination CPU, but
>> > that comes at a significant performance cost.
>>
>> Isn't a reschedule ipi already sent in this case ?
>
> In what case? Assuming you talk about a remove wakeup, no. Only if that
> wakeup results in a preemption, which isn't a given.

yes, i was speaking about a remote wakeup.
In the ttwu_queue_remote,  there is a call to smp_send_reschedule. Is
there another way to add a remote task in the wake list ?

>
> And we really don't want to carry the 'has util increased' information
> all the way down to where we make that decision.

yes i agree
