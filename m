From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv6 PATCH 07/10] sched/fair: jump to max OPP when crossing UP
 threshold
Date: Mon, 14 Dec 2015 18:42:08 -0800
Message-ID: <566F7E00.70505@linaro.org>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-8-git-send-email-smuckle@linaro.org>
 <20151211111250.GA8070@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35972 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbbLOCmL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2015 21:42:11 -0500
Received: by pfbu66 with SMTP id u66so71596484pfb.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2015 18:42:10 -0800 (PST)
In-Reply-To: <20151211111250.GA8070@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <Juri.Lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

Hi Juri,

On 12/11/2015 03:12 AM, Juri Lelli wrote:
>> @@ -2895,6 +2934,8 @@ void scheduler_tick(void)
>> >  	trigger_load_balance(rq);
>> >  #endif
>> >  	rq_last_tick_reset(rq);
>> > +
>> > +	sched_freq_tick(cpu);
> We are not holding rq->lock anymore at this points, and this collides
> with comment in update_cpu_capacity_request(). Can't you just move this
> up before raw_spin_unlock(&rq->lock)?

My thinking in putting it last was to have it after the possible
periodic load balance, so that we don't initiate a frequency change only
to have to modify the frequency again immediately afterwards.

Thinking more about it, the way we currently have the policy defined
there's no concern with having it earlier since sched_freq_tick only
causes the frequency to go to fmax (or do nothing). If we modify the
policy so that sched_freq_tick can cause arbitrary frequency changes
then I think this may need more thought.

thanks,
Steve
