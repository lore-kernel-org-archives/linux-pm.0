From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v2 09/10] power: supply: Initial support for ROHM
 BD70528 PMIC charger block
Date: Mon, 28 Jan 2019 15:53:54 +0200
Message-ID: <20190128135354.GA4156@localhost.localdomain>
References: <20190125110600.GA29332@localhost.localdomain>
 <CACRpkdYTCgXo8FeitEfRujeWdshnsR3Kn57cKUZsA3CsZ5Cnrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYTCgXo8FeitEfRujeWdshnsR3Kn57cKUZsA3CsZ5Cnrw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Matti Vaittinen <mazziesaccount@gmail.com>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, open list:OPEN
List-Id: linux-pm@vger.kernel.org

Hello Linus,

Big Thanks for the proper review at this early satge!

On Mon, Jan 28, 2019 at 01:49:04PM +0100, Linus Walleij wrote:
> Hi Matti!
> 
> Thanks for your patch.
> 
> We are going to have a problem with the power subsystem.
> 
> These charging drivers are growing wild. This is starting to get out
> of hand, we need some more framework for properly handling charging
> state machines the kernel. Not specifically your problem, but
> when working on the driver try to keep generic support in mind.

I for sure can try - but as the power subsystem is quite new to me - any
specific items you would like me to really pay attention?

> On Fri, Jan 25, 2019 at 12:06 PM Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
> 
> > +#define CHG_STAT_SUSPEND       0x0
> > +#define CHG_STAT_TRICKLE       0x1
> > +#define CHG_STAT_FAST          0x3
> > +#define CHG_STAT_TOPOFF                0xe
> > +#define CHG_STAT_DONE          0xf
> > +#define CHG_STAT_OTP_TRICKLE   0x10
> > +#define CHG_STAT_OTP_FAST      0x11
> > +#define CHG_STAT_OTP_DONE      0x12
> > +#define CHG_STAT_TSD_TRICKLE   0x20
> > +#define CHG_STAT_TSD_FAST      0x21
> > +#define CHG_STAT_TSD_TOPOFF    0x22
> > +#define CHG_STAT_BAT_ERR       0x7f
> 
> So what I am seeing is that these states are starting to turn up in more
> and more drivers, so we really need to think about a central management
> component for charging state machines. I do not think they are all
> that different after all.

Any suggestions how I should take this into account with bd70528?

> > +BD_ERR_IRQ_HND(BAT_OV_DET, "Battery overvoltage detected\n");
> > +BD_ERR_IRQ_HND(DBAT_DET, "Dead battery detected\n");
> > +BD_ERR_IRQ_HND(COLD_DET, "Battery cold\n");
> > +BD_ERR_IRQ_HND(HOT_DET, "Battery hot\n");
> > +BD_ERR_IRQ_HND(CHG_TSD, "Charger thermal shutdown\n");
> > +BD_ERR_IRQ_HND(DCIN2_OV_DET, "DCIN2 overvoltage detected\n");
> > +
> > +BD_INFO_IRQ_HND(BAT_OV_RES, "Battery voltage back to normal\n");
> > +BD_INFO_IRQ_HND(COLD_RES, "Battery temperature back to normal\n");
> > +BD_INFO_IRQ_HND(HOT_RES, "Battery temperature back to normal\n");
> > +BD_INFO_IRQ_HND(BAT_RMV, "Battery removed\n");
> > +BD_INFO_IRQ_HND(BAT_DET, "Battery detected\n");
> > +BD_INFO_IRQ_HND(DCIN2_OV_RES, "DCIN2 voltage back to normal\n");
> > +BD_INFO_IRQ_HND(DCIN2_RMV, "DCIN2 removed\n");
> > +BD_INFO_IRQ_HND(DCIN2_DET, "DCIN2 detected\n");
> > +BD_INFO_IRQ_HND(DCIN1_RMV, "DCIN1 removed\n");
> > +BD_INFO_IRQ_HND(DCIN1_DET, "DCIN1 detected\n");
> 
> So we have states and events, and these events form edges
> between the states, right?

Right. State change causes an irq.

> I am certain you must have a graphical picture of this state
> machine somewhere, it seems to be how charging hardware people
> do their thinking.

I don't have any document I could link to yet. I can ask around if we
can have some public doc for this :/ And as a last resort I can do some
ASCII art in commenets - if this is seen helpfull.

> > +/*
> > + * For BD70528 voltage/current limits we happily accept any value which
> > + * belongs the range. We could check if value matching the selector is
> > + * desired by computing the range min + (sel - sel_low) * range step - but
> > + * I guess it is enough if we use voltage/current which is closest (below)
> > + * the requested?
> > + */
> > +static int find_selector_for_value_low(struct linear_range *r, int selectors,
> > +                                      unsigned int val, unsigned int *sel,
> > +                                      bool *found)
> > +{
> > +       int i;
> > +       int ret = -EINVAL;
> > +
> > +       *found = false;
> > +       for (i = 0; i < selectors; i++) {
> > +               if (r[i].min <= val) {
> > +                       if (r[i].min + r[i].step * r[i].vals >= val) {
> > +                               *found = true;
> > +                               *sel = r[i].low_sel + (val - r[i].min) /
> > +                                      r[i].step;
> > +                               ret = 0;
> > +                               break;
> > +                       }
> > +                       /*
> > +                        * If the range max is smaller than requested
> > +                        * we can set the max supported value from range
> > +                        */
> > +                       *sel = r[i].low_sel + r[i].vals;
> > +                       ret = 0;
> > +               }
> > +       }
> > +       return ret;
> > +}
> 
> If I'm not mistaken this is yet another instance of linear interpolation
> from a table?

"linear interpolation from a table" is really not part of my
vocabulary :] But I guess you know the REGULATOR_LINEAR_VOLTAGE - macro?
I borrowed the idea from there...
> 
> We really need to think about abstracting this. Last time this
> duplication appeared I suggested adding linear interpolation
> primitives to:
> include/linux/fixp-arith.h

... I really think a generic helper for this would be usefull.

It will take some time untill I can send a proper (non RFC patch) for
the charger block as I currently lack of HW I could use for testing the
charger properly. Do you think it is better to drop the charger part
from the series untill then and submit it only later? As I mentioned in
cover-letter, the charger part is currently submitted more to give an
overview of the chip than to be applied as 'finalized' version of
driver.

Br,
	Matti Vaittinen
