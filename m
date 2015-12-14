From: Luca Abeni <luca.abeni@unitn.it>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in
 scale_rt_capacity
Date: Mon, 14 Dec 2015 15:38:53 +0100
Message-ID: <566ED47D.6030504@unitn.it>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org>
 <CAKfTPtCV4d=1nSDcU8J4x=MF7HmuyRxKr-4XiYAxPZYPKd1okA@mail.gmail.com>
 <56697DCB.5050800@unitn.it>
 <CAKfTPtC2bcdO=KKxsF71fF8tMtAxhR8OZQpqZ0m0ce-D=nnNfQ@mail.gmail.com>
 <566A7FD2.4050601@unitn.it>
 <CAKfTPtBBaZ2Dv83Hp7Jfz==pymzaYSixEBi2VDbhZbmgZRYOLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33832 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbbLNOi5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2015 09:38:57 -0500
Received: by mail-wm0-f41.google.com with SMTP id p66so65114717wmp.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2015 06:38:56 -0800 (PST)
In-Reply-To: <CAKfTPtBBaZ2Dv83Hp7Jfz==pymzaYSixEBi2VDbhZbmgZRYOLA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On 12/14/2015 03:02 PM, Vincent Guittot wrote:
[...]
>>>> Small nit: why "average" utilization? I think a better name would be
>>>> "runqueue utilization"
>>>> or "local utilization", or something similar... If I understand correctly
>>>> (sorry if I
>>>> missed something), this is not an average, but the sum of the
>>>> utilisations
>>>> of the tasks
>>>> on this runqueue... No?
>>>
>>>
>>> I have used "average" because it doesn't reflect the active/actual
>>> utilization of the run-queue but the forecasted average bandwidth of
>>> the CPU that will be used by deadline task.
>>
>> Well, this is just nitpicking, so feel free to ignore (I just mentioned
>> this point because I was initially confused by the "average" name). But I
>> think this is "maximum", or "worst-case", not "average", because (as far
>> as I can understand) this field indicates that SCHED_DEADLINE tasks will
>> not be able to consume more than this fraction of CPU (if they try to
>> consume more, the scheduler throttles them).
>>
>>> I'm open to change the name if another one makes more sense
>>
>> In real-time literature this is often called simply "utilization" (or
>> "worst-case
>> utilization" by someone): when a task can have a variable execution time,
>> its
>> utilization is defined as WCET (maximum execution time) / period.
>
> ok. Let follow real-time literature wording and remove "average" to
> keep only utilization.
> so the variable will be named:
>
> s64 util_bw;
Well, "utilization" and "bandwidth" are often used to indicate the same
quantity, so "util_bw" sounds strange. I'd call it simply "utilization" or
"bandwidth" (otherwise, just leave the name as it is... I said this is just
nitpicking).



				Luca
