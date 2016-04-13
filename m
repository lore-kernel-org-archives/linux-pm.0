From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 1/2] sched/fair: move cpufreq hook to
 update_cfs_rq_load_avg()
Date: Wed, 13 Apr 2016 11:06:07 -0700
Message-ID: <570E8A8F.2030109@linaro.org>
References: <56F97856.4040804@arm.com> <56F98832.3030207@linaro.org>
 <20160330193544.GD407@worktop> <56FC807C.80204@linaro.org>
 <20160331073743.GF3408@twins.programming.kicks-ass.net>
 <56FD95EE.6090007@linaro.org>
 <20160401092019.GN3430@twins.programming.kicks-ass.net>
 <570BFAE2.4080301@linaro.org>
 <CAJZ5v0imtij-smQBds1aTNMuFsNbbzvoyAJ5-=Pp8Ae1GSNWvQ@mail.gmail.com>
 <CAJZ5v0gNt5kMV8jjQuASTxUBE=FZ45x2Go0RNsyaZMLk+dAsKQ@mail.gmail.com>
 <20160413000824.GB22643@graphite.smuckle.net>
 <CAJZ5v0hx6mG5EzU4q-OFxcKQP3CZcY+H_+PqYVfL4aAPkxmoDA@mail.gmail.com>
 <CAJZ5v0jKkKrSWhtbcWcFbLrOT8kUKCfJV05W4vQwUHbD5omGpA@mail.gmail.com>
 <CAJZ5v0hSBZaw=p2vR1PFnU9naoQ-KJUxznVfB=AasG0GnfTakA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33296 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898AbcDMSGK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2016 14:06:10 -0400
Received: by mail-pf0-f181.google.com with SMTP id 184so37449700pff.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2016 11:06:09 -0700 (PDT)
In-Reply-To: <CAJZ5v0hSBZaw=p2vR1PFnU9naoQ-KJUxznVfB=AasG0GnfTakA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On 04/13/2016 09:07 AM, Rafael J. Wysocki wrote:
>>>>> If you want to do remote updates, I guess that will require an
>>>>> irq_work to run the update on the target CPU, but then you'll probably
>>>>> want to neglect the rate limit on it as well, so it looks like a
>>>>> "need_update" flag in struct update_util_data will be useful for that.

Have you added rate limiting at the hook level that I missed? I thought
it was just inside schedutil.

>>>>
>>>> Why is it required to run the update on the target CPU?
>>>
>>> The fast switching and intel_pstate are the main reason.
>>>
>>> They both have to write to registers of the target CPU and the code to
>>> do that needs to run on that CPU.

Ok thanks, I'll take another look at this.

I was thinking it might be nice to be able to push the decision on
whether to send the IPI in to the governor/hook client. For example in
the schedutil case, you don't need to IPI if sugov_should_update_freq()
= false (outside the slight chance it might be true when it runs on the
target). Beyond that perhaps for policy reasons it's desired to not send
the IPI if next_freq <= cur_freq, etc.

>> And these two seem to be the only interesting cases for you, because
>> if you need to work for the worker thread to schedule to eventually
> 
> s/work/wait/ (sorry)
> 
>> change the CPU frequency for you, that will defeat the whole purpose
>> here.

I was hoping to submit at some point a patch to change the context for
slow path frequency changes to RT or DL context, so this would benefit
that case as well.

thanks,
steve
