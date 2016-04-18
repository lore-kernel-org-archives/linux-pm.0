From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Mon, 18 Apr 2016 12:23:16 +0200
Message-ID: <20160418102316.GA27936@amd>
References: <cover.1458128215.git.baolin.wang@linaro.org>
 <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org>
 <87h9foqnur.fsf@intel.com>
 <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com>
 <87poubgnbh.fsf@intel.com>
 <20160322113012.GC26924@xo-6d-61-c0.localdomain>
 <87fuujgwsm.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34904 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbcDRKXU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2016 06:23:20 -0400
Content-Disposition: inline
In-Reply-To: <87fuujgwsm.fsf@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

Hi!

> >> >>> +#define DEFAULT_SDP_CUR_LIMIT        (500 - DEFAULT_CUR_PROTECT)
> >> >>
> >> >> According to the spec we should always be talking about unit loads (1
> >> >> unit load is 100mA for HS/FS/LS and 150mA for SS). Also, this will not
> >> >> work for SS capable ports and SS gadgets (we have quite a few of them,
> >> >> actually). You're missing the opportunity of charging at 900mA.
> >> >
> >> > I follow the DCP/SDP/CDP/ACA type's default current limitation and
> >> > user can set them what they want.
> >> 
> >> no, the user CANNOT set it to what they want. If you get enumerated
> >> @100mA and the user just decides to set it to 2000mA, s/he could even
> >> melt the USB connector. The kernel _must_ prevent such cases.
> >
> > root should be allowed to do that.
> 
> root should not be allowed to put user at risk. The usb connector is a
> path to earth ground in most (all?) desktop computers. Allowing root to
> put that connector in a situation where it could melt the connector and
> short mains should never be allowed.

Be sure that hardware people put reasonable precautions...

> > Very often, you want to charge using 1.8A from an old desktop PC.
> 
> if that old desktop's port is not a charging port, you shouldn't be
> allowed to do that. Not ever.

Yes, Felipe just decided that I should not be able to charge my N900
in useful way.

> > N900 will simply not charge from .5A.
> 
> it used to with original maemo userspace/kernel.

Yeah, at about 10% per night.

> >> a) you are connected to a dedicated charger
> >> 
> >> 	In this case, you can get up to 2000mA depending on the charger.
> >> 
> >> 	If $this charger can give you or not 2000mA is not detectable,
> >> 	so what do charging ICs do ? They slowly increase the attached
> >> 	load accross VBUS/GND and measure VBUS value. When IC notices
> >> 	VBUS dropping bit, step back to previous load.
> >> 
> >> 	This means you will always charger with maximum rating of DCP.
> >> 
> >> 	Why would user change this ? More is unsafe, less is just
> >> 	stupid.
> >
> > Actually, less is not stupid. Charging li-ion battery from li-ion battery might
> > be stupid. Imagine I'm on train, with device like N900 (50% battery) and power bank
> > (3Ah). I'm actively using the device. If I let it charge at full current, I'll waste
> > energy. If I limit current to approximately the power consumption, it will run the
> > powerbank empty, first, then empty the internal battery, maximizing total time I
> > can use the device.
> 
> why would you waste energy ? What the charger chip would do is charge
> battery to maximum then just to maintenance charge from that point
> on. Where is energy being wasted other than normal heat dissipation ?

Physics 101, of course wasted energy goes to heat. Lets not waste
energy by charging li-ion from li-ion when it is not required.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
