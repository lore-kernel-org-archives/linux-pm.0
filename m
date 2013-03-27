From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v5 0/8] Reset controller API to reset IP modules on i.MX5
 and i.MX6
Date: Wed, 27 Mar 2013 20:09:32 +0800
Message-ID: <20130327120930.GB2674@S2101-09.ap.freescale.net>
References: <1364231189-12497-1-git-send-email-p.zabel@pengutronix.de>
 <20130326181909.GA31593@amd.pavel.ucw.cz>
 <201303262213.39068.marex@denx.de>
 <1364373790.5442.5.camel@pizza.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-db8lp0186.outbound.messaging.microsoft.com ([213.199.154.186]:37910
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753897Ab3C0MJz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 08:09:55 -0400
Content-Disposition: inline
In-Reply-To: <1364373790.5442.5.camel@pizza.hi.pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marek Vasut <marex@denx.de>, Pavel Machek <pavel@denx.de>, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@wwwdotorg.org>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

On Wed, Mar 27, 2013 at 09:43:10AM +0100, Philipp Zabel wrote:
> > > Series looks mostly ok to me. (Should the last patch be actually
> > > first, so that reset functionality is kept between 5/8 and 8/8?)
> > 
> > Not first, but rather third.
> > 
> > You can add my
> > Reviewed-by: Marek Vasut <marex@denx.de>
> 
> The gpio-reset driver is not used yet, so there are no ordering
> limitations. Still, grouping them together as you suggest sounds
> sensible to me.

Yea, I think we should try to get those three patches in first.  I guess
you can try ask Greg or Arnd to handle the patches.

Shawn

