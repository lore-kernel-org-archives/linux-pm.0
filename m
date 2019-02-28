From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH v1 07/13] devicetree: bindings: Document first ROHM
 BD70528 bindings
Date: Thu, 28 Feb 2019 09:37:43 -0600
Message-ID: <CAL_JsqKBUyygGu9FRb+hye+1DyRgdATm_64+XfsvwEa8AvZhJg@mail.gmail.com>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <80de7a2b537ae3f414b0281736652256f38cf94c.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <20190223003041.GA16670@bogus> <20190228064923.GA3773@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228064923.GA3773@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-clk <linux-c>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 28, 2019 at 12:49 AM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
>
> Hello Rob, All
>
> Sorry for long delay - I was ill for a few days. Back at the business
> now =)
>
> Rob, maybe dropping the RFC tag has messed your book keeping? This
> is the latest version:
> https://lore.kernel.org/lkml/90c3b820baf072a7cc3a21aa50c661774a045158.1550148989.git.matti.vaittinen@fi.rohmeurope.com/
> and I thought it already had the Reviewed-by tag from you :)

I thought I ignored RFC tag, but could be that. My script (and memory)
aren't perfect.

> On Fri, Feb 22, 2019 at 06:30:41PM -0600, Rob Herring wrote:
> > On Tue, Jan 22, 2019 at 11:45:38AM +0200, Matti Vaittinen wrote:
> > > Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> > > drivers) and 4 GPIO pins which can be configured for I/O or
> > > as interrupt sources withe configurable trigger levels.
> >
> > 'dt-bindings: mfd: ...' for the subject.
>
> I see at least the patch subject comment is still valid though. Do you
> want me to change it and resubmit the series?

No, if that's the only thing, it's not important.

Rob
