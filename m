From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [v4,1/9] ACPI / PM: Let acpi_dev_pm_detach() return an error code
Date: Sun, 14 Sep 2014 18:38:58 +0200
Message-ID: <6318611.DnX9cEgMjk@vostro.rjw.lan>
References: <1410262570-22785-2-git-send-email-ulf.hansson@linaro.org> <20140912210553.GA27924@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20140912210553.GA27924@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Russell King <linux@arm.linux.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chris Ball <chris@printf.net>, linux-acpi@vger.kernel.org, Simon Horman <horms@verge.net.au>, Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@kernel.org>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Friday, September 12, 2014 02:05:53 PM Dmitry Torokhov wrote:
> Hi Ulf,
> 
> On Tue, Sep 09, 2014 at 01:36:02PM +0200, Ulf Hansson wrote:
> > To give callers the option of acting on a errors while removing the
> > pm_domain ops for the device in the ACPI PM domain, let
> > acpi_dev_pm_detach() return an int to provide the error code.
> 
> So how would callers handle the errors? As far as I can see
> acpi_dev_pm_detach() is called from ->remove() and ->shutdown() methods, where
> there is no meaningful strategy to handle errors as you are past the point of
> no return and you keep on tearing down the device.

This is specifically for what patch [3/9] is doing AFAICS.  

The existing callers don't need to worry about this.

Rafael

