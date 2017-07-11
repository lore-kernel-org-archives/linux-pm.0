From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v2 2/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Tue, 11 Jul 2017 12:16:51 -0700
Message-ID: <59652423.8000806@codeaurora.org>
References: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com> <1499189651-18797-3-git-send-email-patrick.bellasi@arm.com> <CAJWu+opGK6GTFiLoH9jSicnAx08Je9FoGevRmAk+Bfned42ncA@mail.gmail.com> <20170707101704.qncj373s3eliit2y@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42016 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932802AbdGKTQy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 15:16:54 -0400
In-Reply-To: <20170707101704.qncj373s3eliit2y@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Joel Fernandes <joelaf@google.com>, Patrick Bellasi <patrick.bellasi@arm.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Andres Oportus <andresoportus@google.com>, Todd Kjos <tkjos@android.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

On 07/07/2017 03:17 AM, Juri Lelli wrote:
> On 06/07/17 21:43, Joel Fernandes wrote:
>> On Tue, Jul 4, 2017 at 10:34 AM, Patrick Bellasi
>> <patrick.bellasi@arm.com> wrote:
>
> [...]
>
>>> @@ -304,6 +304,12 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>>>
>>>          sg_cpu->util = util;
>>>          sg_cpu->max = max;
>>> +
>>> +       /* CPU is entering IDLE, reset flags without triggering an update */
>>> +       if (unlikely(flags & SCHED_CPUFREQ_IDLE)) {
>>> +               sg_cpu->flags = 0;
>>> +               goto done;
>>> +       }
>>
>> Instead of defining a new flag for idle, wouldn't another way be to
>> just clear the flag from the RT scheduling class with an extra call to
>> cpufreq_update_util with flags = 0 during dequeue_rt_entity? That
>> seems to me to be also the right place to clear the flag since the
>> flag is set in the corresponding class to begin with.
>>
>
> Make sense to me too. Also considering that for DL (with my patches) we
> don't generally want to clear the flag at dequeue time, but only when
> the 0-lag timer fires.
>

Makes sense to me too.

-Saravana


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
