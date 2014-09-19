From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 00/11] PM / Domains: Generic OF-based support
Date: Fri, 19 Sep 2014 11:48:49 -0700
Message-ID: <20140919184849.GA14832@core.coreip.homeip.net>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

On Fri, Sep 19, 2014 at 08:27:33PM +0200, Ulf Hansson wrote:
> Changes in v5:
> 	- Converted dev_pm_domain_detach() to a void function
> 	- Added a ->detach() callback to the PM domain struct, invoked from the
> 	  dev_pm_domain_detach().
> 	- Make ACPI and genpd both assign the ->detach() callback at successfull
> 	  attachment.
> 	- The above changes made it possible to make acpi_pm_domain_detach() to
> 	  be static, added a separate patch for that.

Thank you for making these changes. For the series:

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
