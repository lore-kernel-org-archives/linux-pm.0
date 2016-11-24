From: hl <hl@rock-chips.com>
Subject: Re: [PATCH v1 & v6 1/2] PM/devfreq: add suspend frequency support
Date: Thu, 24 Nov 2016 16:34:42 +0800
Message-ID: <5836A622.20007@rock-chips.com>
References: <CGME20161124061416epcms1p44a0152bca14312f1229cab835ea0297f@epcms1p4>
 <20161124061416epcms1p44a0152bca14312f1229cab835ea0297f@epcms1p4>
 <58368C91.8030502@rock-chips.com> <5836927B.9010205@samsung.com>
 <5836980F.6050006@rock-chips.com> <5836A1E0.1070707@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:59141 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbcKXIey (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2016 03:34:54 -0500
In-Reply-To: <5836A1E0.1070707@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "dbasehore@chromium.org" <dbasehore@chromium.org>, "dianders@chromium.org" <dianders@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

Hi Chanwoo Choi,


On 2016年11月24日 16:16, Chanwoo Choi wrote:
> Hi Lin,
>
> On 2016년 11월 24일 16:34, hl wrote:
>> Hi Chanwoo Choi,
>>
>>      I think the dev_pm_opp_get_suspend_opp() have implement most of
>> the funtion, all we need is just define the node in dts, like following:
>>
>> &dmc_opp_table {
>>      opp06 {
>>          opp-suspend;
>>      };
>> };
> Two approaches use the 'opp-suspend' property.
>
> I think that the method to support suspend-opp have to
> guarantee following conditions:
> - Support the all of devfreq's governors.
     As MyungJoo Ham suggestion, i will set the suspend frequency in 
devfreq_suspend_device(),
which will ingore governor.
> - Devfreq framework have the responsibility to change the
>    frequency/voltage for suspend-opp. If we uses the
>    new devfreq_suspend(), each devfreq device don't care
>    how to support the suspend-opp. Just the developer of each
>    devfreq device need to add 'opp-suspend' propet to OPP entry in DT file.
Why should support change the voltage in devfreq framework, i think it 
shuold be handle in
specific driver, i think the devfreq only handle it can get the right 
frequency, then pass it to
specific driver, i think the voltage should handle in the 
devfreq->profile->target();
> Best Regards,
> Chanwoo Choi
>
>> so i think my way semm more simple.
>>
>> On 2016年11月24日 15:10, Chanwoo Choi wrote:
>>> + Tobias Jakobi,
>>>
>>> Hi Lin,
>>>
>>> We need to discuss how to support the suspend-opp of devfreq device.
>>> Now, there are two patch thread for suspend-opp of devfreq.
>>>
>>> The Lin's approach modify the devfreq_suspend_device() to support suspend-opp.
>>> The Tobias's approach[1] add new devfreq_suspend() and then call it on dpm_suspend()
>>> when entering the suspend state.
>>>
>>> [1] [RFC 0/4] PM / devfreq: draft for OPP suspend impl
>>> - https://patchwork.kernel.org/patch/9443323/
>>> - https://patchwork.kernel.org/patch/9443325/
>>> - https://patchwork.kernel.org/patch/9443329/
>>> - https://patchwork.kernel.org/patch/9443331/
>>>
>>> I think we need to discuss it together.
>>>
>>> Regards,
>>> Chanwoo Choi
>>>
>>> On 2016년 11월 24일 15:45, hl wrote:
>>>> Hi MyungJoo Ham,
>>>>
>>>> On 2016年11月24日 14:14, MyungJoo Ham wrote:
>>>>> On Thu, Nov 24, 2016 at 11:18 AM, hl <hl@rock-chips.com> wrote:
>>>>>> Hi MyungJoo Ham,
>>>>> []
>>>>>>> We still need to sync the all status even i call target() in
>>>>>>> devfreq_suspend/resume_device
>>>>>>> directly, so still need update_devfreq() other setp except
>>>>>>> devfreq->governor->get_target_freq(devfreq, &freq);
>>>>>> And i think it better to be governor behaviors, for userspace they may not
>>>>>> want to change
>>>>>> the suspend frequency like other governor, the frequency should decide by
>>>>>> the user, if they
>>>>>> want this function, they should like other governor to rigister a
>>>>>> devfreq_monitor_suspend().
>>>>>> What do you think about my rev6 patch?
>>>>> If I understand the intention correctly, this is for the stability of
>>>>> the device due to the behavior or bootloader/SoC-initializer, which
>>>>> has nothing to do with governors.
>>>>>
>>>>> Even if users are using userspace, as long as they set the custom
>>>>> frequencies lower than the default, they have the possibility of
>>>>> being unstable as ondemand is going to have.
>>>>>
>>>>>
>>>>> To reuse the update_devfreq() code, you may do something like:
>>>>>
>>>>> static int _update_freq(struct devfreq *devfreq, bool is_suspending)
>>>>> {
>>>>>       /* original contents of update_freq with if statement with is_suspending wrapping get_target_freq */
>>>>> }
>>>>> int update_freq(struct devfreq *devfreq)
>>>>> {
>>>>>      return _update_freq(devfreq, false);
>>>>> }
>>>>>
>>>>>
>>>>> There should be other good non-invasive methods that are not governoe-specific as well.
>>>>>
>>>> Thanks for your suggestion, i will update the new version soon.
>>>>> Cheers,
>>>>> MyungJoo
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> Linux-rockchip mailing list
>>>>> Linux-rockchip@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>>> -- 
>>>> Lin Huang
>>>>
>>>
>>>
>
>
>

-- 
Lin Huang


