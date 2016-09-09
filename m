From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 0/8] power: add power sequence library
Date: Fri, 9 Sep 2016 10:47:17 +0200
Message-ID: <CAPDyKFp0w0mBGNgu6uk7UevUka_ha6MvaVyOzXjCg3S8kdF7tg@mail.gmail.com>
References: <1471252398-957-1-git-send-email-peter.chen@nxp.com>
 <b1848eb2-9298-9089-ee4d-5356998c6c08@linaro.org> <20160824085335.GB27233@shlinux2>
 <20160829111045.GB3736@b29397-desktop> <3a45793f-18d9-0688-d2ab-ef79432c473c@linaro.org>
 <20160831095220.GA11938@b29397-desktop> <fd94340b-1c1d-2307-7e57-5b05f1655d2c@linaro.org>
 <20160902011046.GB11262@shlinux2> <eb032ff2-dac4-5efe-dda0-96404f290aa8@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36842 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbcIIIrU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2016 04:47:20 -0400
Received: by mail-wm0-f49.google.com with SMTP id b187so19059614wme.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Sep 2016 01:47:20 -0700 (PDT)
In-Reply-To: <eb032ff2-dac4-5efe-dda0-96404f290aa8@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, Peter Chen <hzpeterchen@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Peter Chen <peter.chen@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, dwmw3@infradead.org, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Linux USB List <linux-usb@vger.kernel.org>, oscar@naiandei.net, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Arnd Bergmann <arnd@arndb.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

[...]

>>>>
>>>> We had an agreement that keep mmc's pwrseq framework unchanging.
>>>> Unless Ulf and rob both agree to change.
>>>
>>> Why 2 separate approach for same problem ?
>>> And I see this as possible duplication of code/functionality :)
>>
>> How the new kernel compatibles old dts? If we do not need to
>> consider this problem, the mmc can try to use power sequence library
>> too in future.
>
>
> I think we should attempt to get both MMC and USB power seq
> come on one agreement, so that it can be reused.

That would be nice. Although, to do that you would have to allow some
DT bindings to be deprecated in the new generic power seq bindings, as
otherwise you would break existing DTBs.

I guess that is what Rob was objecting to!?

>
> MMC Power Seq :
>  It is based on platform_device/platform_driver approach,

We recently converted MMC to this. It's has a clear benefit as you can
rely on the behaviour from the driver core and PM core. So, it simply
avoids duplication of code.

>
> USB Power seq :
>  We are trying to propose library approach, with compatible string match.
>
> We should try to have one approach.
>>
>>
>>>>>   - Lets also add suspend/resume callback to struct pwrseq
>>>>>
>>>> Why suspend/resume can't do at related driver's suspend/resume API?
>>>
>>> Nope...
>>> The pwrseq library would have taken ownership of resources, so
>>> related driver cannot suspend the device. Again it is architecture
>>> specific, but we should have provision to handle this.
>>>
>>> The system I am dealing with today, does need suspend/resume
>>> callback. To be precise, suspend is close to off state for some devices
>>> or
>>> they could enter standby or different low power state, but to do that,
>>> we need same resource as used for ON/OFF functionality.
>>>
>> Ok, I will have API for suspend/resume. You can implement it at your own
>> library or generic one.

As stated, using a platform device + driver would simplify this, as
you wouldn't need an API but only a driver. I guess.

Kind regards
Uffe
