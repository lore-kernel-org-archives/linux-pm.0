From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Wed, 5 Oct 2016 15:26:35 +0800
Message-ID: <CAMz4kuLHEv16yBDxW=peVyPB3_K27QUDyKHT0ecBZxAQR-2VXA@mail.gmail.com>
References: <cover.1470034830.git.baolin.wang@linaro.org> <CAMz4kuLotLs1ASuZaMRXf29khmQUfEQc+jFV8Fxp+fHFn90Z9g@mail.gmail.com>
 <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com>
 <8760q9a8m6.fsf@notabene.neil.brown.name> <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com>
 <878tv297a0.fsf@notabene.neil.brown.name> <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com>
 <87y4326l44.fsf@notabene.neil.brown.name> <CAMz4ku+wWcSPCA1_UYKNqJv4rRDEm5WYUc8AVT6xPJ651-rzmg@mail.gmail.com>
 <87twdo7ouz.fsf@notabene.neil.brown.name> <CAMz4kuLXyLK2jFmaoxxceq01FT4fo+N-iAtCLPyQzJh5R24uOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuLXyLK2jFmaoxxceq01FT4fo+N-iAtCLPyQzJh5R24uOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: NeilBrown <nfbrown@novell.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.ke>
List-Id: linux-pm@vger.kernel.org

Hi Felipe,

>> But you do!
>> The mA number from the USB configuration is passed to usb_gadget_vbus_draw.
>> Your patch passes that to usb_charger_set_cur_limit_by_type()
>> which calls __usb_charger_set_cur_limit_by_type() which will set the
>> cur_limit for whichever type uchger->type currently is.
>>
>> So when it is not relevant, your code *does* set some current limit.
>
> Suppose the charger type is DCP(it is not relevant to the mA number
> from the USB configuration ), it will not do the USB enumeration, then
> no USB configuration from host to set current.

>From the talking, there are some issues (thanks for Neil's comments)
need to be fixed as below:
1. Need to add the method getting charger type from extcon subsystem.
2. Need to remove the method getting charger type from power supply.
3. There are still some different views about reporting the maximum
current or minimum current to power driver.

Now the current v16 patchset can work well on my Spreadtrum platform
and Jun's NXP platform, if you like to apply this patchset then I can
send out new patches to fix above issues. If you don't like that, I
can send out new version patchset to fix above issues. Could you  give
me some suggestions what should I do next step? Thanks.

>
> --
> Baolin.wang
> Best Regards



-- 
Baolin.wang
Best Regards
