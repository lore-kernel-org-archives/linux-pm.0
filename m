From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH] cpufreq: s5pv210: remove unused call of pr_err()
Date: Thu, 22 May 2014 09:49:02 +0530
Message-ID: <CAK9yfHym0mfi6E-_pqLThUcxHRJyrzjREGrkg5sXgZdOzspgsA@mail.gmail.com>
References: <1400702036.30334.6.camel@x220>
	<CAK9yfHz2kdfkf+o7fKMRu=nMXxbcHJ227bjpvA=WXt6ptH3QRA@mail.gmail.com>
	<CAKohpomfYKd+Jr0YouCTR8CvhiRghHEiJoHcVPL-ApkEiX9RTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomfYKd+Jr0YouCTR8CvhiRghHEiJoHcVPL-ApkEiX9RTQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Paul Bolle <pebolle@tiscali.nl>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 22 May 2014 09:44, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 22 May 2014 08:52, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> On 22 May 2014 01:23, Paul Bolle <pebolle@tiscali.nl> wrote:
>>> A call of pr_err() was added in v3.1. It was guarded by a check for
>>> CONFIG_PM_VERBOSE. The Kconfig symbol PM_VERBOSE was removed in v3.0. So
>>> this call of pr_err() has never been used. Remove it.
>>>
>>> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
>>> ---
>>> Untested.
>>>
>>>  drivers/cpufreq/s5pv210-cpufreq.c | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
>>> index ab2c1a40d437..0873729135df 100644
>>> --- a/drivers/cpufreq/s5pv210-cpufreq.c
>>> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
>>> @@ -175,10 +175,6 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
>>>         mutex_lock(&set_freq_lock);
>>>
>>>         if (no_cpufreq_access) {
>>> -#ifdef CONFIG_PM_VERBOSE
>>> -               pr_err("%s:%d denied access to %s as it is disabled"
>>> -                               "temporarily\n", __FILE__, __LINE__, __func__);
>>> -#endif
>>
>> The config symbol itself is not defined and hence could be removed.
>
> What do you meant by this? He already got rid of CONFIG_PM_VERBOSE..

Yes, my ack for that change :)


-- 
With warm regards,
Sachin
