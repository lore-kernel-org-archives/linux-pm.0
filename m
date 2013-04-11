From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v6 3/8] reset: Add driver for gpio-controlled reset pins
Date: Thu, 11 Apr 2013 14:37:16 +0200
Message-ID: <1365683836.4388.54.camel@pizza.hi.pengutronix.de>
References: <1364488523-20310-1-git-send-email-p.zabel@pengutronix.de>
	 <1364488523-20310-4-git-send-email-p.zabel@pengutronix.de>
	 <CAOesGMgo61M=oxG6_6EEGu7kL3Wa+HsdEomCxUnvj-Rbdhujgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52639 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798Ab3DKMiJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2013 08:38:09 -0400
In-Reply-To: <CAOesGMgo61M=oxG6_6EEGu7kL3Wa+HsdEomCxUnvj-Rbdhujgg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Mike Turquette <mturquette@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>

Hi Olof,

Am Donnerstag, den 11.04.2013, 03:35 -0700 schrieb Olof Johansson:
> Hi,
> 
> On Thu, Mar 28, 2013 at 9:35 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > This driver implements a reset controller device that toggles gpios
> > connected to reset pins of peripheral ICs. The delay between assertion
> > and de-assertion of the reset signal can be configured.
> >
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Reviewed-by: Stephen Warren <swarren@nvidia.com>
> > Reviewed-by: Marek Vasut <marex@denx.de>
> > Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  .../devicetree/bindings/reset/gpio-reset.txt       |  37 ++++
> >  drivers/reset/Kconfig                              |  13 ++
> >  drivers/reset/Makefile                             |   1 +
> >  drivers/reset/gpio-reset.c                         | 208 +++++++++++++++++++++
> >  4 files changed, 259 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/reset/gpio-reset.txt
> >  create mode 100644 drivers/reset/gpio-reset.c
> >
> > diff --git a/Documentation/devicetree/bindings/reset/gpio-reset.txt b/Documentation/devicetree/bindings/reset/gpio-reset.txt
> > new file mode 100644
> > index 0000000..1f203eb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reset/gpio-reset.txt
> > @@ -0,0 +1,37 @@
> > +GPIO reset controller
> > +=====================
> > +
> > +A GPIO reset controller controls a number of GPIOs that are connected
> > +to reset pins of peripheral ICs.
> > +
> > +Please also refer to reset.txt in this directory for common reset
> > +controller binding usage.
> > +
> > +Required properties:
> > +- compatible: Should be "gpio-reset"
> > +- reset-gpios: List of gpios used as reset lines. The gpio specifier for this
> > +               property depends on the gpio controller that provides the gpio.
> > +- #reset-cells: 1, see below
> > +
> > +Optional properties:
> > +- reset-delays: List of delays in microseconds. The corresponding gpio reset
> > +                line should be asserted for this duration to reset.
> > +- initially-in-reset: List of integers. Zero if the initial state should be
> > +                      a deasserted reset line, nonzero if the line should be
> > +                      kept in reset.
> > +
> > +example:
> > +
> > +gpio_reset: gpio-reset {
> > +       compatible = "gpio-reset";
> > +       reset-gpios = <&gpio5 0 1>; /* active-low */
> > +       reset-delays = <10000>; /* 10 ms */
> > +       initially-in-reset: <1>;
> > +       #reset-cells = <1>;
> > +};
> 
> I find this binding that uses an array of GPIOs and their state to be
> a bit awkward, especially if you compare it to something like the
> simple gpio regulators that have a simpler one-to-one mapping.
> 
> Also, if you did one node per gpio you'd have a boolean property for
> "initially-in-reset" which seems much more logical (i.e. the property
> is either there, or it's not).

Thank you for your comments. I agree, to a degree.
The initially-in-reset array is a bit weird, and in principle, there is
no reason to group different reset gpios into the same platform device.
The main difference to the gpio regulator is that that one registers
multiple gpios per regulator, but only one regulator per platform
device. Do you propose to make the reset-gpio driver strictly control
only one reset gpio per platform device? In that case, the
fixed-regulator probably is a better example. How about this:

    resets {
        compatible = "simple-bus";

        reset1: gpio-reset {
            compatible = "gpio-reset";
            reset-gpio = <&gpio5 0 1>; /* active-low */
            reset-delay = <10000>; /* 10 ms */
            initially-in-reset;
            #reset-cells = <0>;
        };

        reset2: gpio-reset {
            compatible = "gpio-reset";
            reset-gpio = <&gpio3 5 0>;
            /* no reset delay, consumer has to (de)assert manually */
            #reset-cells = <0>;
        };
    };

> A couple of more comments:
> 
> > +config RESET_GPIO
> > +       tristate "GPIO reset controller support"
> > +       depends on GENERIC_GPIO
> > +       help
> > +         This driver provides support for reset lines that are controlled
> > +         directly by GPIOs.
> > +         The delay between assertion and de-assertion of the reset signal
> > +         can be configured.
> 
> Can be configured how? And why would I care about that when I'm trying
> to decide if I need to include this driver in my kernel configuration
> or not? Seems like misplaced information.

Configured via device tree. I'll just drop the second sentence. The idea
was to point out once more that it's the reset driver that carries the
timing information, but this really isn't the best place.

> Since this is a platform driver and not just an OF driver, shouldn't
> you provide a way to specify the same configuration data through a
> platform_data structure as well?

Will there be new non-OF platforms for which this is even useful? I can
add platform data support, if you like.

regards
Philipp

