From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [GIT PULL] On-demand device probing
Date: Mon, 19 Oct 2015 16:43:24 +0100
Message-ID: <20151019154324.GN32532@n2100.arm.linux.org.uk>
References: <561E1378.6000906@collabora.com>
 <20151017065750.GA18607@kroah.com>
 <20151018192931.GY14956@sirena.org.uk>
 <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk>
 <1445247881.53393.146.camel@infradead.org>
 <CAL_JsqKehmSobpbdeXGo=-1pAbtrhCHovyyCWya_MNOhGCi8CQ@mail.gmail.com>
 <1445258870.53393.173.camel@infradead.org>
 <20151019145048.GI14956@sirena.org.uk>
 <1445268580.53393.183.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445268580.53393.183.camel@infradead.org>
Sender: linux-gpio-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 19, 2015 at 04:29:40PM +0100, David Woodhouse wrote:
> I don't know that there *is* a coherent plan here to address it all.
>=20
> Certainly, we *will* need subsystems to have firmware-specific
> knowledge in some cases. Take GPIO as an example; ACPI *has* a way to
> describe GPIO, and properties which reference GPIO pins are intended =
to
> work through that =E2=80=94 while in DT, properties which reference G=
PIO pins
> will have different contents. They'll be compatible at the driver
> level, in the sense that there's a call to get a given GPIO given the
> property name, but the subsystems *will* be doing different things
> behind the scenes.

It's a bit ironic that you've chosen GPIO as an example there.  The
"new" GPIO API (the gpiod_* stuff) only has a fwnode way to get the
gpio descriptor.  There's no of_* method.

I'd like to use the gpiod_* stuff, but I feel that my options are
rather limited: either use fwnode_get_named_gpiod() with
&dev->of_node->fwnode, which seems like a hack by going underneath
the covers of how fwnode is (partially) implemented with DT, or by
using of_get_named_gpio() and the converting the gpio number to a
descriptor via gpio_to_desc().  Both feel very hacky.

If ACPI already handles GPIOs internally, then I'm left wondering
why GPIO descriptor stuff went down the fwnode route at all - it
seems rather pointless in this case, and it seems to make the use
of the gpiod* interfaces where we _do_ need to use it (DT) harder
and more hacky.

--=20
=46TTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
