From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 7/7] mfd: ab8500: Decrement the power supply's device
 reference counter
Date: Tue, 04 Nov 2014 08:50:09 +0100
Message-ID: <1415087409.2389.2.camel@AMDC1943>
References: <1413290117-13082-1-git-send-email-k.kozlowski@samsung.com>
 <1413290117-13082-8-git-send-email-k.kozlowski@samsung.com>
 <20141103175945.GV12011@x1> <20141103180059.GW12011@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32049 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbaKDHuP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Nov 2014 02:50:15 -0500
In-reply-to: <20141103180059.GW12011@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>, Pavel Machek <pavel@ucw.cz>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On pon, 2014-11-03 at 18:00 +0000, Lee Jones wrote:
> On Mon, 03 Nov 2014, Lee Jones wrote:
> 
> > On Tue, 14 Oct 2014, Krzysztof Kozlowski wrote:
> > 
> > > Use power_supply_put() to decrement the power supply's device reference
> > > counter.
> > > 
> > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > ---
> > >  drivers/mfd/ab8500-sysctrl.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > 
> > Applied, thanks.
> 
> Whoops, to hasty there -- unapplied.
> 
> What's going on with this set?

The set should be pulled at once (everything depends on 1st patch).

It is still waiting for reviews. I'll resend soon.

Best regards,
Krzysztof

> 
> > > diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
> > > index 93b2d2c32ca3..d05a5719cfc4 100644
> > > --- a/drivers/mfd/ab8500-sysctrl.c
> > > +++ b/drivers/mfd/ab8500-sysctrl.c
> > > @@ -51,6 +51,7 @@ static void ab8500_power_off(void)
> > >  
> > >  		ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
> > >  				&val);
> > > +		power_supply_put(psy);
> > >  
> > >  		if (!ret && val.intval) {
> > >  			charger_present = true;
> > > @@ -73,6 +74,7 @@ static void ab8500_power_off(void)
> > >  			       pss[i]);
> > >  			machine_restart("charging");
> > >  		}
> > > +		power_supply_put(psy);
> > >  	}
> > >  
> > >  shutdown:
> > 
> 

