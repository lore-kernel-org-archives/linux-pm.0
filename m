From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [RFC] PM / devfreq: Add support for alerts
Date: Mon, 4 Jun 2018 22:24:05 +0900
Message-ID: <CAJ0PZbS60h_gZoG4MGc-DJrx=Ga3iCL7spopSnb-1FTctw8X=w@mail.gmail.com>
References: <1527745019-25155-1-git-send-email-akhilpo@codeaurora.org>
 <CGME20180531053717epcas5p48e0d962e2108d04529b4582a70cd7d5a@epcms1p3>
 <20180531061720epcms1p31f5451bcf3150a7dddd33e1e415bb730@epcms1p3> <f099a5b1-bd4e-d888-92c1-7366820881e8@codeaurora.org>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f099a5b1-bd4e-d888-92c1-7366820881e8@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Akhil P Oommen <akhilpo@codeaurora.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mka@chromium.org" <mka@chromium.org>, "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Akhil,

Actually, this provides custom events for governors, with different
behaviors per each governor, while Matthias's give you the effects not
targeted for a specific governor.

Could you please show me why (the usage cases) you need this
additional event for governors? (You need to implement an event
handler in each governor for this approach).


Cheers,
MyungJoo


On Fri, Jun 1, 2018 at 8:43 PM, Akhil P Oommen <akhilpo@codeaurora.org> wrote:
>
>
> On 5/31/2018 11:47 AM, MyungJoo Ham wrote:
>>>
>>> Currently, DEVFREQ reevaluates the device state periodically and/or
>>> based on the OPP list changes. Private API has to be exposed to allow
>>> the device driver to alert/notify the governor to reevaluate when a new
>>> set of data is available. This makes the governor more coupled to a
>>> particular device driver. We can improve here by exposing a DEVFREQ API
>>> to allow the device drivers to send generic alerts to the governor.
>>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
>>> ---
>>>   drivers/devfreq/devfreq.c  | 21 +++++++++++++++++++++
>>>   drivers/devfreq/governor.h |  1 +
>>>   include/linux/devfreq.h    |  5 +++++
>>>   3 files changed, 27 insertions(+)
>>>
>> Hello Akhil,
>>
>> It appears that this will have the same effect with
>> "[PATCH 08/11] PM / devfreq: Make update_devfreq() public" from Matthias
>> Kaehlcke, doesn't it?
>>
>>
>> Cheers,
>> MyungJoo
>>
> Hi MyngJoo,
>
> The patch you mentioned is a step in the right direction. But this patch
> allows:
> 1. the governor to decide whether to reevaluate or not. I feel it would be a
> better architecture (better Separation of Concern) if that decision is left
> to the governor alone.
> 2. the devices to share multiple types of alerts. A governor may use these
> alerts for internal bookkeeping/algorithm and decide to reevaluate policy
> when it is necessary. Since we are opening up a new devfreq API for devices,
> isn't it better to go for a generic one?
>
> Regards,
> Akhil.



-- 
MyungJoo Ham, Ph.D.
S/W Center, Samsung Electronics
