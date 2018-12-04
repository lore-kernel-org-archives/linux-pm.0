From: Priit Laes <plaes@plaes.org>
Subject: Re: [PATCH 09/14] regulator: dts: add full voltage range to LDO4 on
 the Lime2
Date: Tue, 4 Dec 2018 14:47:59 +0000
Message-ID: <20181204144759.thsvooby6txag2yr@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <0b1aa5b28cb5efe17c04150a181ef1fa4027bc55.1543245984.git-series.plaes@plaes.org>
 <20181127093852.2iavgo4xipjnu25l@flea>
 <20181128095639.t4ogsk6ovyu2yaxu@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181128095639.t4ogsk6ovyu2yaxu@flea>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 28, 2018 at 10:56:39AM +0100, Maxime Ripard wrote:
> On Tue, Nov 27, 2018 at 10:38:52AM +0100, Maxime Ripard wrote:
> > On Mon, Nov 26, 2018 at 05:27:50PM +0200, Priit Laes wrote:
> > > From: Olliver Schinagl <oliver@schinagl.nl>
> > > 
> > > With commit b43776d65a33b46092 ("ARM: dts: sunxi: Use axp209.dtsi for
> > > Olinuxino Lime2") we force them an arbitrary 2.8 volts. Granted, for
> > > LDO3 this may be less arbitrary, but for LDO4 this is just wrong.
> > > 
[ ... ]
> > As we discussed on the U-Boot ML already, this shouldn't be made
> > always-on but tied to the consumer device (the pinctrl one) instead.
> 
> Can you test that patch (not tested):
> http://code.bulix.org/h02vha-514284?raw

Quick test (after applying this: http://code.bulix.org/w01xab-518044?raw )
results in failure:

[snip]
dmesg -t |egrep "(regu|seria)"
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pb not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: Linked as a consumer to regulator.0
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pb not found, using dummy regulator
1c28000.serial: ttyS0 at MMIO 0x1c28000 (irq = 47, base_baud = 1500000) is a U6_16550A
sun4i-pinctrl 1c20800.pinctrl: Couldn't get bank PG regulator
sun4i-pinctrl 1c20800.pinctrl: pin-198 (1c28c00.serial) status -22
dw-apb-uart 1c28c00.serial: Error applying setting, reverse things back
dw-apb-uart: probe of 1c28c00.serial failed with error -22
sun4i-pinctrl 1c20800.pinctrl: Couldn't get bank PG regulator
sun4i-pinctrl 1c20800.pinctrl: pin-202 (1c29000.serial) status -22
dw-apb-uart 1c29000.serial: Error applying setting, reverse things back
dw-apb-uart: probe of 1c29000.serial failed with error -22
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
...
[/snip]

And I cannot actually see the link between pinctrl and ldo4. There's currently only this link:

sun4i-pinctrl 1c20800.pinctrl: Linked as a consumer to regulator.0

$ cat /sys/class/regulator/regulator.0/name
regulator-dummy


> 
> Thanks!
> Maxime
> 
> -- 
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
