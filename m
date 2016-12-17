From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [PATCH v1 & v6 1/2] PM/devfreq: add suspend frequency support
Date: Sat, 17 Dec 2016 19:19:01 +0100
Message-ID: <58558195.20907@math.uni-bielefeld.de>
References: <CGME20161124061416epcms1p44a0152bca14312f1229cab835ea0297f@epcms1p4>
 <20161124061416epcms1p44a0152bca14312f1229cab835ea0297f@epcms1p4>
 <58368C91.8030502@rock-chips.com> <5836927B.9010205@samsung.com>
 <5836980F.6050006@rock-chips.com> <5836A1E0.1070707@samsung.com>
 <5836A622.20007@rock-chips.com> <5836B2C2.6090308@samsung.com>
 <5836B8D1.9050707@samsung.com>
 <CAGTfZH34MvFGGuPgt=qUM6FMmi+Z80akY5ZH1k6gXdzg19fh9Q@mail.gmail.com>
 <5855560E.4050609@math.uni-bielefeld.de>
 <CAGTfZH0HDuexEHR5aqBxWifFKL1fBT1K80XGFX27YqHtDf_7hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:42362 "EHLO
        smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751932AbcLQSTF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Dec 2016 13:19:05 -0500
In-Reply-To: <CAGTfZH0HDuexEHR5aqBxWifFKL1fBT1K80XGFX27YqHtDf_7hw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cwchoi00@gmail.com
Cc: Chanwoo Choi <cw00.choi@samsung.com>, hl <hl@rock-chips.com>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "dbasehore@chromium.org" <dbasehore@chromium.org>, "dianders@chromium.org" <dianders@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hey Chanwoo,


