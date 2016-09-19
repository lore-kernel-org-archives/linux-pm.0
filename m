From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [PATCH v6 0/8] power: add power sequence library
Date: Mon, 19 Sep 2016 13:09:10 +0530
Message-ID: <ecbc3c0d-4ce7-758d-7f7d-4b3f3003c1ac@linaro.org>
References: <1471252398-957-1-git-send-email-peter.chen@nxp.com>
 <b1848eb2-9298-9089-ee4d-5356998c6c08@linaro.org>
 <20160824085335.GB27233@shlinux2> <20160829111045.GB3736@b29397-desktop>
 <3a45793f-18d9-0688-d2ab-ef79432c473c@linaro.org>
 <20160831095220.GA11938@b29397-desktop>
 <fd94340b-1c1d-2307-7e57-5b05f1655d2c@linaro.org>
 <20160902011046.GB11262@shlinux2>
 <eb032ff2-dac4-5efe-dda0-96404f290aa8@linaro.org>
 <CAPDyKFp0w0mBGNgu6uk7UevUka_ha6MvaVyOzXjCg3S8kdF7tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35098 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbcISHjW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Sep 2016 03:39:22 -0400
Received: by mail-pf0-f181.google.com with SMTP id z123so48166574pfz.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Sep 2016 00:39:21 -0700 (PDT)
In-Reply-To: <CAPDyKFp0w0mBGNgu6uk7UevUka_ha6MvaVyOzXjCg3S8kdF7tg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Peter Chen <hzpeterchen@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Peter Chen <peter.chen@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, dwmw3@infradead.org, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?Q?Krzysztof_Koz=c5=82owski?= <k.kozlowski@samsung.com>, Linux USB List <linux-usb@vger.kernel.org>, oscar@naiandei.net, =?UTF-8?Q?Pawe=c5=82_Moll?= <pawel.moll@arm.com>, Arnd Bergmann <arnd@arndb.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>



On Friday 09 September 2016 02:17 PM, Ulf Hansson wrote:
> [...]
>
>>>>> We had an agreement that keep mmc's pwrseq framework unchanging.
>>>>> Unless Ulf and rob both agree to change.
>>>> Why 2 separate approach for same problem ?
>>>> And I see this as possible duplication of code/functionality :)
>>> How the new kernel compatibles old dts? If we do not need to
>>> consider this problem, the mmc can try to use power sequence library
>>> too in future.
>>
>> I think we should attempt to get both MMC and USB power seq
>> come on one agreement, so that it can be reused.
> That would be nice. Although, to do that you would have to allow some
> DT bindings to be deprecated in the new generic power seq bindings, as
> otherwise you would break existing DTBs.
>
> I guess that is what Rob was objecting to!?

yeah, thats right.

So lets adopt similar implementation for USB as well instead of
library, but keeping MMC untouched as of now.

What I am trying to propose here is,

Lets have power-sequence framework (similar to V1 of this series),
with,

pwrseq: Core framework for power sequence.
pwrseq_generic/simple: for all generic control, like reset and clock
pwrseq_emmc: probably duplication of existing code - the idea
                           here is, all future code should be using this new
                           binding, so that we can deprecate the 
drivers/mmc/core/pwrseq
pwrseq_arche: The usecase which I am dealing with today, which is more
                          complex in nature.

Then the respective drivers can add their drivers (if needed) based on
complexity.

comments ??

>> MMC Power Seq :
>>   It is based on platform_device/platform_driver approach,
> We recently converted MMC to this. It's has a clear benefit as you can
> rely on the behaviour from the driver core and PM core. So, it simply
> avoids duplication of code.

Agreed.

>> USB Power seq :
>>   We are trying to propose library approach, with compatible string match.
>>
>> We should try to have one approach.
>>>
>>>>>>    - Lets also add suspend/resume callback to struct pwrseq
>>>>>>
>>>>> Why suspend/resume can't do at related driver's suspend/resume API?
>>>> Nope...
>>>> The pwrseq library would have taken ownership of resources, so
>>>> related driver cannot suspend the device. Again it is architecture
>>>> specific, but we should have provision to handle this.
>>>>
>>>> The system I am dealing with today, does need suspend/resume
>>>> callback. To be precise, suspend is close to off state for some devices
>>>> or
>>>> they could enter standby or different low power state, but to do that,
>>>> we need same resource as used for ON/OFF functionality.
>>>>
>>> Ok, I will have API for suspend/resume. You can implement it at your own
>>> library or generic one.
> As stated, using a platform device + driver would simplify this, as
> you wouldn't need an API but only a driver. I guess.

Exactly.

Thanks,
Vaibhav
