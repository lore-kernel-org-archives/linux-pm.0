From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 5/8] PM / devfreq: Get the available next frequency
 on update_devfreq()
Date: Fri, 13 Oct 2017 15:45:19 +0900
Message-ID: <59E060FF.1060507@samsung.com>
References: <1507691364-3899-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171011030947epcas1p1133ca20bb9356453c331751b3e3bba4b@epcms1p2>
        <1507691364-3899-6-git-send-email-cw00.choi@samsung.com>
        <20171011113041epcms1p2c09f39f5db8f3b33cb25fe4c28e18e74@epcms1p2>
        <CAGTfZH0NSZkDvPAv=Msvqc5EQJQy5YEAWXwmgChvPVi2jaAnbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51639 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbdJMGpV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2017 02:45:21 -0400
In-reply-to: <CAGTfZH0NSZkDvPAv=Msvqc5EQJQy5YEAWXwmgChvPVi2jaAnbg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>
Cc: cwchoi00@gmail.com, Kyungmin Park <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, Inki Dae <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi,

On 2017년 10월 11일 22:33, Chanwoo Choi wrote:
> On Wed, Oct 11, 2017 at 8:30 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>>> The update_devfreq() considers only user frequency (min_freq/max_freq)
>>> and the next target_freq provided by the governor. But, the commit
>>> a76caf55e5b35 ("thermal: Add devfreq cooling") is able to disable
>>> OPP as a cooling device. In result, the update_devfreq() have to
>>> consider the 'opp->available' status in order to decicde the next freq
>>> by the devfreq_recommended_opp().
>>>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>>  drivers/devfreq/devfreq.c | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 1c4b377cacfb..3b9662ffe603 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -255,6 +255,7 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>>>  int update_devfreq(struct devfreq *devfreq)
>>>  {
>>>       struct devfreq_freqs freqs;
>>> +     struct dev_pm_opp *opp;
>>>       unsigned long freq, cur_freq;
>>>       int err = 0;
>>>       u32 flags = 0;
>>> @@ -273,7 +274,7 @@ int update_devfreq(struct devfreq *devfreq)
>>>               return err;
>>>
>>>       /*
>>> -      * Adjust the frequency with user freq and QoS.
>>> +      * Adjust the frequency with user freq, QoS and available freq.
>>>        *
>>>        * List from the highest priority
>>>        * max_freq
>>> @@ -289,6 +290,12 @@ int update_devfreq(struct devfreq *devfreq)
>>>               flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>>>       }
>>>
>>> +     opp = devfreq_recommended_opp(devfreq->dev.parent, &freq, flags);
>>> +     if (IS_ERR(opp))
>>> +             return PTR_ERR(opp);
>>> +     freq = dev_pm_opp_get_freq(opp);
>>> +     dev_pm_opp_put(opp);
>>> +
>>
>> Is this really necessary?
> 
> The requirement is due to devfreq_cooling device using
> dev_pm_opp_disable/enable().

I got the better solution. If struct devfreq contains the 'scaling_min/max_freq'
variable, this issue could be fixed. I'll update it with scaling_min/max_freq'
variables on v4.

> 
> I added the detailed explanation on cover letter as following:
> If this code is not included, the notifiee using TRANSITION_NOTIFIER
> receives the wrong next target_freq. On the cpufreq, cpufreq doesn't
> use the 'dev_pm_opp_disable/enable()' function and then there is no
> the same issue on cpufreq.
> 
> [Cover letter's description about this patch]
> For example,
> - devfreq's min_freq is 100Mhz and max_freq is 700Mhz.
> - OPP disabled 500/600/700Mhz due to devfreq-cooling.c.
> - simple_ondemand govenor decided the next target_freq (600Mhz)
> |----------|-------------------------------------------------------------|
> |Freq(MHz) |100     |200    |300    |400     |500     |600      |70 0    |
> |Devfreq   |min_freq|       |       |        |        |         |max_freq|
> |OPP avail |enabled |enabled|enabled|enabled |Disabled| Disabled|Disabled|
> |Ondmenad  |        |       |       |        |        |next_freq|        |
> |------------------------------------------------------------------------|
> 
> In result,
> - Before this patch, target_freq is 600Mhz
>   and TRANSITION_NOTIFIER sends the next_freq is 600Mhz to the notifiee.
> - After this patch, target_freq is 400Mhz because 500/600 were disabled by OPP.
>   and TRANSITION_NOTIFIER sends the next_freq is 400Mhz to the notifiee.
> --------------
> 
>>
>> devfreq_recommended_opp is going to be called by the device driver
>> invoked by devfreq->profile->target() function anyway.
>>
>> We are now going to call devfreq_recommended_opp twice in this context.
>>
>>>       if (devfreq->profile->get_cur_freq)
>>>               devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
>>>       else
>>> --
> 
> Right. The devfreq_recommended_opp() is called twice.
> I wish there was a better way.
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
