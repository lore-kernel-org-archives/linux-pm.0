From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 00/11] PM / Domains: Generic OF-based support
Date: Wed, 24 Sep 2014 15:51:18 +0200
Message-ID: <1724421.fbdO6SWIjA@vostro.rjw.lan>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org> <2161168.GXttgFlE1X@vostro.rjw.lan> <5422BC97.6080608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5422BC97.6080608@ti.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Philipp Zabel <philipp.zabel@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-acpi@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, Chris Ball <chris@printf.net>, Simon Horman <horms@verge.net.au>, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.>
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 24, 2014 03:44:07 PM Grygorii Strashko wrote:
> Hi Rafael,
> 
> On 09/22/2014 05:19 PM, Rafael J. Wysocki wrote:
> > On Friday, September 19, 2014 11:48:49 AM Dmitry Torokhov wrote:
> >> Hi Ulf,
> >>
> >> On Fri, Sep 19, 2014 at 08:27:33PM +0200, Ulf Hansson wrote:
> >>> Changes in v5:
> >>> 	- Converted dev_pm_domain_detach() to a void function
> >>> 	- Added a ->detach() callback to the PM domain struct, invoked from the
> >>> 	  dev_pm_domain_detach().
> >>> 	- Make ACPI and genpd both assign the ->detach() callback at successfull
> >>> 	  attachment.
> >>> 	- The above changes made it possible to make acpi_pm_domain_detach() to
> >>> 	  be static, added a separate patch for that.
> >>
> >> Thank you for making these changes. For the series:
> >>
> >> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > I've queued up this patchset for 3.18 (I fixed up the two minor issues pointed
> > to by Geert in the process).
> > 
> 
> Could you point me on branch where I can find these patches?
> Also, are there any chances to have these patches  in next/linux-next.git,
> so they will become available for testing and re-using?

It is in the bleeding-edge branch of the linux-pm.git tree at the moment,
which is rebased quite often, but you can use it for testing.

It should appear in linux-next tomorrow.

Rafael

