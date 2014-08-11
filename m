From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v4 1/5] cpufreq: Don't wait for CPU to going offline to
 restart governor
Date: Mon, 11 Aug 2014 15:11:18 -0700
Message-ID: <53E93F86.5030304@codeaurora.org>
References: <CAKohpon=xWZJzfN0PceVntumAUFfCsbG1ibUwSxewB7bE=U7bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpon=xWZJzfN0PceVntumAUFfCsbG1ibUwSxewB7bE=U7bQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Todd Poynor <toddpoynor@google.com>, "Srivatsa S . Bhat" <srivatsa@mit.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 08/07/2014 01:54 AM, Viresh Kumar wrote:
> Sorry for the really long delay this time around. I am used to replying within a
> day normally, and this time it just took so much time.
>
> For next time please rebase on latest updates in pm/linux-next as there are
> few updates there.

Will do.

>
> On 25 July 2014 06:37, Saravana Kannan <skannan@codeaurora.org> wrote:
>> There's no need to wait for the CPU going down to fully go offline to
>> restart the governor. We can stop the governor, change policy->cpus and
>> immediately restart the governor. This should reduce the time without any
>> CPUfreq monitoring and also help future patches with simplifying the code.
>
> I agree with the idea here, though the $subject can be improved a bit
> here..

Suggestions welcome. I think the current one explains the main point of 
this change.

>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> ---
>>   drivers/cpufreq/cpufreq.c | 33 ++++++++++++++++++---------------
>>   1 file changed, 18 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 62259d2..ee0eb7b 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1390,6 +1390,21 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
>>                  cpufreq_driver->stop_cpu(policy);
>>          }
>>
>> +       down_write(&policy->rwsem);
>> +       cpumask_clear_cpu(cpu, policy->cpus);
>> +       up_write(&policy->rwsem);
>
> There is a down_read() present early in this routine and we better update this
> at that place only.

I would rather not. My v1 patch series was super refactored to allow a 
lot of reuse, etc. But you guys complained about the diffs being 
confusing (which was a valid point).

Also, if we are talking about refactoring this, there's room for much 
better refactor at the end of the series. I will add a patch to the 
series to do the refactoring.

>
>> +       if (cpus > 1 && has_target()) {
>
> We already have a if (cpus > 1) block, move this there.

That only runs if cpu != policy->cpu. This needs to run irrespective of 
that.

>
>> +               ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
>> +               if (!ret)
>> +                       ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
>> +
>> +               if (ret) {
>> +                       pr_err("%s: Failed to start governor\n", __func__);
>> +                       return ret;
>> +               }
>> +       }
>> +
>>          return 0;
>>   }
>>
>> @@ -1410,15 +1425,12 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
>>                  return -EINVAL;
>>          }
>>
>> -       down_write(&policy->rwsem);
>> +       down_read(&policy->rwsem);
>>          cpus = cpumask_weight(policy->cpus);
>> -
>> -       if (cpus > 1)
>> -               cpumask_clear_cpu(cpu, policy->cpus);
>> -       up_write(&policy->rwsem);
>> +       up_read(&policy->rwsem);
>>
>>          /* If cpu is last user of policy, free policy */
>> -       if (cpus == 1) {
>> +       if (cpus == 0) {
>>                  if (has_target()) {
>>                          ret = __cpufreq_governor(policy,
>>                                          CPUFREQ_GOV_POLICY_EXIT);
>> @@ -1447,15 +1459,6 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
>>
>>                  if (!cpufreq_suspended)
>>                          cpufreq_policy_free(policy);
>> -       } else if (has_target()) {
>> -               ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
>> -               if (!ret)
>> -                       ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
>> -
>> -               if (ret) {
>> -                       pr_err("%s: Failed to start governor\n", __func__);
>> -                       return ret;
>> -               }
>>          }
>
> Also, you must mention in the log about an important change you are making.
> Don't know if there are any side effects...
>
> You are emptying policy->cpus on removal of last CPU of a policy, which wasn't
> the case earlier.

You mean the log in the cover letter? Will do.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
