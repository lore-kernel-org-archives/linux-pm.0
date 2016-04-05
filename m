From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v9 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 5 Apr 2016 15:54:31 +0800
Message-ID: <CAMz4kuKWpFLbYJM+m3syT+aMNVxjBipU_3=qwz=X0L_oB5bR0w@mail.gmail.com>
References: <cover.1459494743.git.baolin.wang@linaro.org>
	<20160405064637.GA31351@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160405064637.GA31351@shlinux2.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Peter,

On 5 April 2016 at 14:46, Peter Chen <hzpeterchen@gmail.com> wrote:
>
> We are thinking USB charger framework for Freescale i.mx SoC series,
> since our internal framework is not good enough.
> So I have more questions for your framework since there are many
> different USB charger designs, and I hope it is universal.

Great, thanks for your attention and suggestions.

>
> - I would like to see your all code to let the charger work, eg
> you have said the charger detection is done by PMIC automatically,
> but I did not find your PMIC code to read charger type.

Yeah, this patchset did not give an example to read charger type from
PMIC registers. (Cause now the user 'wm831x_power' don't need this.)
But I think user can get it easily by implementing below callbacks.
(1) gadget->ops->get_charger_type();
(2) power_supply_get_property(uchger->psy, POWER_SUPPLY_PROP_CHARGE_TYPE, &val);
(3) uchger->get_charger_type();

In some solutions, when one cable is plugin, the PMIC will detect the
charger type automatically and you can read it from PMIC registers
then. Then maybe one interrupt or other ways to report to gadget to do
enumeration. So user can read the PMIC registers to get charger type
by implementing any above methods.

>
> Besides, how you can make sure the charger detection has finished
> before the framework handles USB_CHARGER_PRESENT event?

I think we don't need to care about this situation. If the charger
type is 'UNKNOWN_TYPE' (maybe charger detection is not finished yet),
the charger framework will not set current (current is 0) for power
driver.

>
> - I commented the current limit at different situations for USB
> charger last time, but I have not seen your further comments.
> I would like give it again. For DCP, you can notify charger IC
> once you get the charger type. But for CDP/SDP, you need to
> notify charger IC after set configuration has finished, since
> the host may still not be ready to give high current.

As my understanding, if the usb charger framework get the charger
type, it means we can notify the power driver to set the current. If
you don't ready for setting current, please don't give the charger
type to usb charger framework.

The framework does not want to focus on charger detection too much,
and just supplies one callback '->charger_detect()' for user to be
implemented if they ensure they need to do the SW charger detection
manually (Note: must at the right time to do the SW detection.). So
the usb charger just focus on dealing with the usb gadget power
negotiation, and it does not need to care much how to do charger
detection on your platform.

>
> --
>
> Best Regards,
> Peter Chen



-- 
Baolin.wang
Best Regards
