From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v5 06/11] i2c: core: Convert to
 dev_pm_domain_attach|detach()
Date: Mon, 22 Sep 2014 12:52:53 +0300
Message-ID: <20140922095253.GO1786@lahna.fi.intel.com>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <1411151264-16245-7-git-send-email-ulf.hansson@linaro.org>
 <20140920122318.GC3850@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140920122318.GC3850@katana>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Sat, Sep 20, 2014 at 02:23:19PM +0200, Wolfram Sang wrote:
> On Fri, Sep 19, 2014 at 08:27:39PM +0200, Ulf Hansson wrote:
> > Previously only the ACPI PM domain was supported by the i2c bus.
> > 
> > Let's convert to the common attach/detach functions for PM domains,
> > which currently means we are extending the support to include the
> > generic PM domain as well.
> > 
> > Cc: linux-i2c@vger.kernel.org
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Reviewed-by: Kevin Hilman <khilman@linaro.org>
> 
> Looks good to me, but I'd like to give Mika a chance to look at it,
> since he does ACPI with I2C. Adding to CC.

Looks fine to me.
