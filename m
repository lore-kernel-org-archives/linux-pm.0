From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 8/8] reset: Add driver for gpio-controlled reset pins
Date: Tue, 28 May 2013 17:05:46 +0200
Message-ID: <1369753546.4000.4.camel@pizza.hi.pengutronix.de>
References: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>
	 <1361878774-6382-9-git-send-email-p.zabel@pengutronix.de>
	 <CAOMZO5BJ7h=_cqSUG6X25SHTMe5ym1_nToj5P_PMR9bxN+B2Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57705 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934491Ab3E1PHG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2013 11:07:06 -0400
In-Reply-To: <CAOMZO5BJ7h=_cqSUG6X25SHTMe5ym1_nToj5P_PMR9bxN+B2Ow@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Mike Turquette <mturquette@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, devicetree-discuss@lists.ozlabs.org

Hi Fabio,

Am Montag, den 27.05.2013, 13:25 -0300 schrieb Fabio Estevam:
> On Tue, Feb 26, 2013 at 8:39 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > This driver implements a reset controller device that toggles gpios
> > connected to reset pins of peripheral ICs. The delay between assertion
> > and de-assertion of the reset signal can be configured.
> >
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Looks good and it is a very useful binding.
> 
> Will anyone apply this?

I have tried to address Olof's concerns by making the gpio-reset driver
only handle a single gpio per device.

I'll send a new patch for review.

regards
Philipp

