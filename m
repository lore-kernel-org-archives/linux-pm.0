From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH v2 09/10] power: supply: Initial support for ROHM
 BD70528 PMIC charger block
Date: Mon, 28 Jan 2019 15:46:10 +0100
Message-ID: <CACRpkdZDOJJ6qSS8fkqQsgmchDWATfhTP=TZATwt6-Z_WQXpJQ@mail.gmail.com>
References: <20190125110600.GA29332@localhost.localdomain> <CACRpkdYTCgXo8FeitEfRujeWdshnsR3Kn57cKUZsA3CsZ5Cnrw@mail.gmail.com>
 <20190128135354.GA4156@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128135354.GA4156@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Matti Vaittinen <mazziesaccount@gmail.com>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, open list:OPEN
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 28, 2019 at 2:54 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> > These charging drivers are growing wild. This is starting to get out
> > of hand, we need some more framework for properly handling charging
> > state machines the kernel. Not specifically your problem, but
> > when working on the driver try to keep generic support in mind.
>
> I for sure can try - but as the power subsystem is quite new to me - any
> specific items you would like me to really pay attention?

So I am not saying you have to do this or anything, but I think
what we need is a generic state machine and policy engine
for charging, where different charging drivers just plug in.

They all seem to have trickle and fast charging, USB phy
interaction and AC plug interaction of some kind for detecting
those and in some cases temperature detection directly
or using an ADC.

We have a bunch of drivers with software-controlled charging:
ab8500*
axp288*
etc.

If we could get just two drivers to share some changing
infrastructure we would have a start.

I have no idea how hard it could be, but I think it would
be a pretty interesting adventure if someone gathered
some different hardwares and started to generalize parts
of this.

> > So what I am seeing is that these states are starting to turn up in more
> > and more drivers, so we really need to think about a central management
> > component for charging state machines. I do not think they are all
> > that different after all.
>
> Any suggestions how I should take this into account with bd70528?

Not more than above, it is unfair to ask random contributors to
invent entire new worlds of kernel infrastructure. But I guess I
just need to say it so we are aware: this charging state machine
engine is needed. Doing it is another thing.

> > I am certain you must have a graphical picture of this state
> > machine somewhere, it seems to be how charging hardware people
> > do their thinking.
>
> I don't have any document I could link to yet. I can ask around if we
> can have some public doc for this :/ And as a last resort I can do some
> ASCII art in commenets - if this is seen helpfull.

That'd be nice.

> > If I'm not mistaken this is yet another instance of linear interpolation
> > from a table?
>
> "linear interpolation from a table" is really not part of my
> vocabulary :] But I guess you know the REGULATOR_LINEAR_VOLTAGE - macro?
> I borrowed the idea from there...

I'm referring to this essentially:
https://en.wikipedia.org/wiki/Linear_interpolation

What many charging drivers tends to do is:
- Look up where I am in a table, say between row 4 and 5
- For x-axis n..n+1, interpolate y-axis between
  the values found for x=1 and x=n+1 using
  common linear interpolation.

> > We really need to think about abstracting this. Last time this
> > duplication appeared I suggested adding linear interpolation
> > primitives to:
> > include/linux/fixp-arith.h
>
> ... I really think a generic helper for this would be usefull.

Indeed.

> It will take some time untill I can send a proper (non RFC patch) for
> the charger block as I currently lack of HW I could use for testing the
> charger properly. Do you think it is better to drop the charger part
> from the series untill then and submit it only later?

Not really, we need to face the hardware out there and I usually
use the stance "rough consensus and running code". If noone
invents a unified charging framework, your hardware needs to
run so a custom driver isn't that bad either, and it's still better
to have it in-tree than to maintain it out-of-tree as long as it
is clearly isolated.

> As I mentioned in
> cover-letter, the charger part is currently submitted more to give an
> overview of the chip than to be applied as 'finalized' version of
> driver.

That's OK.

Yours,
Linus Walleij
