From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v19 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Fri, 10 Mar 2017 18:52:14 +0800
Message-ID: <CAMz4ku+jy-Z0L4avYsDGstNnV+f=XhjmP8WS9SLOkB1eGWjjXA@mail.gmail.com>
References: <cover.1487578977.git.baolin.wang@linaro.org> <87zih3m73h.fsf@notabene.neil.brown.name>
 <CAMz4ku+98HAgVnMoCg0YaPpcY1NvdKdbK6AuDyzgNOrcbpaz9A@mail.gmail.com>
 <AM5PR04MB29614C707DE344E5A05FAB3889210@AM5PR04MB2961.eurprd04.prod.outlook.com>
 <CAMz4kuJ31wVhbYOV+LB9tu=Wb7x9gRifcUnQPMiQSqRUjER_kQ@mail.gmail.com>
 <AM5PR04MB296177A37D96564D510FA90389210@AM5PR04MB2961.eurprd04.prod.outlook.com>
 <CAMz4ku+wkZ7webuCK+V9DPuDzdT_Tyy6Dso8==bQPyN9m06vGw@mail.gmail.com>
 <AM5PR04MB29610364B8FA56AE7AD8A68989200@AM5PR04MB2961.eurprd04.prod.outlook.com>
 <CAMz4kuLNa=sdYQrzXZspPd9ug-Opn2jfUCGHtq2qNT4Omax4Mw@mail.gmail.com> <AM5PR04MB29613EEC7C49426020A538B089200@AM5PR04MB2961.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM5PR04MB29613EEC7C49426020A538B089200@AM5PR04MB2961.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Li <jun.li@nxp.com>
Cc: NeilBrown <neilb@suse.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "robh@kernel.org" <robh@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfson>
List-Id: linux-pm@vger.kernel.org

On 10 March 2017 at 16:27, Jun Li <jun.li@nxp.com> wrote:
> Hi
>
>> -----Original Message-----
>> From: Baolin Wang [mailto:baolin.wang@linaro.org]
>> Sent: Friday, March 10, 2017 3:15 PM
>> To: Jun Li <jun.li@nxp.com>
>> Cc: NeilBrown <neilb@suse.com>; Felipe Balbi <balbi@kernel.org>; Greg KH
>> <gregkh@linuxfoundation.org>; Sebastian Reichel <sre@kernel.org>; Dmitry
>> Eremin-Solenikov <dbaryshkov@gmail.com>; David Woodhouse
>> <dwmw2@infradead.org>; robh@kernel.org; Marek Szyprowski
>> <m.szyprowski@samsung.com>; Ruslan Bilovol <ruslan.bilovol@gmail.com>;
>> Peter Chen <peter.chen@freescale.com>; Alan Stern
>> <stern@rowland.harvard.edu>; grygorii.strashko@ti.com; Yoshihiro Shimoda
>> <yoshihiro.shimoda.uh@renesas.com>; Lee Jones <lee.jones@linaro.org>;
>> Mark Brown <broonie@kernel.org>; John Stultz <john.stultz@linaro.org>;
>> Charles Keepax <ckeepax@opensource.wolfsonmicro.com>;
>> patches@opensource.wolfsonmicro.com; Linux PM list <linux-
>> pm@vger.kernel.org>; USB <linux-usb@vger.kernel.org>; device-
>> mainlining@lists.linuxfoundation.org; LKML <linux-kernel@vger.kernel.org=
>
>> Subject: Re: [PATCH v19 0/4] Introduce usb charger framework to deal wit=
h
>> the usb gadget power negotation
>>
>> On 10 March 2017 at 14:30, Jun Li <jun.li@nxp.com> wrote:
>> >> >> >
>> >> >> > Will generic phy need add extcon as well?
>> >> >>
>> >> >> Yes, will add a 'struct extcon_dev*' in 'struct usb_phy', which
>> >> >> will be common code.
>> >> >>
>> >> >
>> >> > I mean the common code need add 'struct extcon_dev' into both
>> >> > 'struct phy' and 'struct usb_phy', right? as some/new usb phy use
>> >> > that generic phy
>> >> driver.
>> >>
>> >> Ah, you remind me. Seems we need also add one 'struct extcon_dev'
>> >> into 'struct phy'.
>> >>
>> >> >> >
>> >> >> >> >
>> >> >> >> >> Secondly, I also agreed with Peter's comments: Not only USB
>> >> >> >> >> PHY to register an extcon, but also for the drivers which
>> >> >> >> >> can detect USB charger type, it may be USB controller
>> >> >> >> >> driver, USB type-c driver, pmic driver, and these drivers
>> >> >> >> >> may not have an extcon device since the internal part can fi=
nish
>> the vbus detect.
>> >> >> >> >
>> >> >> >> > Whichever part can detect vbus, the driver for that part must
>> >> >> >> > be able to find the extcon and trigger a notification.
>> >> >> >> > Maybe one part can detect VBUS, another can measure the
>> >> >> >> > resistance on ID and a third can work through the state
>> >> >> >> > machine to determine if D+ and D- are shorted together.
>> >> >> >> > Somehow these three need to work together to determine what
>> >> >> >> > is
>> >> >> >> plugged
>> >> >> >> > in to the external connection port.  Somewhere there much an
>> >> 'extcon'
>> >> >> >> > device which represents that port and which the three devices
>> >> >> >> > can find and can interact with.
>> >> >> >> > I think it makes sense for the usb_phy to be the connection p=
oint.
>> >> >> >> > Each of the devices can get to the phy, and the phy can get
>> >> >> >> > to the
>> >> >> extcon.
>> >> >> >> > It doesn't matter very much if the usb phy driver creates the
>> >> >> >> > extcon, or if something else creates the extcon and the phy
>> >> >> >> > driver performs a lookup to find it (e.g. based on devicetree=
 info).
