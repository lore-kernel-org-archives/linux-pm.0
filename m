From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH] cpufreq: CPPC: Avoid overflow when calculating
 desired_perf
Date: Mon, 19 Sep 2016 12:54:14 -0600
Message-ID: <bcc4bd2a-d3b4-8000-ce27-dfeadb42271b@redhat.com>
References: <1473894508-22270-1-git-send-email-hotran@apm.com>
 <2037077.Sk8HnobN5X@vostro.rjw.lan>
 <CAFHUOYw+AP-LeqLTB9cbtCp+t_jUuA64Mh9DA0aU2C9-3P3MVQ@mail.gmail.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFHUOYw+AP-LeqLTB9cbtCp+t_jUuA64Mh9DA0aU2C9-3P3MVQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hoan Tran <hotran@apm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Prashanth Prakash <pprakash@codeaurora.org>, linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Loc Ho <lho@apm.com>, Duc Dang <dhdang@apm.com>
List-Id: linux-pm@vger.kernel.org

On 09/14/2016 09:06 PM, Hoan Tran wrote:
> Hi Rafael,
> 
> On Wed, Sep 14, 2016 at 5:50 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Wednesday, September 14, 2016 04:08:28 PM Hoan Tran wrote:
>>> This patch fixes overflow issue when calculating the desired_perf.
>>>
>>> Signed-off-by: Hoan Tran <hotran@apm.com>
>>> ---
>>>  drivers/cpufreq/cppc_cpufreq.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 894e465..3e0961e 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -84,7 +84,8 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>>>
>>>       cpu = all_cpu_data[policy->cpu];
>>>
>>> -     cpu->perf_ctrls.desired_perf = target_freq * policy->max / cppc_dmi_max_khz;
>>> +     cpu->perf_ctrls.desired_perf =
>>> +             (u64)target_freq * policy->max / cppc_dmi_max_khz;
>>>       freqs.old = policy->cur;
>>>       freqs.new = target_freq;
>>
>> That's on top of the CPPC material in linux-next I gather?
> 
> Yes, it's on TOP of linux-next.
> 
>>
>> Which commit does it fix?
> 
> This is a fix for ad38677df44b67e0f5b6c4d31e9c2734abde8ed9 (cpufreq:
> CPPC: Force reporting values in KHz to fix user space interface)
> http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/cpufreq/cppc_cpufreq.c?id=ad38677df44b67e0f5b6c4d31e9c2734abde8ed9
> 
> Thanks
> Hoan
> 
>>
>> Thanks,
>> Rafael
>>

Nice catch, Hoan.  Thanks!

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
