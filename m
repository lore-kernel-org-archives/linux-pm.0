From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
Date: Fri, 20 Feb 2015 11:57:41 +0100 (CET)
Message-ID: <1766258118.893447.1424429861770.JavaMail.open-xchange@oxbaltgw03.schlund.de>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com> <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com> <20150121230148.GJ13715@earth.universe> <54C0AFE4.3020701@i2se.com> <20150125150431.GE2719@earth.universe> <1719204322.245040.1422301605670.JavaMail.open-xchange@oxbaltgw03.schlund.de> <20150127001629.GP21293@sirena.org.uk> <1954124242.301697.1422383709733.JavaMail.open-xchange@oxbaltgw09.schlund.de> <20150127194346.GN21293@sirena.org.uk> <443299280.47516.1422483725178.JavaMail.open-xchange@oxbaltgw03.schlund.de> <20150128225937.GA12749@earth.universe> <964800678.25817.1422996087477.JavaMail.open-xchange@oxbaltgw04.schlund.de>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:60903 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955AbbBTK6D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Feb 2015 05:58:03 -0500
In-Reply-To: <964800678.25817.1422996087477.JavaMail.open-xchange@oxbaltgw04.schlund.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, David Woodhouse <dwmw2@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Marek Vasut <marex@denx.de>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org

> Stefan Wahren <stefan.wahren@i2se.com> hat am 3. Februar 2015 um 21:41
> geschrieben:
>
>
> Hi Sebastian,
>
> > Sebastian Reichel <sre@kernel.org> hat am 28. Januar 2015 um 23:59
> > geschrieben:
> >
> >
> > Hi,
> >
> > On Wed, Jan 28, 2015 at 11:22:05PM +0100, Stefan Wahren wrote:
> > > > Mark Brown <broonie@kernel.org> hat am 27. Januar 2015 um 20:43
> > > > geschrieben:
> > > > On Tue, Jan 27, 2015 at 07:35:09PM +0100, Stefan Wahren wrote:
> > > >
> > > changing the switching frequency is not a common feature for this IC. In
> > > most
> > > cases the clock for the DC-DC switching frequency runs at 24 MHz
> > > (ref_xtal).
> > > Unfortunatelly this could cause interferences for example in UHF band. So
> > > switching to ref_pll and changing clock divider is a option to avoid such
> > > interferences without changing hardware.
> > >
> > > I decided to implement it as a module parameter, because i see it's a
> > > configuration option.
> >
> > I think its best to use a DT property then. That way it can be set
> > appropiatly for boards known to use a band, which could have
> > interference problems.
> >
> > So just add a simple property (without a subnode). If I understand
> > Mark correctly, there's a high chance more drivers will need to
> > describe the switching frequency, so I suggest to use a vendor
> > independent property name:
> >
> > switching-frequency = <12345>;
>
> i'm not sure. So here is the complete current state (power and regulator
> binding
> from imx28.dtsi) including my suggestion for the new property:
>
> power: power@80044000 {
> compatible = "fsl,imx28-power"; /* handled by mxs_power.c */
> #address-cells = <1>;
> #size-cells = <1>;
> reg = <0x80044000 0x2000>;
> interrupts = <6>;
> switching-frequency = <24000000>; /* new property */
> ranges;
>
> reg_vddd: regulator@80044040 {
> reg = <0x80044040 0x10>,
> <0x80044010 0x10>,
> <0x800440c0 0x10>;
> reg-names = "base-address",
> "v5ctrl-address",
> "status-address";
> compatible = "fsl,imx28-vddd"; /* handled by mxs-regulator.c */
> regulator-name = "vddd";
> regulator-min-microvolt = <1350000>;
> regulator-max-microvolt = <1550000>;
> vddd-supply = <&reg_vdda>;
> };
>
> reg_vdda: regulator@80044050 {
> reg = <0x80044050 0x10>,
> <0x80044010 0x10>,
> <0x800440c0 0x10>;
> reg-names = "base-address",
> "v5ctrl-address",
> "status-address";
> compatible = "fsl,imx28-vdda"; /* handled by mxs-regulator.c */
> regulator-name = "vdda";
> regulator-min-microvolt = <1725000>;
> regulator-max-microvolt = <1950000>;
> vdda-supply = <&reg_vddio>;
> };
>
> reg_vddio: regulator@80044060 {
> reg = <0x80044060 0x10>,
> <0x80044010 0x10>,
> <0x800440c0 0x10>;
> reg-names = "base-address",
> "v5ctrl-address",
> "status-address";
> compatible = "fsl,imx28-vddio"; /* handled by mxs-regulator.c */
> regulator-name = "vddio";
> regulator-min-microvolt = <3000000>;
> regulator-max-microvolt = <3575000>;
> regulator-microvolt-offset = <80000>;
> };
> };
>
> Please correct me if i'm wrong.
>
> Stefan

Gentle Ping.

Stefan

>
> >
> > -- Sebastian
