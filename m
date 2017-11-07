From: Chris Redpath <chris.redpath@arm.com>
Subject: Re: [PATCH v3] cpufreq: schedutil: Examine the correct CPU when we
 update util
Date: Tue, 7 Nov 2017 09:49:58 +0000
Message-ID: <65a16c84-d25f-26ce-b4cf-5edc3f9b6d32@arm.com>
References: <20171103034022.GD4240@vireshk-i7>
 <20171103133642.8636-1-chris.redpath@arm.com>
 <20171103154559.GJ4240@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:46776
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752039AbdKGJuE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Nov 2017 04:50:04 -0500
In-Reply-To: <20171103154559.GJ4240@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

Hi Viresh, Rafael,

Without this patch, schedutil is totally broken for us - is
there any chance at all this could go in 4.14 or is it just
too late?

Best Regards,
Chris

On 03/11/17 15:45, Viresh Kumar wrote:
> On 03-11-17, 13:36, Chris Redpath wrote:
>> After
>> 674e75411fc2 ("sched: cpufreq: Allow remote cpufreq callbacks")
>>
>> We stopped always reading utilization for the cpu we are running
>> the governor on, and instead read it for the cpu which we've been
>> told has updated utilization. This is stored in sugov_cpu->cpu.
>>
>> The value is set in sugov_register but we clear it in sugov_start
>> which leads to always looking at the utilization of CPU0 instead
>> of the correct one.
>>
>> Let's fix this by consolidating the initialization code into
>> sugov_start().
>>
>> Fixes: 674e75411fc2 ("sched: cpufreq: Allow remote cpufreq callbacks")
>> Signed-off-by: Chris Redpath <chris.redpath@arm.com>
>> Reviewed-by: Patrick Bellasi <patrick.bellasi@arm.com>
>> Reviewed-by: Brendan Jackman <brendan.jackman@arm.com>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> ---
>>   kernel/sched/cpufreq_schedutil.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
