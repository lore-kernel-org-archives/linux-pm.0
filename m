From: ayaka <ayaka@soulik.info>
Subject: Re: [PATCH v4 0/5] thermal: fixes the rockchip thermal
Date: Sun, 15 Jan 2017 11:35:19 +0800
Message-ID: <5e365ad7-c40c-59dc-4f00-3c31c261d896@soulik.info>
References: <1481540735-12710-1-git-send-email-wxt@rock-chips.com>
 <f68125d7-01bb-d0d9-d04f-8d1b5cff19a2@soulik.info>
 <8bdcea3e-0f06-da29-cb17-6b258440900a@rock-chips.com>
 <8e34e000-c1c7-20c9-2168-a31c85b3fa9a@rock-chips.com>
 <c2b13d66-e89e-02c8-3a68-6eb57627aaf2@163.com>
 <9ee3d263-8de3-eb95-034d-774ae216329f@rock-chips.com>
 <cfa99a04-b865-c2e3-274a-a8550649bf12@soulik.info>
 <20170114165428.GA2058@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kozue.soulik.info ([108.61.200.231]:35506 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbdAODfZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Jan 2017 22:35:25 -0500
In-Reply-To: <20170114165428.GA2058@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Caesar Wang <sasukewxt@163.com>, Randy Li <randy.li@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, briannorris@chromium.org, linux-kernel@vger.kernel.org, smbarber@chromium.org, linux-rockchip@lists.infradead.org, rui.zhang@intel.com



On 01/15/2017 12:54 AM, Eduardo Valentin wrote:
> Folks,
>
> On Wed, Jan 04, 2017 at 12:30:40AM +0800, ayaka wrote:
>>
>> On 01/03/2017 09:13 AM, Randy Li wrote:
>>>
>>> On 01/03/2017 09:02 AM, Caesar Wang wrote:
>>>> 在 2017年01月03日 07:57, Randy Li 写道:
>>>>> On 01/02/2017 09:16 PM, Caesar Wang wrote:
>>>>>> 在 2016年12月31日 00:11, ayaka 写道:
>>>>>>> BTW, Caesar have you ever met this at RK3288 at booting time?
>>>>>>> [    8.430582] thermal thermal_zone1: critical temperature
>>>>>>> reached(125 C),shutting down
>>>>>>> [    8.439038] thermal thermal_zone2: critical temperature
>>>>>>> reached(125 C),shutting down
>>>>>>> [    8.456344] thermal thermal_zone1: critical temperature
>>>>>>> reached(125 C),shutting down
>>>>>>> [    8.465298] thermal thermal_zone2: critical temperature
>>>>>>> reached(125 C),shutting down
>>>>>> 125C? the thermal zone isn't the upstream kernel, what's the kernel
>>>>>> version?
>>>>> They have been merged into the linux-next.
>>>> Really?
>>>> I saw the 90 degree is the critical temperature on rk3288 dts .
>>> Yes I do.
>>>> kernel$ vi arch/arm/boot/dts/rk3288.dtsi
>>>>             cpu_crit: cpu_crit {
>>>>                     temperature = <90000>; /* millicelsius */
>>>>                     hysteresis = <2000>; /* millicelsius */
>>>>                     type = "critical";
>>>>                 };
>>>>
>>>>>> Anyway, look like,  the TSHUT issue. Do you have the below patches
>>>>>> for your linux kernel?
>>>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/380446.html
>>>>>>
>>>>>>
>>>>> No, could you resubmit those patches ?
>>>> These patches had merged for upstream.
>>> Sorry, it is my fault, I mistake that commit. Those patches are merged in
>>> next-20161224. I would bring a board for you later.
>> I check the schematic, the otp interrupt is not used at firefly reload nor
>> connected to the control of PMIC.
>> I also check power supply, the power is PD_PERI domain comes from VD_LOGIC
>> which is always on all the platform.
>> It more likely the tsadc doesn't report correctly temperature value?
> Folks, I got a bit confused about this discussion. I have put these
> patches into linux-next, as I did not see anything wrong with them. And
> I was about to send to next -rc.
>
> Are these correct or not? Is it fine to move forward with them?
Yes, but you need to merge the other patch the Caesar just sent, or it 
would stop the booting sequence at rk3288.
>
> I believe for tomorrows rc is a bit too late, but I think they could
> still go to the next rc.
>
> BR,
>
>>>> -Caesar
>>>>
>>>>

