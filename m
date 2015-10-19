From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [GIT PULL] On-demand device probing
Date: Tue, 20 Oct 2015 08:47:21 +0900
Message-ID: <CAAVeFuKvwYikwjdTHK5Bq+Ot3s3hySe=7e-_8cXFN7tdUV18YA@mail.gmail.com>
References: <20151018192931.GY14956@sirena.org.uk> <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk> <1445247881.53393.146.camel@infradead.org>
 <CAL_JsqKehmSobpbdeXGo=-1pAbtrhCHovyyCWya_MNOhGCi8CQ@mail.gmail.com>
 <1445258870.53393.173.camel@infradead.org> <20151019145048.GI14956@sirena.org.uk>
 <1445268580.53393.183.camel@infradead.org> <20151019154324.GN32532@n2100.arm.linux.org.uk>
 <20151019182744.GD4931@pengutronix.de> <20151019183905.GS32532@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33551 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbbJSXrm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2015 19:47:42 -0400
In-Reply-To: <20151019183905.GS32532@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, David Woodhouse <dwmw2@infradead.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.c>

On Tue, Oct 20, 2015 at 3:39 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Oct 19, 2015 at 08:27:44PM +0200, Uwe Kleine-K=C3=B6nig wrote=
:
>> Hello,
>>
>> On Mon, Oct 19, 2015 at 04:43:24PM +0100, Russell King - ARM Linux w=
rote:
>> > It's a bit ironic that you've chosen GPIO as an example there.  Th=
e
>> > "new" GPIO API (the gpiod_* stuff) only has a fwnode way to get th=
e
>> > gpio descriptor.  There's no of_* method.
>>
>> Without following all that fwnode discussion:
>> gpiod_get et al. should work for you here, doesn't it? It just takes=
 a
>> struct device * and I'm happy with it.
>
> What if you don't have a struct device?  I had that problem recently
> when modifying the mvebu PCIe code.  The 'struct device' node doesn't
> contain the GPIOs, it's the PCIe controller.  Individual ports on the
> controller are described in DT as sub-nodes, and the sub-nodes can
> have a GPIO for card reset purposes.  These sub-nodes don't have a
> struct device.
>
> Right now, I'm having to do this to work around this issue:
>
>         reset_gpio =3D of_get_named_gpio_flags(child, "reset-gpios", =
0, &flags);
>         if (reset_gpio =3D=3D -EPROBE_DEFER) {
>                 ret =3D reset_gpio;
>                 goto err;
>         }
>
>         if (gpio_is_valid(reset_gpio)) {
>                 unsigned long gpio_flags;
>
>                 port->reset_name =3D devm_kasprintf(dev, GFP_KERNEL, =
"%s-reset",
>                                                   port->name);
>                 if (!port->reset_name) {
>                         ret =3D -ENOMEM;
>                         goto err;
>                 }
>
>                 if (flags & OF_GPIO_ACTIVE_LOW) {
>                         dev_info(dev, "%s: reset gpio is active low\n=
",
>                                  of_node_full_name(child));
>                         gpio_flags =3D GPIOF_ACTIVE_LOW |
>                                      GPIOF_OUT_INIT_LOW;
>                 } else {
>                         gpio_flags =3D GPIOF_OUT_INIT_HIGH;
>                 }
>
>                 ret =3D devm_gpio_request_one(dev, reset_gpio, gpio_f=
lags,
>                                             port->reset_name);
>                 if (ret) {
>                         if (ret =3D=3D -EPROBE_DEFER)
>                                 goto err;
>                         goto skip;
>                 }
>
>                 port->reset_gpio =3D gpio_to_desc(reset_gpio);
>         }
>
> Not nice, is it?  Not nice to have that in lots of drivers either.
>
> However, switching to use any of_* or fwnode_* thing also carries wit=
h
> it another problem: you can't control the name appearing in the
> allocation, so you end up with a bunch of GPIOs requested with a "res=
et"
> name - meaning you lose any identification of which port the GPIO was
> bound to.

There are a few holes in the gpiod API. I see two solutions here:

1) extend devm_get_gpiod_from_child() to take an optional name argument
2) add a function to explicitly change a GPIO's name

2) seems to be the most generic solution, would that do the trick?

(sorry for the off-topic)
