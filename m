From: Bo Yan <byan@nvidia.com>
Subject: Re: [PATCH] cpufreq: skip cpufreq resume if it's not suspended
Date: Wed, 24 Jan 2018 12:53:14 -0800
Message-ID: <913f1715-bdd0-1c03-ad76-38be9d3d2298@nvidia.com>
References: <1516744675-21233-1-git-send-email-byan@nvidia.com>
 <1744712.rO4QOLozun@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1744712.rO4QOLozun@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: viresh.kumar@linaro.org, sgurrappadi@nvidia.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 01/23/2018 06:02 PM, Rafael J. Wysocki wrote:
> On Tuesday, January 23, 2018 10:57:55 PM CET Bo Yan wrote:
>>   drivers/cpufreq/cpufreq.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 41d148af7748..95b1c4afe14e 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1680,6 +1680,10 @@ void cpufreq_resume(void)
>>   	if (!cpufreq_driver)
>>   		return;
>>   
>> +	if (unlikely(!cpufreq_suspended)) {
>> +		pr_warn("%s: resume after failing suspend\n", __func__);
>> +		return;
>> +	}
>>   	cpufreq_suspended = false;
>>   
>>   	if (!has_target() && !cpufreq_driver->resume)
>>
> Good catch, but rather than doing this it would be better to avoid
> calling cpufreq_resume() at all if cpufreq_suspend() has not been called.
Yes, I thought about that, but there is no good way to skip over it 
without introducing another flag. cpufreq_resume is called by 
dpm_resume, cpufreq_suspend is called by dpm_suspend. In the failure 
case, dpm_resume is called, but dpm_suspend is not. So on a higher level 
it's already unbalanced.

One possibility is to rely on the pm_transition flag. So something like:


diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index dc259d20c967..8469e6fc2b2c 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -842,6 +842,7 @@ static void async_resume(void *data, async_cookie_t 
cookie)
  void dpm_resume(pm_message_t state)
  {
         struct device *dev;
+       bool suspended = (pm_transition.event != PM_EVENT_ON);
         ktime_t starttime = ktime_get();

         trace_suspend_resume(TPS("dpm_resume"), state.event, true);
@@ -885,7 +886,8 @@ void dpm_resume(pm_message_t state)
         async_synchronize_full();
         dpm_show_time(starttime, state, NULL);

-       cpufreq_resume();
+       if (likely(suspended))
+               cpufreq_resume();
         trace_suspend_resume(TPS("dpm_resume"), state.event, false);
  }

This relies on the fact that the pm_transition will stay as PMSG_ON if 
dpm_prepare failed, in which case dpm_suspend will be skipped over, 
pm_transition will remain as 0 until dpm_resume.

dpm_suspend changes pm_transition to whatever state it receives, which 
is never PMSG_ON. pm_transition is not changing to PMSG_ON before 
dpm_resume. This is my understanding. does this make sense?


>
> Thanks,
> Rafael
>
>
