From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Tue, 22 Sep 2015 10:30:42 +0200
Message-ID: <20150922083042.GK7858@pengutronix.de>
References: <1441006446-4558-1-git-send-email-s.hauer@pengutronix.de>
 <1441006446-4558-3-git-send-email-s.hauer@pengutronix.de>
 <CAGS+omCHAGrRPwM8Wghver+o5ky3MG2+JJqKiwWzHtDTQkaD4g@mail.gmail.com>
 <CAGS+omCFD1omrRA7xR6ADYOHyGDp8=Lh4JF-S9ikN9rKNyeDOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34584 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756786AbbIVIau (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2015 04:30:50 -0400
Content-Disposition: inline
In-Reply-To: <CAGS+omCFD1omrRA7xR6ADYOHyGDp8=Lh4JF-S9ikN9rKNyeDOQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Sep 22, 2015 at 03:30:47PM +0800, Daniel Kurtz wrote:
> On Mon, Sep 14, 2015 at 3:32 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> >
> > Hi Sascha,
> >
> > On Mon, Aug 31, 2015 at 3:34 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > This adds support for the Mediatek thermal controller found on MT8173
> > > and likely other SoCs.
> > > The controller is a bit special. It does not have its own ADC, instead
> > > it controls the on-SoC AUXADC via AHB bus accesses. For this reason
> > > we need the physical address of the AUXADC. Also it controls a mux
> > > using AHB bus accesses, so we need the APMIXEDSYS physical address aswell.
> > >
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> >
> > [snip...]
> >
> > > +static int mtk_read_temp(void *data, long *temp)
> > > +{
> > > +       struct mtk_thermal_bank *bank = data;
> > > +
> > > +       mtk_thermal_get_bank(bank);
> > > +
> > > +       *temp = mtk_thermal_bank_temperature(bank);
> > > +
> > > +       mtk_thermal_put_bank(bank);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
> > > +       .get_temp = mtk_read_temp,
> >
> > On v4.3-rc1, this now causes a compile warning, since the prototype
> > for get_temp was changed to:
> >
> >        int (*get_temp)(void *, int *);
> >
> > by:
> > commit 17e8351a77397e8a83727eb17e3a3e9b8ab5257a
> >     thermal: consistently use int for temperatures
> 
> It is actually a little worse than a warning.  This actually causes a
> crash on boot.
> Sascha, can you send out a rebased patch set on v4.3-rc1?

Yes, I'll send out a new version tomorrow. I am currently quite busy
with another project.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
