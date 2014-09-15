From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [v4,1/9] ACPI / PM: Let acpi_dev_pm_detach() return an error code
Date: Tue, 16 Sep 2014 01:36:15 +0200
Message-ID: <4451285.EDb1j6ttbA@vostro.rjw.lan>
References: <1410262570-22785-2-git-send-email-ulf.hansson@linaro.org> <6318611.DnX9cEgMjk@vostro.rjw.lan> <20140915165359.GA13080@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59712 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754769AbaIOXQo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Sep 2014 19:16:44 -0400
In-Reply-To: <20140915165359.GA13080@core.coreip.homeip.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Russell King <linux@arm.linux.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chris Ball <chris@printf.net>, linux-acpi@vger.kernel.org, Simon Horman <horms@verge.net.au>, Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@kernel.org>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org

On Monday, September 15, 2014 09:53:59 AM Dmitry Torokhov wrote:
> On Sun, Sep 14, 2014 at 06:38:58PM +0200, Rafael J. Wysocki wrote:
> > On Friday, September 12, 2014 02:05:53 PM Dmitry Torokhov wrote:
> > > Hi Ulf,
> > > 
> > > On Tue, Sep 09, 2014 at 01:36:02PM +0200, Ulf Hansson wrote:
> > > > To give callers the option of acting on a errors while removing the
> > > > pm_domain ops for the device in the ACPI PM domain, let
> > > > acpi_dev_pm_detach() return an int to provide the error code.
> > > 
> > > So how would callers handle the errors? As far as I can see
> > > acpi_dev_pm_detach() is called from ->remove() and ->shutdown() methods, where
> > > there is no meaningful strategy to handle errors as you are past the point of
> > > no return and you keep on tearing down the device.
> > 
> > This is specifically for what patch [3/9] is doing AFAICS.  
> > 
> > The existing callers don't need to worry about this.
> 
> OK, so I have the very same comment about patch 3 then: we have
> dev_pm_domain_detach() returning error. How would the callers handle errors?

Ulf?

> WRT this patch: I'd rater we did not just return generic "error code" just
> because we do not know who manages PD for the device. Can we add API to check
> if we are using ACPI to manage power domains? Then patch #3 could check if it
> needs to use ACPI or generic power domain API.

The rule is that if there is an ACPI companion object for the given device, then
ACPI is used.  So the API is ACPI_COMPANION(dev) and we have that check around
until someone realized that acpi_dev_pm_attach/detach() made it too.  We can
restore it, I suppose, but I'm not sure how much better it is going to be.

Either way, I have no strong preferences here.

Rafael

