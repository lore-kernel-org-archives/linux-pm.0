From: Riku Voipio <riku.voipio@linaro.org>
Subject: Re: [PATCH v2] thermal: allow building dove_thermal with mvebu
Date: Tue, 15 Jul 2014 17:00:16 +0300
Message-ID: <CAAqcGHnD-u07QC66O11eOEuF0yxYh0k8anREKnQP_UQF=ab5vg@mail.gmail.com>
References: <1401452899-13952-1-git-send-email-riku.voipio@linaro.org>
	<1401537027-32291-1-git-send-email-riku.voipio@linaro.org>
	<5389D110.8020606@gmail.com>
	<CAAqcGHkcnm_JjyzWewEcdGuGyyBwtDT_6EWxFzKSqS7NEUaerA@mail.gmail.com>
	<1404180277.8366.14.camel@rzhang1-toshiba>
	<53B27670.4000702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:54510 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbaGOOAS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jul 2014 10:00:18 -0400
Received: by mail-qg0-f52.google.com with SMTP id f51so4844133qge.11
        for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2014 07:00:17 -0700 (PDT)
In-Reply-To: <53B27670.4000702@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, andrew@lunn.ch, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>

On 1 July 2014 11:50, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> On 07/01/2014 04:04 AM, Zhang Rui wrote:

>> Can anybody tell me the relationship between ARCH_DOVE and MARC_DOVE,
>> and which one should be the proper fix please?

> Rui,

> ARCH_DOVE represents legacy, non-DT arch/arm/mach-dove while
> MACH_DOVE is DT-only Dove in arch/arm/mach-mvebu.

> The idea was to have both, legacy and DT-only Dove, for some
> cycles to allow us to finalize the DT transition.

> Due to a justified request of Russell, we will keep legacy
> mach-dove for a while longer.

> The correct patch is the one below, adding both MACH_DOVE and ARCH_DOVE
> to DOVE_THERMAL.

Here on patchwork:

https://patches.linaro.org/31238/

It would be really nice to get it to 3.16 since Sebastians original
patch already slipped from 3.15 :(

Riku


> Sebastian
>
>> Eduardo,
>> I would queue the proper patch for next rc, what's your opinion?
>>
>>>> [1] https://lkml.kernel.org/r/1395295065.3571.10.camel@rzhang1-mobl4
>>>>
>>>>> v2: non-ascii char creeped in somehow
>>>>>
>>>>> Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
>>>>> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>>>> Cc: Zhang Rui <rui.zhang@intel.com>
>>>>> Cc: Eduardo Valentin <edubezval@gmail.com>
>>>>> Cc: linux-pm@vger.kernel.org
>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>> ---
>>>>>   drivers/thermal/Kconfig | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>>>>> index 2d51912..5783c72 100644
>>>>> --- a/drivers/thermal/Kconfig
>>>>> +++ b/drivers/thermal/Kconfig
>>>>> @@ -151,7 +151,7 @@ config KIRKWOOD_THERMAL
>>>>>
>>>>>   config DOVE_THERMAL
>>>>>        tristate "Temperature sensor on Marvell Dove SoCs"
>>>>> -     depends on ARCH_DOVE
>>>>> +     depends on ARCH_DOVE || MACH_DOVE
>>>>>        depends on OF
>>>>>        help
>>>>>          Support for the Dove thermal sensor driver in the Linux
>>>
>>> thermal
>>>>>
>>>>>
>>>>
>>
>>
>
