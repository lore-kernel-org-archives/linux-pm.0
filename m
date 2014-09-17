From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [v4,1/9] ACPI / PM: Let acpi_dev_pm_detach() return an error code
Date: Wed, 17 Sep 2014 13:10:25 -0700
Message-ID: <20140917201025.GC25297@core.coreip.homeip.net>
References: <1410262570-22785-2-git-send-email-ulf.hansson@linaro.org>
 <6318611.DnX9cEgMjk@vostro.rjw.lan>
 <20140915165359.GA13080@core.coreip.homeip.net>
 <4451285.EDb1j6ttbA@vostro.rjw.lan>
 <CAPDyKFq6FZcuU=TCMh0JE0ymbS73_eLtNrTgmgKA4OxEp=_zpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:47701 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756085AbaIQUKc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Sep 2014 16:10:32 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFq6FZcuU=TCMh0JE0ymbS73_eLtNrTgmgKA4OxEp=_zpw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Russell King <linux@arm.linux.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chris Ball <chris@printf.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@kernel.org>, Ben Dooks <ben-linux@fluff>

On Wed, Sep 17, 2014 at 08:25:44PM +0200, Ulf Hansson wrote:
> On 16 September 2014 01:36, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Monday, September 15, 2014 09:53:59 AM Dmitry Torokhov wrote:
> >> On Sun, Sep 14, 2014 at 06:38:58PM +0200, Rafael J. Wysocki wrote:
> >> > On Friday, September 12, 2014 02:05:53 PM Dmitry Torokhov wrote:
> >> > > Hi Ulf,
> >> > >
> >> > > On Tue, Sep 09, 2014 at 01:36:02PM +0200, Ulf Hansson wrote:
> >> > > > To give callers the option of acting on a errors while removing the
> >> > > > pm_domain ops for the device in the ACPI PM domain, let
> >> > > > acpi_dev_pm_detach() return an int to provide the error code.
> >> > >
> >> > > So how would callers handle the errors? As far as I can see
> >> > > acpi_dev_pm_detach() is called from ->remove() and ->shutdown() methods, where
> >> > > there is no meaningful strategy to handle errors as you are past the point of
> >> > > no return and you keep on tearing down the device.
> 
> The benefit is only relevant when ACPI and genpd PM domains would
> co-exist. In that case we might be able to skip genpd_dev_pm_detach()
> if acpi_dev_pm_detach() succeeds. So, currently there are  no benefit,
> but still it doesn't hurt.

It doe snot have any negative material effect, the drawback is purely
from API perspective.

> 
> >> >
> >> > This is specifically for what patch [3/9] is doing AFAICS.
> >> >
> >> > The existing callers don't need to worry about this.
> >>
> >> OK, so I have the very same comment about patch 3 then: we have
> >> dev_pm_domain_detach() returning error. How would the callers handle errors?
> >
> > Ulf?
> 
> I see your point. How about making dev_pm_domain_detach() to be a void
> function instead?

Yes, please.

> 
> >
> >> WRT this patch: I'd rater we did not just return generic "error code" just
> >> because we do not know who manages PD for the device. Can we add API to check
> >> if we are using ACPI to manage power domains? Then patch #3 could check if it
> >> needs to use ACPI or generic power domain API.
> 
> The problem is scalability. If we have other PM domains implementation
> in future, each of them need to be checked prior invoking the attach
> functions.
> Also, how would we distinguish between genpd and a new PM domain XYZ?

I do not think that trying all available methods to detach a pm domain,
i.e.

	err = acpi_dev_pm_detach();
	if (err)
		err = blah_dev_pm_detach();
	if (err)
		err = flab_dev_pm_detach();
	if (err)
		err = gen_dev_pm_detach();

is any better from scalability point of view. If you need to do that you
will probably have to store something like "struct pd_ops *pd_ops" in
your device and call appropriate implementation via it.

Thanks.

-- 
Dmitry
