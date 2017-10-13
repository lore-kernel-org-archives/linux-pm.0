From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 3/8] PM / devfreq: Show the available min/max
 frequency through sysfs node
Date: Fri, 13 Oct 2017 15:47:25 +0900
Message-ID: <59E0617D.10309@samsung.com>
References: <1507691364-3899-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171011030946epcas1p40f32955da5dada46e95302701a0afb7d@epcms1p3>
        <1507691364-3899-4-git-send-email-cw00.choi@samsung.com>
        <20171011111532epcms1p3036bcc7be2cc00057fe478fc868ba71d@epcms1p3>
        <CAGTfZH0-pS8SLsYdxZfOotnE_FUFTtcYVZRcS8Eqgkk-H4b1vg@mail.gmail.com>
        <59DEEAA5.3050905@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:13631 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbdJMGr1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2017 02:47:27 -0400
In-reply-to: <59DEEAA5.3050905@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>
Cc: cwchoi00@gmail.com, Kyungmin Park <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, Inki Dae <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi,

On 2017년 10월 12일 13:08, Chanwoo Choi wrote:
> On 2017년 10월 11일 21:57, Chanwoo Choi wrote:
>> On Wed, Oct 11, 2017 at 8:15 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>>>> The existing {min|max}_freq sysfs nodes don't consider whether min/max_freq
>>>> are available or not. Those sysfs nodes show just the stored value
>>>> in the struct devfreq.
>>>>
>>>> The devfreq uses the OPP interface and then dev_pm_opp_{disable|add}()
>>>> might change the state of the device's supported frequency. This patch
>>>> shows the available minimum and maximum frequency through sysfs node.
>>>>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> ---
>>>>  drivers/devfreq/devfreq.c | 18 ++++++++++++++++--
>>>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>> index 2ce1fd0a1324..799a0cf75d39 100644
>>>> --- a/drivers/devfreq/devfreq.c
>>>> +++ b/drivers/devfreq/devfreq.c
>>>> @@ -1128,7 +1128,14 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>>>>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
>>>>                            char *buf)
>>>>  {
>>>> -     return sprintf(buf, "%lu\n", to_devfreq(dev)->min_freq);
>>>> +     struct devfreq *df = to_devfreq(dev);
>>>> +     unsigned long min_freq = to_devfreq(dev)->min_freq;
>>>> +     unsigned long available_min_freq = find_available_min_freq(df);
>>>> +
>>>> +     if (available_min_freq != 0 && min_freq < available_min_freq)
>>>
>>> nitpick:
>>>
>>> If available_min_freq == 0,
>>> it can't be min_freq < available_min_freq anyway;
>>> it's unsigned.
>>
>> If the dev_pm_opp_find_*() return the error in the find_available_min_freq(),
>> avaiable_min_freq is zero. So, if available_min_freq is zero,
>> min_freq_show doesn't need to compare 'min_freq < available_min_freq'.
>>
>> In result, if 'available_min_freq' is zero, min_freq_show() only considers
>> the 'min_freq' variable.
> 
> I'll modify this patch as following: How about that?
> 
> +       if (available_min_freq == 0)
> +               goto out;
> +       else if (min_freq < available_min_freq)
> +               min_freq = available_min_freq;
> +
> +out:
> +       return sprintf(buf, "%lu\n", min_freq);
> 

Please ignore this approach because
I'll use the new 'scaling_min/max_freq' variables on v4.


> 
>>>
>>>> +             min_freq = available_min_freq;
>>>> +
>>>> +     return sprintf(buf, "%lu\n", min_freq);
>>>>  }
>>>>
>>>>  static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>>>> @@ -1162,7 +1169,14 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>>>>  static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
>>>>                            char *buf)
>>>>  {
>>>> -     return sprintf(buf, "%lu\n", to_devfreq(dev)->max_freq);
>>>> +     struct devfreq *df = to_devfreq(dev);
>>>> +     unsigned long max_freq = to_devfreq(dev)->max_freq;
>>>> +     unsigned long available_max_freq = find_available_max_freq(df);
>>>> +
>>>> +     if (available_max_freq != 0 && max_freq > available_max_freq)
>>>> +             max_freq = available_max_freq;
>>>
>>> similar here.
>>
>> ditto.
>>
>>>
>>>> +
>>>> +     return sprintf(buf, "%lu\n", max_freq);
>>>>  }
>>>>  static DEVICE_ATTR_RW(max_freq);
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
