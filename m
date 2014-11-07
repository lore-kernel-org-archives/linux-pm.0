From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v9 2/4] amba: Don't unprepare the clocks if device driver
 wants IRQ safe runtime PM
Date: Fri, 07 Nov 2014 14:21:48 +0100
Message-ID: <1415366508.31102.10.camel@AMDC1943>
References: <1415105570-7871-1-git-send-email-k.kozlowski@samsung.com>
 <1415105570-7871-3-git-send-email-k.kozlowski@samsung.com>
 <20141104201834.GC15071@amd> <1415176978.15850.11.camel@AMDC1943>
 <20141107121320.GA20419@amd> <1415362683.31102.6.camel@AMDC1943>
 <20141107122850.GB20419@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33775 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbaKGNVx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 08:21:53 -0500
In-reply-to: <20141107122850.GB20419@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Jonathan Corbet <corbet@lwn.net>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On pi=C4=85, 2014-11-07 at 13:28 +0100, Pavel Machek wrote:
> On Fri 2014-11-07 13:18:03, Krzysztof Kozlowski wrote:
> > On pi=C4=85, 2014-11-07 at 13:13 +0100, Pavel Machek wrote:
> > > On Wed 2014-11-05 09:42:58, Krzysztof Kozlowski wrote:
> > > > On wto, 2014-11-04 at 21:18 +0100, Pavel Machek wrote:
> > > > > On Tue 2014-11-04 13:52:48, Krzysztof Kozlowski wrote:
> > > > > > The AMBA bus driver defines runtime Power Management functi=
ons which
> > > > > > disable and unprepare AMBA bus clock. This is problematic f=
or runtime PM
> > > > > > because unpreparing a clock might sleep so it is not interr=
upt safe.
> > > > > >=20
> > > > > > However some drivers may want to implement runtime PM funct=
ions in
> > > > > > interrupt-safe way (see pm_runtime_irq_safe()). In such cas=
e the AMBA
> > > > > > bus driver should only disable/enable the clock in runtime =
suspend and
> > > > > > resume callbacks.
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > >  /*
> > > > > >   * Hooks to provide runtime PM of the pclk (bus clock).  I=
t is safe to
> > > > > >   * enable/disable the bus clock at runtime PM suspend/resu=
me as this
> > > > > > @@ -95,8 +102,14 @@ static int amba_pm_runtime_suspend(stru=
ct device *dev)
> > > > > >  	struct amba_device *pcdev =3D to_amba_device(dev);
> > > > > >  	int ret =3D pm_generic_runtime_suspend(dev);
> > > > > > =20
> > > > > > -	if (ret =3D=3D 0 && dev->driver)
> > > > > > -		clk_disable_unprepare(pcdev->pclk);
> > > > > > +	if (ret =3D=3D 0 && dev->driver) {
> > > > > > +		pcdev->irq_safe =3D get_pm_runtime_irq_safe(dev);
> > > > > > +
> > > > > > +		if (pcdev->irq_safe)
> > > > > > +			clk_disable(pcdev->pclk);
> > > > > > +		else
> > > > > > +			clk_disable_unprepare(pcdev->pclk);
> > > > > > +	}
> > > > >=20
> > > > > So you can handle the case of !pcdev->irq_safe. What is the p=
enalty
> > > > > for always assuming !pcdev->irq_safe?
> > > >=20
> > > > The penalty (for pl330 driver) would be that the runtime resume=
/suspend
> > > > cannot happen from atomic context
> > > >   =3D> pm_runtime_get_sync() cannot be called from atomic conte=
xt
> > > >     =3D> complete rework of runtime PM for pl330 DMA driver bec=
ause now
> > > >        one of pm_runtime_get_sync() calls is in device_issue_pe=
nding
> > > >        callback which may not sleep. And by "rework" I also mea=
n that
> > > >        I do not know how to do this... yet.
> > >=20
> > > I still don't get it. You say that you don't know how to handle
> > > !pcdev->irq_safe case... Yet have code above that tries to handle=
 it.
> > >=20
> > > If that case can't be sanely handled, I'd expect
> > > BUG_ON(!pcdev->irq_safe).
> >=20
> > Hmmm... I could misunderstand your question. The amba/bus.c driver =
can
> > handle both cases. However this varies for child drivers (which use
> > these runtime PM callbacks too). For pl330 cannot handle non-irq-sa=
fe.
> > Other drivers can.
>=20
> Ok, so pl330 can't handle non-irq-safe callbacks. What about the othe=
r
> solution preserving consistency -- can we make sure all callbacks are
> irq-safe with acceptable penalty?

Aaahhh, I get it. We could revert 5303c0f46c87 ("ARM: 7916/1: amba: Add
clk_prepare|unprepare in runtime PM callbacks"). After quick grep
through amba drivers it seems that this should work and the only impact
would be that less energy could be saved on other drivers (clock only
disabled, not unprepared).

However someone more experienced in amba drivers should confirm this.

Best regards,
Krzysztof


