From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Sun, 18 Sep 2016 17:39:24 +0800
Message-ID: <CAMz4kuLXyLK2jFmaoxxceq01FT4fo+N-iAtCLPyQzJh5R24uOw@mail.gmail.com>
References: <cover.1470034830.git.baolin.wang@linaro.org> <CAMz4kuLotLs1ASuZaMRXf29khmQUfEQc+jFV8Fxp+fHFn90Z9g@mail.gmail.com>
 <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com>
 <8760q9a8m6.fsf@notabene.neil.brown.name> <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com>
 <878tv297a0.fsf@notabene.neil.brown.name> <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com>
 <87y4326l44.fsf@notabene.neil.brown.name> <CAMz4ku+wWcSPCA1_UYKNqJv4rRDEm5WYUc8AVT6xPJ651-rzmg@mail.gmail.com>
 <87twdo7ouz.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35920 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754494AbcIRJjZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Sep 2016 05:39:25 -0400
Received: by mail-yw0-f175.google.com with SMTP id t67so111345192ywg.3
        for <linux-pm@vger.kernel.org>; Sun, 18 Sep 2016 02:39:25 -0700 (PDT)
In-Reply-To: <87twdo7ouz.fsf@notabene.neil.brown.name>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: NeilBrown <nfbrown@novell.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.ke>

Hi Neil,

Sorry for late reply due yo my holiday.

On 10 September 2016 at 05:19, NeilBrown <neilb@suse.com> wrote:
> On Fri, Sep 09 2016, Baolin Wang wrote:
>
>>>
>>> In practice, the USB PHY and the Power manager will often be in the same
>>> IC (the PMIC) so the driver for one could look at the registers for the
>>> other.
>>> But there is no guarantee that the hardware works like that.  It is
>>> best to create a generally design.
>>
>> Yes, we hope to create one generally design, so we need to consider
>> this situation: the power supply getting the charger type by accessing
>> PMIC registers. The registers which save the charger type are not
>> always belong to the USB PHY, may be just some registers on PMIC.
>
> If the power_supply can directly detect the type of charger, then it
> doesn't need any usb-charger-infrastructure to tell it.  It can handle
> current selection entirely internally.
> Surely the only interesting case for a framework to address is the one
> where the power_supply cannot directly detect the charger type.

But power supply also need one plugged or unplugged event to set
current from USB charger framework. Another hand, considering one
generic framework, since power supply support API (e.g.:
power_supply_get_property()) to get charger type for others, we should
integrate power supply into USB charger framework.

>
>>
>> Now in mainline kernel, there are 3 methods can get the charger type
>> which need to integrate with USB charger framework:
>> 1. power supply
>> 2. extcon (need to add as you suggested)
>> 3. others (by 'get_charger_type' callback of USB charger)
>
> There is no "get_charger_type" now in the mainline kernel.

We want to create one generic framework, thus we should consider some
users want to implement the function to get charger type by accessing
PMIC registers or else.

>
>>>>
>>>> Suppose the USB configuration requests 100mA, then we should set the
>>>> USB charger current is 100mA by __usb_charger_set_cur_limit_by_type()
>>>> funtion, then notify this to power driver.
>>>
>>> ahh.... I had missed something there.  It's a while since I looked
>>> closely at these patches.
>>>
>>> Only.... this usage of usb_charger_set_cur_limit_by_type() is really
>>> nonsensical.
>>>
>>> If the cable is detected as being DCP or CDP or ACA (or ACA/DOCK) then
>>> the number negotiated with the USB configuration is not relevant and
>>> should be ignored.  There is a guaranteed minimum which is at least the
>>> maximum that *can* be negotiated.
>>
>> Yes. If it is not relevant, we will no't set the current from USB
>> configuration. Just when your charger type is SDP and the USB
>> enumeration is done, we can get the USB configuration from host to set
>> current.
>
> But you do!
> The mA number from the USB configuration is passed to usb_gadget_vbus_draw.
> Your patch passes that to usb_charger_set_cur_limit_by_type()
> which calls __usb_charger_set_cur_limit_by_type() which will set the
> cur_limit for whichever type uchger->type currently is.
>
> So when it is not relevant, your code *does* set some current limit.

Suppose the charger type is DCP(it is not relevant to the mA number
from the USB configuration ), it will not do the USB enumeration, then
no USB configuration from host to set current.

-- 
Baolin.wang
Best Regards
