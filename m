From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 06/15] Platform: OLPC: Add XO-1.75 EC driver
Date: Mon, 19 Nov 2018 14:25:17 +0100
Message-ID: <26d225cd1ed93faff6e0a0513680fa5385f05f2d.camel@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
         <20181010172300.317643-7-lkundrak@v3.sk>
         <CAHp75VcefOJHZ3WdZYrGEJFjqg2s1oJ75Jg9gKmQFre_ScAPZg@mail.gmail.com>
         <8881f5e48613c9d9d133e3964031fe2ab57f4801.camel@v3.sk>
         <20181119104046.GC28607@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119104046.GC28607@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, quozl@laptop.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi <linux-spi@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Platform Driver <platform-driver-x8>
List-Id: linux-pm@vger.kernel.org

Hi Pavel,

I've addressed some of Andy's concerns you're replying to below in a
follow-up version of the patch. To many points I'm generally
indifferent and prefer to lean towards making things easy for whoever
may be likely to deal with the code in past. It's not clear to me who
that might be, or how important either of you consider your remarks to
be. I'll be thankful if anyone makes this clearer to me.

(I hoped that you're in the Cc list; thought git send-mail will see
your address in the Acked-by tags and add you. I failed to notice that
it's not the case. I apologize. Here's the v2 posting: [1].)

[1] https://lore.kernel.org/lkml/20181116162403.49854-1-lkundrak@v3.sk/


On Mon, 2018-11-19 at 11:40 +0100, Pavel Machek wrote:
> Hi!
> 
> > > > +#include <linux/delay.h>
> > > > +#include <linux/gpio/consumer.h>
> > > > +#include <linux/spinlock.h>
> > > > +#include <linux/completion.h>
> > > > +#include <linux/slab.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/ctype.h>
> > > > +#include <linux/olpc-ec.h>
> > > > +#include <linux/spi/spi.h>
> > > > +#include <linux/reboot.h>
> > > > +#include <linux/input.h>
> > > > +#include <linux/kfifo.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/power_supply.h>
> > > 
> > > Easy to maintain when it's sorted.
> 
> No / it depends.

I've sorted it in the new files; following a rule of keeping things
sorted at the very least has an advantage of being unambiguous.

I'm not sorting things where they currently are not in order, since it
would obscure real changes.

> > > > +       channel = priv->rx_buf[0];
> > > > +       byte = priv->rx_buf[1];
> > > 
> > > Maybe specific structures would fit better?
> > > 
> > > Like
> > > 
> > > struct olpc_ec_resp_hdr {
> > >  u8 channel;
> > >  u8 byte;
> > > ...
> > > }
> 
> Structures have padding and other nastyness...

I've turned them into structs. It perhaps looks a bit better -- the
structure members serving as a documentation for the protocol.

> > > > +                       pm_wakeup_event(priv->pwrbtn-
> > > > >dev.parent,
> > > > 1000);
> > > 
> > > Magic number.
> 
> Nothing wrong with magic numbers.

Turned it into a define, but it's not like it's any clearer why that
particular value works...

I actually have little idea. I've copied this from the vendor's
original driver.

> > > > +       args[0] = mask & 0xff;
> > > > +       args[1] = (mask >> 8) & 0xff;
> > > 
> > > ...mask >> 0;
> > > ...mask >> 8;
> 
> No, please.

I've done this too, but I don't see much point either. Perhaps those
within the OCD spectrum may appreciate :)

> > > __maybe_unused  instead of ugly #ifdef?
> > > 
> > > > +{
> > > > +       struct platform_device *pdev = to_platform_device(dev);
> > > > +       struct olpc_xo175_ec *priv =
> > > > platform_get_drvdata(pdev);
> > > 
> > > dev_get_drvdata() or how is it called?
> > > 
> > > > +       unsigned char hintargs[5];
> > > 
> > > struct olpc_ec_hint_cmd {
> > > u8 ...
> > > u32 ...
> > > };
> > > 
> > > ?
> 
> No, unless you want to break the code. Or add __attribute__ packed
> and
> deal with endianness.
> 
> Just no.

Turned it into a packed struct too for the same reasons as above.

The endianness of the hints argument doesn't actually matter, since the
EC firmware actually uses this in a debugging printf. It's not even
cleat what endianness did EC expect initially.

> > > > +       static unsigned int suspend_count;
> > > 
> > > u32 I suppose.
> 
> You know, there's semantic difference between unsigned int and
> u32. And this sounds like candidate for unsigned int.
> 
> > > > +       /* Enable all EC events while we're awake */
> > > > +       olpc_xo175_ec_set_event_mask(0xffff);
> > > 
> > > #define EC_ALL_EVENTS GENMASK(15, 0)
> 
> Actually that's less readable. Just don't.

Done this too, and, like the points above, I am indifferent too. Both
seem equal to me.

> > > > +static const struct of_device_id olpc_xo175_ec_of_match[] = {
> > > > +       { .compatible = "olpc,xo1.75-ec" },
> > > > +       { },
> > > 
> > > No comma for terminators.
> 
> Comma is fine.

Removed it. Perhaps the lack of a comma could be understood as an
indication that no further initializers shall follow.

> 	Pavel

Just in case I didn't stress that enough: I'm much more interested in
things working well than style issues that too often are just matter of
tast. I happily accept advice on those though.

Take care,
Lubo
