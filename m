From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH v5 0/8] Reset controller API to reset IP modules on
 i.MX5 and i.MX6
Date: Tue, 26 Mar 2013 19:19:09 +0100
Message-ID: <20130326181909.GA31593@amd.pavel.ucw.cz>
References: <1364231189-12497-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35397 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730Ab3CZSTQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Mar 2013 14:19:16 -0400
Content-Disposition: inline
In-Reply-To: <1364231189-12497-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@wwwdotorg.org>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

Hi!

> The system reset controller (SRC) on i.MX51, i.MX53, and i.MX6q controls
> reset lines to the GPU, VPU, IPU, and OpenVG IP modules.
> 
> The following patches add a simple API for devices to request being reset
> by separate reset controller hardware and implements the reset signal
> device tree binding proposed by Stephen Warren. Contrary to Tegra hardware,
> the i.MX SRC contains self-deasserting reset registers, so I've included
> both ops to manually assert/deassert a reset line, as well as a "reset"
> operation that is supposed to assert the reset line and wait for it to
> deassert.
> 
> The i.MX SRC is enhanced to provide a reset controller and the IPU driver
> is made to request being reset by calling the device_reset(&pdev->dev)
> convenience wrapper during probing.
> 
> Changes since v4:
>  - removed flags parameter from .of_xlate / of_reset_simple_xlate
>  - warn also if reset_spec->args_count > rcdev->of_reset_n_cells
>  - unlock list mutex only after try_module_get
>  - tighten devm_reset_control_match a bit

Series looks mostly ok to me. (Should the last patch be actually
first, so that reset functionality is kept between 5/8 and 8/8?)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
