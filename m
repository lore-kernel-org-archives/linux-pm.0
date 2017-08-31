From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 2/4] thermal: mediatek: add Mediatek thermal driver for
 mt2712
Date: Thu, 31 Aug 2017 18:29:33 +0300
Message-ID: <f288b9c7-dc2e-79bd-4503-b46bec9ac404@gmail.com>
References: <1501572513-7958-1-git-send-email-louis.yu@mediatek.com>
 <1501572513-7958-3-git-send-email-louis.yu@mediatek.com>
 <1502198610.4296.58.camel@intel.com> <1503628245.2774.8.camel@intel.com>
 <1503630623.2003.10.camel@mtksdaap41> <1503631432.2774.15.camel@intel.com>
 <1503632387.2003.16.camel@mtksdaap41> <1504185003.2749.1.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:34694 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdHaP35 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2017 11:29:57 -0400
Received: by mail-wr0-f179.google.com with SMTP id z91so3108981wrc.1
        for <linux-pm@vger.kernel.org>; Thu, 31 Aug 2017 08:29:56 -0700 (PDT)
In-Reply-To: <1504185003.2749.1.camel@intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Dawei Chien <dawei.chien@mediatek.com>
Cc: Louis Yu <louis.yu@mediatek.com>, Eduardo Valentin <edubezval@gmail.com>, hanyi.wu@mediatek.com, s.hauer@pengutronix.de, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Fan Chen <fan.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com



On 08/31/2017 04:10 PM, Zhang Rui wrote:
> On Fri, 2017-08-25 at 11:39 +0800, Dawei Chien wrote:
>> On Fri, 2017-08-25 at 11:23 +0800, Zhang Rui wrote:
>>>
>>> Hi, Dawei,
>>>
>>>
>>> On Fri, 2017-08-25 at 11:10 +0800, Dawei Chien wrote:
>>>>
>>>> On Fri, 2017-08-25 at 10:30 +0800, Zhang Rui wrote:
>>>>>
>>>>>
>>>>> On Tue, 2017-08-08 at 21:23 +0800, Zhang Rui wrote:
>>>>>>
>>>>>>
>>>>>> On Tue, 2017-08-01 at 15:28 +0800, Louis Yu wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> This patch adds support for mt2712 chip to mtk_thermal,
>>>>>>> and integrate mt2712 into the same mediatek thermal driver.
>>>>>>> MT2712 has only 1 bank and 4 sensors.
>>>>>>>
>>>>>>> Signed-off-by: Louis Yu <louis.yu@mediatek.com>
>>>>>>> ---
>>>>>>>   drivers/thermal/mtk_thermal.c | 70
>>>>>>> ++++++++++++++++++++++++++++++++++++++++---
>>>>>>>   1 file changed, 66 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/thermal/mtk_thermal.c
>>>>>>> b/drivers/thermal/mtk_thermal.c
>>>>>>> index 7737f14..e35d28d 100644
>>>>>>> --- a/drivers/thermal/mtk_thermal.c
>>>>>>> +++ b/drivers/thermal/mtk_thermal.c
>>>>>>> @@ -3,6 +3,7 @@
>>>>>>>    * Author: Hanyi Wu <hanyi.wu@mediatek.com>
>>>>>>>    *         Sascha Hauer <s.hauer@pengutronix.de>
>>>>>>>    *         Dawei Chien <dawei.chien@mediatek.com>
>>>>>>> + *         Louis Yu <louis.yu@mediatek.com>
>>>>>> I need the feedback from the previous authors for the changes
>>>>>> in
>>>>>> all
>>>>>> this patch set.
>>>>>>
>>>>> Hanyi, Sascha and Dawei,
>>>>>
>>>>> can you please review this patch and let me know your opinion?
>>>>>
>>>>> thanks,
>>>>> rui
>>>> Hi Rui,
>>>> In my opinion, I agree this patch set for supporting MT2712
>>>> thermal
>>>> sensor.
>>>>
>>>> Reviewed-by: Dawei Chien <dawei.chien@mediatek.com>
>>>>
>>> thanks for reviewing.
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>    *
>>>>>>>    * This program is free software; you can redistribute it
>>>>>>> and/or
>>>>>>> modify
>>>>>>>    * it under the terms of the GNU General Public License
>>>>>>> version 2
>>>>>>> as
>>>>>>> @@ -111,9 +112,10 @@
>>>>>>>   
>>>>>>>   /*
>>>>>>>    * Layout of the fuses providing the calibration data
>>>>>>> - * These macros could be used for both MT8173 and MT2701.
>>>>>>> + * These macros could be used for both MT8173, MT2701, and
>>>>>>> MT2712.
>>>>>>>    * MT8173 has five sensors and need five VTS calibration
>>>>>>> data,
>>>>>>> - * and MT2701 has three sensors and need three VTS
>>>>>>> calibration
>>>>>>> data.
>>>>>>> + * and MT2701 has three sensors and need three VTS
>>>>>>> calibration
>>>>>>> data,
>>>>>>> + * and MT2712 has four sensors and need four VTS
>>>>>>> calibration
>>>>>>> data.
>>>>>>>    */
>>>>>> why bother change these comments again in patch 3/4?
>>>>>>
>>>>>> thanks,
>>>>>> rui
>>>> Hi Rui,
>>>> May we know your opinion if this patch set need merge patch2/3/4
>>>>
>>> what do you mean? If you're okay with this, I will merge the full
>>> patch
>>> set.
>>>
>>> thanks,
>>> rui
>> Hi Rui,
>> It's okay to me. Since we saw your comment "why bother change these
>> comments again in patch 3/4?", so I think you might suggest to merge
>> patch2/patch3/patch4 to one patch.
>>
> I will take patch 2, 3 and 4 as separate patches.
> BTW, is it okay for me to add your Reviewed-by for all the patch
> series?
> 
> thanks,
> rui
> 

Hi Rui,

Normally the driver maintainers also take the devicetree bindings documentation 
and the SoC maintainter takes the acutal dts declaration for each SoC.

Please let me know if you prefer, that I take care of the bindings documentation 
as well.

Best regards,
Matthias
