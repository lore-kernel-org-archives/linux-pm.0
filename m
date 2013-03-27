From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v5 0/8] Reset controller API to reset IP modules on
 i.MX5 and i.MX6
Date: Wed, 27 Mar 2013 09:43:10 +0100
Message-ID: <1364373790.5442.5.camel@pizza.hi.pengutronix.de>
References: <1364231189-12497-1-git-send-email-p.zabel@pengutronix.de>
	 <20130326181909.GA31593@amd.pavel.ucw.cz>
	 <201303262213.39068.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33972 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777Ab3C0Inu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 04:43:50 -0400
In-Reply-To: <201303262213.39068.marex@denx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Pavel Machek <pavel@denx.de>, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@wwwdotorg.org>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

Hi Marek,

thanks for the review.

Am Dienstag, den 26.03.2013, 22:13 +0100 schrieb Marek Vasut:
> Dear Pavel Machek,
> 
> > Hi!
> > 
> > > The system reset controller (SRC) on i.MX51, i.MX53, and i.MX6q controls
> > > reset lines to the GPU, VPU, IPU, and OpenVG IP modules.
> > > 
> > > The following patches add a simple API for devices to request being reset
> > > by separate reset controller hardware and implements the reset signal
> > > device tree binding proposed by Stephen Warren. Contrary to Tegra
> > > hardware, the i.MX SRC contains self-deasserting reset registers, so
> > > I've included both ops to manually assert/deassert a reset line, as well
> > > as a "reset" operation that is supposed to assert the reset line and
> > > wait for it to deassert.
> > > 
> > > The i.MX SRC is enhanced to provide a reset controller and the IPU driver
> > > is made to request being reset by calling the device_reset(&pdev->dev)
> > > convenience wrapper during probing.
> > > 
> > > Changes since v4:
> > >  - removed flags parameter from .of_xlate / of_reset_simple_xlate
> > >  - warn also if reset_spec->args_count > rcdev->of_reset_n_cells
> > >  - unlock list mutex only after try_module_get
> > >  - tighten devm_reset_control_match a bit
> > 
> > Series looks mostly ok to me. (Should the last patch be actually
> > first, so that reset functionality is kept between 5/8 and 8/8?)
> 
> Not first, but rather third.
> 
> You can add my
> Reviewed-by: Marek Vasut <marex@denx.de>

The gpio-reset driver is not used yet, so there are no ordering
limitations. Still, grouping them together as you suggest sounds
sensible to me.

regards
Philipp

