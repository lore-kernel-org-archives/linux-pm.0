From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 00/11] PM / Domains: Generic OF-based support
Date: Mon, 22 Sep 2014 16:19:54 +0200
Message-ID: <2161168.GXttgFlE1X@vostro.rjw.lan>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org> <20140919184849.GA14832@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64403 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753858AbaIVOAI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Sep 2014 10:00:08 -0400
In-Reply-To: <20140919184849.GA14832@core.coreip.homeip.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>

On Friday, September 19, 2014 11:48:49 AM Dmitry Torokhov wrote:
> Hi Ulf,
> 
> On Fri, Sep 19, 2014 at 08:27:33PM +0200, Ulf Hansson wrote:
> > Changes in v5:
> > 	- Converted dev_pm_domain_detach() to a void function
> > 	- Added a ->detach() callback to the PM domain struct, invoked from the
> > 	  dev_pm_domain_detach().
> > 	- Make ACPI and genpd both assign the ->detach() callback at successfull
> > 	  attachment.
> > 	- The above changes made it possible to make acpi_pm_domain_detach() to
> > 	  be static, added a separate patch for that.
> 
> Thank you for making these changes. For the series:
> 
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I've queued up this patchset for 3.18 (I fixed up the two minor issues pointed
to by Geert in the process).

Thanks everyone!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
