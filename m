From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 15 Nov 2016 13:03:22 +0800
Message-ID: <20161115050322.GA22087@b29397-desktop>
References: <CAMz4kuJPenbqf935EGW67UeqOiP48_Ti1Jf5YfJ_K=DEcrz++Q@mail.gmail.com>
 <87a8dls7yn.fsf@notabene.neil.brown.name>
 <CAMz4kuJdp+ijur_mDjcG3aghn8Q1gnJsTfFWBEiKWcdVQPMj7g@mail.gmail.com>
 <871sytqrqh.fsf@notabene.neil.brown.name>
 <CAMz4kuJV5wiCpWJF=-YpTf1sjNrOqjc53iRYmGoEQepqtrfUdA@mail.gmail.com>
 <87a8dbni27.fsf@notabene.neil.brown.name>
 <CAMz4ku+qY4U7=v5nEBEdPTjwki8j10jYbQuokz785NEy5SzYmg@mail.gmail.com>
 <87eg2ek7ye.fsf@notabene.neil.brown.name>
 <20161114120430.hpnetdedyofhlkad@sirena.org.uk>
 <87mvh1iw32.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87mvh1iw32.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 15, 2016 at 08:35:13AM +1100, NeilBrown wrote:
> On Mon, Nov 14 2016, Mark Brown wrote:
> 
> > On Mon, Nov 14, 2016 at 03:21:13PM +1100, NeilBrown wrote:
> >> On Thu, Nov 10 2016, Baolin Wang wrote:
> >
> >> > Fourth, we need integrate all charger plugin/out
> >> > event in one framework, not from extcon, maybe type-c in future.
> >
> >> Why not extcon?  Given that a charger is connected by an external
> >> connector, extcon seems like exactly the right thing to use.
> >
> >> Obviously extcon doesn't report the current that was negotiated, but
> >> that is best kept separate.  The battery charger can be advised of the
> >> available current either via extcon or separately via the usb
> >> subsystem.  Don't conflate the two.
> >
> > Conflating the two seems like the whole point here.  We're looking for
> > something that sits between the power supply code and the USB code and
> > tells the power supply code what it's allowed to do which is the result
> > of a combination of physical cable detection and USB protocol.  It seems
> > reasonable that extcon drivers ought to be part of this but it doesn't
> > seem like they are the whole story.
> 
> I don't think "between the power supply code and the USB code" is where
> this thing sits. I think it sits inside the power-supply driver.
> We already have extcon which sits between the phy and the power_supply
> code, and the usb_notifier which sits between the USB code and the
> power supply code.  We don't need another go-between.
> 
> If we have extcon able to deliver reliable information about cable type,
> and if with have the usb notifier able to deliver reliable information
> about negotiated current, and if the power supply manager is able to
> register with the correct extcon and the correct usb notifier, then the
> power supply manager *could* handle all the notifications and make the
> correct determinations and set the current limits itself.  All this
> could be done entirely internally, without the help of any new
> subsystem.
> Do you agree?

Through the USB gadget/phy framework (usb_gadget.vbus_draw->usb_phy.set_power)
we can get the USB bus information when the device connects SDP, but the
enum usb_phy_events lacks some events like bus suspend (2mA), and bus
speed (high/super speed, 500mA vs 900mA). Besides many USB PHYs use
generic PHY driver now, it is lack of above event and related notifier.

About getting cable type, the key points are detect vbus and negotiate
the charger type, these two stuffs are much different among platforms.
Extcon has charger type definition, it is good, we can use it.
But it needs the device which has charger detection function as extcon
device too, and at meanwhile, this device needs to have vbus detect
function, most pmic devices are suitable for that, but not for USB PHY.

Asssume wm831x as a power client, according your suggestion, does its
design like below?
At dts, it needs to be described like below:
&wm831x {
	...
	phy-dev = <&usb_phy>;
	extcon-dev = <&extcon>;
	...
}
And at wm831x driver, it gets information through extcon-dev and phy-dev
notifier, and it needs knowledge about current limit for specific
cable type, but these information are from USB (Charger) specification.

Your suggestion is trying use current notifications to get the
information for power client, this patch set is trying to keep
these two notifications at an new framework, and power client
gets refined notification from this new framework.

The biggest problem I concern about your solution is extcon device, it may
not be an universal solution, does current frameworks have a way to
get cable type (usb charger type)? If not, we may need to have a new
framework.

-- 

Best Regards,
Peter Chen
