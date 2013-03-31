From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v6 0/8] Reset controller API to reset IP modules on i.MX5
 and i.MX6
Date: Sun, 31 Mar 2013 22:23:40 +0800
Message-ID: <20130331142339.GD17773@S2101-09.ap.freescale.net>
References: <1364488523-20310-1-git-send-email-p.zabel@pengutronix.de>
 <201303282207.54250.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:32769
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755095Ab3CaOXp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 Mar 2013 10:23:45 -0400
Content-Disposition: inline
In-Reply-To: <201303282207.54250.arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Warren <swarren@wwwdotorg.org>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Olof Johansson <olof@lixom.net>, Barry Song <Baohua.Song@csr.com>

On Thu, Mar 28, 2013 at 10:07:54PM +0000, Arnd Bergmann wrote:
> On Thursday 28 March 2013, Philipp Zabel wrote:
> > [Added Arnd and Greg to the recipients] I think the first three patches
> > of this series are candidates to go through Arnd's tree. Arnd, would you
> > take those patches?
> >         [PATCH v6 1/8] dt: describe base reset signal binding
> >         [PATCH v6 2/8] reset: Add reset controller API
> >         [PATCH v6 3/8] reset: Add driver for gpio-controlled reset pins
> 
> Wow, very nice work. I had completely missed the series so far, as I'm
> quite behind on reading mailing lists.
> 
> Yes, I can certainly take the three patches through arm-soc. Actually
> I just handed over to Olof for now, but I'm assume he will also take
> them when you send a pull request.
> 
> We also have at least one other platform (sirf/prima2) that will need
> the subsystem in the near future. I'm probably stating the obvious here,
> but  please make sure that the pull request you send for arm-soc uses
> the exact git sha1 IDs that will be used for the follow-on patches
> going through the platform trees.

Ok, let me maintain a stable branch on IMX tree and forward the patches
to arm-soc, since the other patches in the series that I need to handle
will depend on the branch anyway.

Shawn