Chanwoo Choi wrote:
> 2016-12-18 0:13 GMT+09:00 Tobias Jakobi <tjakobi@math.uni-bielefeld.de>:
>> Hey guys,
>>
>> Chanwoo Choi wrote:
>>> Hi Lin,
>>>
>>> 2016-11-24 18:54 GMT+09:00 Chanwoo Choi <cw00.choi@samsung.com>:
>>>> Hi Lin,
>>>>
>>>> On 2016년 11월 24일 18:28, Chanwoo Choi wrote:
>>>>> Hi Lin,
>>>>>
>>>>> On 2016년 11월 24일 17:34, hl wrote:
>>>>>> Hi Chanwoo Choi,
>>>>>>
>>>>>>
>>>>>> On 2016年11月24日 16:16, Chanwoo Choi wrote:
>>>>>>> Hi Lin,
>>>>>>>
>>>>>>> On 2016년 11월 24일 16:34, hl wrote:
>>>>>>>> Hi Chanwoo Choi,
>>>>>>>>
>>>>>>>>      I think the dev_pm_opp_get_suspend_opp() have implement most of
>>>>>>>> the funtion, all we need is just define the node in dts, like following:
>>>>>>>>
>>>>>>>> &dmc_opp_table {
>>>>>>>>      opp06 {
>>>>>>>>          opp-suspend;
>>>>>>>>      };
>>>>>>>> };
>>>>>>> Two approaches use the 'opp-suspend' property.
>>>>>>>
>>>>>>> I think that the method to support suspend-opp have to
>>>>>>> guarantee following conditions:
>>>>>>> - Support the all of devfreq's governors.
>>>>>>     As MyungJoo Ham suggestion, i will set the suspend frequency in devfreq_suspend_device(),
>>>>>> which will ingore governor.
>>>>>
>>>>> Other approach already support the all of governors.
>>>>> Before calling the mail, I discussed with Myungjoo Ham.
>>>>> Myungjoo prefer to use the devfreq_suspend/devfreq_resume().
>>>>
>>>> It is not correct expression. We need to wait the reply from Myungjoo
>>>> to clarify this.
>>>>
>>>>>
>>>>> To Myungjoo,
>>>>> Please add your opinion how to support the suspend frequency.
>>>>
>>>>>
>>>>>>> - Devfreq framework have the responsibility to change the
>>>>>>>    frequency/voltage for suspend-opp. If we uses the
>>>>>>>    new devfreq_suspend(), each devfreq device don't care
>>>>>>>    how to support the suspend-opp. Just the developer of each
>>>>>>>    devfreq device need to add 'opp-suspend' propet to OPP entry in DT file.
>>>>>> Why should support change the voltage in devfreq framework, i think it shuold be handle in
>>>>>> specific driver, i think the devfreq only handle it can get the right frequency, then pass it to
>>>>>
>>>>> No, the frequency should be handled by governor or framework.
>>>>> The each devfreq device has no any responsibility of next frequency/voltage.
>>>>> The governor and core of devfreq can decide the next frequency/voltage.
>>>>> You can refer to the cpufreq subsystem.
>>>>>
>>>>>> specific driver, i think the voltage should handle in the devfreq->profile->target();
>>>>>
>>>>> The call of devfreq->profile->target() have to be handled by devfreq framework.
>>>>> If user want to set the suspend frequency, user can add the 'suspend-opp' property.
>>>>> It think this way is easy.
>>>>>
>>>>> But,
>>>>> If the each devfreq device want to decide the next frequency/voltage only for
>>>>> suspend state. We can check the cpufreq subsystem.
>>>>>
>>>>> If specific devfreq device want to handle the suspend frequency,
>>>>> each devfreq will add the own suspend/resume functions as following:
>>>>>
>>>>>       struct devfreq_dev_profile {
>>>>>               int (*suspend)(struct devfreq *dev);    // new function pointer
>>>>>               int (*resume)(struct devfreq *dev);     // new function pointer
>>>>>       } a_profile;
>>>>>
>>>>>       a_profile = devfreq_generic_suspend;
>>>>>
>>>>>       The devfreq framework will provide the devfreq_generic_suspend() funticon.
>>>>>               int devfreq_generic_suspend(struce devfreq *dev) {
>>>>>                       ...
>>>>>                       devfreq->profile->target(..., devfreq->suspend_freq);
>>>>>                       ...
>>>>>               }
>>>>>
>>>>>       or
>>>>>
>>>>>       a_profile = a_devfreq_suspend; // specific function of each devfreq device
>>>>>
>>>>>       The devfreq_suspend() will call 'devfreq->profile->suspend()' function
>>>>>       instead of devfreq->profile->target();
>>>>>
>>>>>       The devfreq call the 'devfreq->profile->suspend()'
>>>>>       to support the suspend frequency.
>>>>>
>>>>> Regards,
>>>>> Chanwoo Choi
>>>>
>>>> The key difference between two approaches:
>>>>
>>>> Your approach:
>>>> - The each developer should add the 'opp-suspend' property to the dts file.
>>>> - The each devfreq should call the devfreq_suspend_device()
>>>>   to support the suspend frequency.
>>>>
>>>>   If each devfreq doesn't call the devfreq_suspend_device(), devfreq framework
>>>>   can support the suspend frequency.
>>>>
>>>> Other approach:
>>>> - The each developer only should add the 'opp-suspend' property to the dts file
>>>>   without the additional behavior.
>>>>
>>>> In the cpufreq subsystem,
>>>> When support the suspend frequency of cpufreq, we just add 'opp-suspend' property
>>>> without the additional behavior.
>>>
>>> I'm missing the use-case when using the devfreq_suspend_device()
>>> before entering the suspend mode. We should consider the case when
>>> devfreq device
>>> calls the devfreq_suspend_device() directly. Because devfreq_suspend_device()
>>> is exported function, each devfreq device call this function on the fly
>>> without entering the suspend mode.
>>>
>>> I correct my opinion. Your approach is necessary. I'm sorry to confuse you.
>>> So, I make the following patch. This patch set the suspend frequency
>>> in devfreq_suspend_device() after stoping the governor.
>>> It consider the all governors of devfreq.
>>>
>>> What do you think?
>>> If you are ok, I'll send this patch with your author.
>> The problem I see here is that we need to keep track of the suspended
>> state when suspending the (entire) devfreq subsystem. When doing that,
>> we don't know if any device driver has previously called
>> devfreq_suspend_device() and might end up calling it twice.
>>
>> Same thing on devfreq subsystem resume.
>>
>> I've prepared a new RFC of my series (going to send it shortly), but I'm
>> not so happy with the current design. I think it would be much cleaner
>> to keep some suspend_refcount in struct devfreq so that I can call
>> devfreq_suspend_device() multiple times, while keeping a sane internal
>> state.
> 
> I agree the devfreq need  reference count for devfreq_suspend/resume_device.
> This patch focus on when changing the suspend frequency.
> 
>>
>> Something like devfreq_device_runtime_{put,get}() perhaps?
> 
> Why do devfreq need new additional functions?
> I think the devfreq_suspend/resume_device are enough.
Just thinking out loud here. I would prefer a naming that implies that
some refcounting is going on. When I see a pair of function with
put/get, then I usually know what is going on.

Here I would have to look at the actual implementation to realize, at
the moment, that I have to be careful calling these functions twice.

-Tobias


> 
> Thanks,
> Chanwoo Choi
> 
>>
>> - Tobias
>>
>>
>>
>>>
>>>  int devfreq_suspend_device(struct devfreq *devfreq)
>>>  {
>>> +      int ret = 0;
>>> +
>>>         if (!devfreq)
>>>         return -EINVAL;
>>>
>>>         if (!devfreq->governor)
>>>              return 0;
>>>
>>> -      return devfreq->governor->event_handler(devfreq,
>>> +     ret = devfreq->governor->event_handler(devfreq,
>>>                     DEVFREQ_GOV_SUSPEND, NULL);
>>> +      if (ret < 0) {
>>> +           dev_err(devfreq->dev.parent, "failed to suspend governor\n");
>>> +           return ret;
>>> +      }
>>> +
>>> +      if (devfreq->suspend_freq) {
>>> +           ret = devfreq->profile->target(devfreq->dev.parent,
>>> +                                      &devfreq->suspend_freq, 0);
>>> +           if (ret < 0) {
>>> +                  dev_err(devfreq->dev.parent,
>>> +                             "failed to set suspend-freq\n");
>>> +                  return ret;
>>> +           }
>>> +           dev_dbg(devfreq->dev.parent, "Setting suspend-freq: %lu\n",
>>> +                          devfreq->suspend_freq);
>>> +      }
>>> +
>>> +      return 0;
>>>  }
>>>  EXPORT_SYMBOL(devfreq_suspend_device);
>>>
>>

