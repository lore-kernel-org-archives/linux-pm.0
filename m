From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 7/7] mfd: ab8500: Decrement the power supply's device
 reference counter
Date: Thu, 16 Oct 2014 14:41:14 +0200
Message-ID: <1413463274.18828.1.camel@AMDC1943>
References: <1413445327-24862-1-git-send-email-k.kozlowski@samsung.com>
 <1413445327-24862-8-git-send-email-k.kozlowski@samsung.com>
 <20141016122901.GA22725@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:52969 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbaJPMlT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Oct 2014 08:41:19 -0400
In-reply-to: <20141016122901.GA22725@lee--X1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>, Pavel Machek <pavel@ucw.cz>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On czw, 2014-10-16 at 14:29 +0200, Lee Jones wrote:
> On Thu, 16 Oct 2014, Krzysztof Kozlowski wrote:
> 
> > Use power_supply_put() to decrement the power supply's device reference
> > counter.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> I already Acked this.

I think you acked mfd change in my first patchset
(power_supply_get_property()):
	[PATCH 5/8] mfd: ab8500: Use power_supply_*() API for accessing
function attrs

... and this is my second patchset with other API (power_supply_put).

Best regards,
Krzysztof


> 
> > ---
> >  drivers/mfd/ab8500-sysctrl.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
> > index 93b2d2c32ca3..d05a5719cfc4 100644
> > --- a/drivers/mfd/ab8500-sysctrl.c
> > +++ b/drivers/mfd/ab8500-sysctrl.c
> > @@ -51,6 +51,7 @@ static void ab8500_power_off(void)
> >  
> >  		ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
> >  				&val);
> > +		power_supply_put(psy);
> >  
> >  		if (!ret && val.intval) {
> >  			charger_present = true;
> > @@ -73,6 +74,7 @@ static void ab8500_power_off(void)
> >  			       pss[i]);
> >  			machine_restart("charging");
> >  		}
> > +		power_supply_put(psy);
> >  	}
> >  
> >  shutdown:
> 

