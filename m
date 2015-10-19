From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [GIT PULL] On-demand device probing
Date: Mon, 19 Oct 2015 19:39:06 +0100
Message-ID: <20151019183905.GS32532@n2100.arm.linux.org.uk>
References: <20151018192931.GY14956@sirena.org.uk>
 <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk>
 <1445247881.53393.146.camel@infradead.org>
 <CAL_JsqKehmSobpbdeXGo=-1pAbtrhCHovyyCWya_MNOhGCi8CQ@mail.gmail.com>
 <1445258870.53393.173.camel@infradead.org>
 <20151019145048.GI14956@sirena.org.uk>
 <1445268580.53393.183.camel@infradead.org>
 <20151019154324.GN32532@n2100.arm.linux.org.uk>
 <20151019182744.GD4931@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151019182744.GD4931@pengutronix.de>
Sender: linux-clk-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Liam Girdwood <lgirdwood@g>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 19, 2015 at 08:27:44PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Mon, Oct 19, 2015 at 04:43:24PM +0100, Russell King - ARM Linux wr=
ote:
> > It's a bit ironic that you've chosen GPIO as an example there.  The
> > "new" GPIO API (the gpiod_* stuff) only has a fwnode way to get the
> > gpio descriptor.  There's no of_* method.
>=20
> Without following all that fwnode discussion:
> gpiod_get et al. should work for you here, doesn't it? It just takes =
a
> struct device * and I'm happy with it.

What if you don't have a struct device?  I had that problem recently
when modifying the mvebu PCIe code.  The 'struct device' node doesn't
contain the GPIOs, it's the PCIe controller.  Individual ports on the
controller are described in DT as sub-nodes, and the sub-nodes can
have a GPIO for card reset purposes.  These sub-nodes don't have a
struct device.

Right now, I'm having to do this to work around this issue:

        reset_gpio =3D of_get_named_gpio_flags(child, "reset-gpios", 0,=
 &flags);
        if (reset_gpio =3D=3D -EPROBE_DEFER) {
                ret =3D reset_gpio;
                goto err;
        }

        if (gpio_is_valid(reset_gpio)) {
                unsigned long gpio_flags;

                port->reset_name =3D devm_kasprintf(dev, GFP_KERNEL, "%=
s-reset",
                                                  port->name);
                if (!port->reset_name) {
                        ret =3D -ENOMEM;
                        goto err;
                }

                if (flags & OF_GPIO_ACTIVE_LOW) {
                        dev_info(dev, "%s: reset gpio is active low\n",
                                 of_node_full_name(child));
                        gpio_flags =3D GPIOF_ACTIVE_LOW |
                                     GPIOF_OUT_INIT_LOW;
                } else {
                        gpio_flags =3D GPIOF_OUT_INIT_HIGH;
                }

                ret =3D devm_gpio_request_one(dev, reset_gpio, gpio_fla=
gs,
                                            port->reset_name);
                if (ret) {
                        if (ret =3D=3D -EPROBE_DEFER)
                                goto err;
                        goto skip;
                }

                port->reset_gpio =3D gpio_to_desc(reset_gpio);
        }

Not nice, is it?  Not nice to have that in lots of drivers either.

However, switching to use any of_* or fwnode_* thing also carries with
it another problem: you can't control the name appearing in the
allocation, so you end up with a bunch of GPIOs requested with a "reset=
"
name - meaning you lose any identification of which port the GPIO was
bound to.

--=20
=46TTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
