From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v7 1/2] cpufreq: schedutil: Make iowait boost more energy efficient
Date: Mon, 24 Jul 2017 11:37:58 -0700
Message-ID: <CAJWu+oriTd4bXaWo9LB2oUGHbVz11P__Cb20_=cndpjiwqyN7g@mail.gmail.com>
References: <20170723155426.9170-1-joelaf@google.com> <20170724085745.GU352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35286 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932119AbdGXSh7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2017 14:37:59 -0400
Received: by mail-oi0-f50.google.com with SMTP id e124so72743919oig.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2017 11:37:59 -0700 (PDT)
In-Reply-To: <20170724085745.GU352@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Andres Oportus <andresoportus@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

On Mon, Jul 24, 2017 at 1:57 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 23-07-17, 08:54, Joel Fernandes wrote:
>> Currently the iowait_boost feature in schedutil makes the frequency go to max
>> on iowait wakeups.  This feature was added to handle a case that Peter
>> described where the throughput of operations involving continuous I/O requests
>> [1] is reduced due to running at a lower frequency, however the lower
>> throughput itself causes utilization to be low and hence causing frequency to
>> be low hence its "stuck".
>>
>> Instead of going to max, its also possible to achieve the same effect by
>> ramping up to max if there are repeated in_iowait wakeups happening. This patch
>> is an attempt to do that. We start from a lower frequency (policy->min)
>> and double the boost for every consecutive iowait update until we reach the
>> maximum iowait boost frequency (iowait_boost_max).
>>
>> I ran a synthetic test (continuous O_DIRECT writes in a loop) on an x86 machine
>> with intel_pstate in passive mode using schedutil. In this test the iowait_boost
>> value ramped from 800MHz to 4GHz in 60ms. The patch achieves the desired improved
>> throughput as the existing behavior.
>>
>> [1] https://patchwork.kernel.org/patch/9735885/
>>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Signed-off-by: Joel Fernandes <joelaf@google.com>
>> ---
>>  kernel/sched/cpufreq_schedutil.c | 38 ++++++++++++++++++++++++++++++++------
>>  1 file changed, 32 insertions(+), 6 deletions(-)
>
> You Send V7 [1-2]/2 twice, Are they different ?

No they are the same. Rafael suggested reposting it with linux-pm in
CC I just resent it.

>
> For both the patches:
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!

-Joel
