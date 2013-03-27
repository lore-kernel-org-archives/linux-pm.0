From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v5 8/8] reset: Add driver for gpio-controlled reset pins
Date: Wed, 27 Mar 2013 20:10:26 +0800
Message-ID: <20130327121024.GC2674@S2101-09.ap.freescale.net>
References: <1364231189-12497-1-git-send-email-p.zabel@pengutronix.de>
 <1364231189-12497-9-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:15159
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753571Ab3C0MKl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 08:10:41 -0400
Content-Disposition: inline
In-Reply-To: <1364231189-12497-9-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@wwwdotorg.org>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

On Mon, Mar 25, 2013 at 06:06:29PM +0100, Philipp Zabel wrote:
> This driver implements a reset controller device that toggles gpios
> connected to reset pins of peripheral ICs. The delay between assertion
> and de-assertion of the reset signal can be configured.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

