From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH v2] cpufreq: CPPC: Correct desired_perf calculation
Date: Thu, 13 Oct 2016 14:21:18 -0700
Message-ID: <CAFHUOYyv9jdY8Zrqq-=ZYx_rG7zpHEc4qrnXCb3xP6KwJPG07g@mail.gmail.com>
References: <1476380015-21001-1-git-send-email-hotran@apm.com>
 <b027d9b7-67c5-68e7-d412-1f22edef34cc@codeaurora.org> <CAJZ5v0jiRwgRherPXDQoV8kCdDZrW-1sv4p92vs6zJiwn7f4tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jiRwgRherPXDQoV8kCdDZrW-1sv4p92vs6zJiwn7f4tQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Prakash, Prashanth" <pprakash@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Al Stone <ahs3@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Loc Ho <lho@apm.com>, Duc Dang <dhdang@apm.com>, Christopher Covington <cov@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 13, 2016 at 2:12 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Oct 13, 2016 at 9:37 PM, Prakash, Prashanth
> <pprakash@codeaurora.org> wrote:
>> On 10/13/2016 11:33 AM, Hoan Tran wrote:
>>> The desired_perf is an abstract performance number. Its value should
>>> be in the range of [lowest perf, highest perf] of CPPC.
>>> The correct calculation is
>>>   desired_perf = freq * cppc_highest_perf / cppc_dmi_max_khz
>>>
>>> And cppc_cpufreq_set_target() returns if desired_perf is exactly
>>> the same with the old perf.
>>>
>>> Signed-off-by: Hoan Tran <hotran@apm.com>
>> Reviewed-by: Prashanth Prakash <pprakash@codeaurora.org>
>>
>> Hi Rafael,
>> Can you please pick this one for 4.9, as it is bug fix?
>
> Sure, I will queue it up.
>

Thanks, Rafael and Prashanth !

Hoan

> Thanks,
> Rafael
