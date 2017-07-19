From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] devfreq: simple_ondemand: Update devfreq stats when governor
 started
Date: Wed, 19 Jul 2017 12:28:27 +0800
Message-ID: <596EDFEB.4030500@rock-chips.com>
References: <1500372171-7194-1-git-send-email-jeffy.chen@rock-chips.com> <CGME20170718100259epcas3p2886849647d4a6fe257a4e12854a10f7c@epcms1p8> <20170718103549epcms1p87cf1d138e35426be0f95afa61fcebc85@epcms1p8> <596DF09E.10405@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.136]:52285 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdGSE2i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 00:28:38 -0400
In-Reply-To: <596DF09E.10405@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "briannorris@chromium.org" <briannorris@chromium.org>, "javi.merino@kernel.org" <javi.merino@kernel.org>, "dianders@chromium.org" <dianders@chromium.org>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Ham,

oops, sorry, it turns out the devfreq would already tried to handle this 
case(by using profile's initial_freq):

8d39fc0 PM / devfreq: fix initialization of current frequency in last status

and my local kernel didn't contains this commit.

so this patch is not needed, please ignore it.

On 07/18/2017 07:27 PM, jeffy wrote:
> hi Ham,
>
> Thanks for your reply.
>
> On 07/18/2017 06:35 PM, MyungJoo Ham wrote:
>>> If governor suspends soon after started, it may not have the chance to
>>> update devfreq stats, which leaves devfreq stats' current frequence be
>>> zero.
>>>
>>> So when the thermal core tries to throttle the power, it would failed
>>> to get the correct static power of current frequence and print these
>>> warnings:
>>> [    2.024735] core: dev_pm_opp_get_voltage: Invalid parameters
>>> [    2.024743] mali ff9a0000.gpu: Failed to get voltage for frequency 0:
>>> -34
>>> ...
>>> [    2.026320] core: dev_pm_opp_get_voltage: Invalid parameters
>>> [    2.026327] mali ff9a0000.gpu: Failed to get voltage for frequency 0:
>>> -34
>>>
>>> Update devfreq stats when governor started to avoid that.
>>>
>>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>
>> How are you calling suspend/resume routins in the mali drivers?
>>
> i was porting mali driver from here:
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4/drivers/gpu/arm/midgard/mali_kbase_core_linux.c#4079
>
>> It appears that your mali device driver's suspend/resume routines are
>> accessing "struct devfreq_dev_status" directly. Is this correct?
>>
> no, but the suspend/resume would suspend/resume the governor.
>>
>> Plus, for MALI (if that assumption is correct), this issue might occur
>> with other governors.
>>
>> If so, would it be better to put the first initializing call of
>> devfreq_update_stats() at devfreq_add_device()?
>>
> right, that make sense. i put it here because the comment of this
> function said it should be called by governor, but you're right, it
> would be better this way, will send new version soon.
>>
>> Cheers,
>> MyungJoo
>>
>> ps. Where can I look at the mali-devfreq device driver? (I couldn't
>> find it)
> sorry, i should mention that, please check above link :)
>>
>>
>>
>>
>