>> >> >> >> >
>> >> >> >> > The point is that there is obviously an external physical
>> >> >> >> > connection, and so there should be an 'extcon' device that
>> >> represents it.
>> >> >> >>
>> >> >> >> Peter & Jun, is it OK for you every phy has one extcon device
>> >> >> >> to receive VBUS notification, especially for detecting the
>> >> >> >> charger type by
>> >> >> software?
>> >> >> >>
>> >> >> >
>> >> >> > My understanding is phy/usb_phy as the connection point, will
>> >> >> > send the notification to PMIC driver which actually control the
>> >> >> > charge current, also this will be done in your common framework,
>> right?
>> >> >>
>> >> >> Not in USB charger framework. If we are all agree every usb_phy
>> >> >> can register one extcon device, can get correct charger type and
>> >> >> send out correct vbus_draw information, then we don't need USB
>> >> >> charger framework as Neil suggested. So this will be okay for your
>> >> >> case (especially for detecting the charger type by software) ?
>> >> >
>> >> > In my case, charger detection is done by controller driver and I
>> >> > need do charger type detection internally, and only pass the
>> >> > current draw info via phy which will send out, this seems ok for
>> >> > me, but I think it will be good if you or someone can show us an
>> >> > example user based on the
>> >> design Neil suggested.
>> >> > Will you work out that common code if this USB charger framework is
>> >> > not
>> >> needed?
>> >>
>> >> I will add  a 'struct extcon_dev*' in 'struct usb_phy' and struct
>> >> phy=E2=80=9C. Others are already ready if everyone has no complain ab=
out
>> >> current design, except
>> >
>> > Only adding extcon_dev into usb_phy/phy  and all others are ready?
>> > My understanding you will also do:
>> > - We need find a central place to send the notification(phy common par=
t).
>>
>> That will include these implementation when adding extcon_dev.
>>
>
> OK, thanks.
>
>> > - If the extcon_dev is directly added in usb_phy/phy, PMIC needs some
>> API to findup it.
>>
>> PMIC can find extcon device by phandle.
>
> extcon_dev(not a reference pointer) is directly added in usb_phy/phy, not=
 via devicetree,
> how PMIC find it by phandle?

>From my understanding, here we should add one pointer (extcon_dev *),
since usb phy is not one external connect device.

>
>>
>> >
>> >> my one concern. (I am afraid if it is enough to send out vbus draw
>> >> information from USB phy driver, for example you will miss super
>> >> speed (900mA), which need get the speed information from gadget
>> >> driver.)
>> >>
>> >
>> > Can we handle this in USB(so has super speed information) and just
>> > send out 900mA directly?
>>
>> From Neil's suggestion, we only have one place to send out current
>> information from usb phy, so I have this concern and doubt if we still n=
eed
>> the USB charger framework.
>
> So if put it in phy/usb_phy, this is a problem, that only one place shoul=
d have
> the infor of both speed and usb state, how about put it at usb_gadget, th=
en,
> e.g. send the notification in usb_gadget_vbus_connect()?

That is same what USB charger did, from this point, we need USB
charger to send out vbus draw information according to speed and usb
state. But I should listen to other guys suggestion. Peter and Felipe,
what do you think?

--=20
Baolin.wang
Best Regards
