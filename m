From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
Date: Wed, 28 Jan 2015 23:22:05 +0100 (CET)
Message-ID: <443299280.47516.1422483725178.JavaMail.open-xchange@oxbaltgw03.schlund.de>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
 <20150121230148.GJ13715@earth.universe> <54C0AFE4.3020701@i2se.com>
 <20150125150431.GE2719@earth.universe>
 <1719204322.245040.1422301605670.JavaMail.open-xchange@oxbaltgw03.schlund.de>
 <20150127001629.GP21293@sirena.org.uk>
 <1954124242.301697.1422383709733.JavaMail.open-xchange@oxbaltgw09.schlund.de>
 <20150127194346.GN21293@sirena.org.uk>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150127194346.GN21293@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Marek Vasut <marex@denx.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

> Mark Brown <broonie@kernel.org> hat am 27. Januar 2015 um 20:43 geschrieben:
>
>
> On Tue, Jan 27, 2015 at 07:35:09PM +0100, Stefan Wahren wrote:
> > > Mark Brown <broonie@kernel.org> hat am 27. Januar 2015 um 01:16
> > > geschrieben:
>
> > > > okay i understand. But doesn't it need a extra driver to set the
> > > > switching
> > > > frequency because of the new compatible string?
>
> > > I don't understand this bit at all, sorry.
>
> > Sebastian suggested a new sub-node in the devicetree:
>
> > powerpll {
> > compatible = "fsl,imx28-power-pll"
> > #clock-cells = <0>;
> > clock-frequency = <12345>;
> > }
>
> > and i think that the new compatible string needs a separate driver to take
> > care
> > of the switching frequency.
>
> I can see that this has been suggested, what I can't understand is why
> we would wish to do this but I am missing some context here which may
> make it all perfectly clear.

changing the switching frequency is not a common feature for this IC. In most
cases the clock for the DC-DC switching frequency runs at 24 MHz (ref_xtal).
Unfortunatelly this could cause interferences for example in UHF band. So
switching to ref_pll and changing clock divider is a option to avoid such
interferences without changing hardware.

The relevant register DC-DC Miscellaneous Register (HW_POWER_MISC) is described
in chapter 11.12.10 of the reference manual [1].

I decided to implement it as a module parameter, because i see it's a
configuration option.

[1] - http://cache.freescale.com/files/dsp/doc/ref_manual/MCIMX28RM.pdf

>
> > Or is it okay to leave the handling of the switching frequency in the
> > mxs-power
> > driver?
>
> Unless the clock is exposed externally to the regulator either as an
> input or an output I'm not sure I see any benefit but I'm possibly
> missing something here. It does sound like there might be a separate
> clock IP or something?
>
> > Btw if we add a new node to set switching frequency, i think it would be
> > better
> > to describe the dc-dc convertor and not the pll:
>
> > dcdc {
> > compatible = "fsl,imx28-dcdc"
> > frequency = <12345>;
> > }
>
> > What do you think?
>
> Yes, just adding a new property on the regulator node with all the other
> properties seems sensible (we've just gained some helpers which make it
> fairly straightforward to do this).
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
