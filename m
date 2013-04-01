From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v6 0/8] Reset controller API to reset IP modules on i.MX5
 and i.MX6
Date: Mon, 1 Apr 2013 14:23:34 +0800
Message-ID: <20130401062332.GB1693@S2101-09.ap.freescale.net>
References: <1364488523-20310-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:33896
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757715Ab3DAGXZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Apr 2013 02:23:25 -0400
Content-Disposition: inline
In-Reply-To: <1364488523-20310-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Warren <swarren@wwwdotorg.org>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

On Thu, Mar 28, 2013 at 05:35:15PM +0100, Philipp Zabel wrote:
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
> No changes since v5, I just reordered the series.

All applied, thanks.

