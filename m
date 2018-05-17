From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC PATCH] PM / devfreq: Add policy notifier
Date: Fri, 18 May 2018 08:26:30 +0900
Message-ID: <5AFE0FA6.4020101@samsung.com>
References: <CGME20180515212545epcas1p2bdfd9c90f2ce6b74ac0fdd8cd9f9f63b@epcas1p2.samsung.com>
        <20180515212447.180595-1-mka@chromium.org> <5AFCE27E.20803@samsung.com>
        <20180517230728.GQ19594@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180517230728.GQ19594@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 2018년 05월 18일 08:07, Matthias Kaehlcke wrote:
> Hi,
> 
> On Thu, May 17, 2018 at 11:01:34AM +0900, Chanwoo Choi wrote:
>> Hi,
>>
>> Could you give some use-case of DEVFREQ_POLICY_NOTIFIER
>> or send use-case patch with this patch?
> 
> This is a WIP patch that makes use of the DEVFREQ_POLICY_NOTIFIER:
> 
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1065122
> 
>> I already knew the CPUFREQ_POLICY_NOTIFIER.
>> But, until now, there are no any requirements of DEVFREQ_POLICY_NOTIFIER.
>> If there are no any use-case, it is not necessary codes.
> 
> Sure, I intend to land the above driver upstream if devfreq can
> provide the necessary interfaces.

I recommend that you should send the patch with the use-case patch.

> 
>> On 2018년 05월 16일 06:24, Matthias Kaehlcke wrote:
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index fe2af6aa88fc..a7294c056f65 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -273,6 +273,9 @@ int update_devfreq(struct devfreq *devfreq)
>>>  	if (err)
>>>  		return err;
>>>  
>>> +	srcu_notifier_call_chain(&devfreq->policy_notifier_list,
>>> +			DEVFREQ_ADJUST, &freq);
>>
>> It is not proper to used 'freq' as the passed data.
>> In current step,'freq' is not adjusted and is not final decided
>> frequency.
> 
> Right, the next revision will pass a struct devfreq_policy instead,
> where the notifiers can adjust the min/max values, similar to what
> cpufreq does.

Actually, I don't know the devfreq_policy(?). As I already commented,
it is not proper to discuss it because there is no any real code and patches.
It is difficult to understand for me.

> 
> Thanks
> 
> Matthias
> 
> 
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
