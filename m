From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
Date: Thu, 26 Feb 2015 20:20:37 +0100 (CET)
Message-ID: <824878601.106158.1424978437808.JavaMail.open-xchange@oxbsltgw01.schlund.de>
References: <54C0AFE4.3020701@i2se.com> <20150125150431.GE2719@earth.universe> <1719204322.245040.1422301605670.JavaMail.open-xchange@oxbaltgw03.schlund.de> <20150127001629.GP21293@sirena.org.uk> <1954124242.301697.1422383709733.JavaMail.open-xchange@oxbaltgw09.schlund.de> <20150127194346.GN21293@sirena.org.uk> <443299280.47516.1422483725178.JavaMail.open-xchange@oxbaltgw03.schlund.de> <20150128225937.GA12749@earth.universe> <964800678.25817.1422996087477.JavaMail.open-xchange@oxbaltgw04.schlund.de> <1766258118.893447.1424429861770.JavaMail.open-xchange@oxbaltgw03.schlund.de> <20150223153812.GA5499@earth>
Reply-To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150223153812.GA5499@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

> Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> hat am 23. Februar 2015 um 16:38
> geschrieben:
>
>
> On Fri, Feb 20, 2015 at 11:57:41AM +0100, Stefan Wahren wrote:
> > > power: power@80044000 {
> > > compatible = "fsl,imx28-power"; /* handled by mxs_power.c */
> > > #address-cells = <1>;
> > > #size-cells = <1>;
> > > reg = <0x80044000 0x2000>;
> > > interrupts = <6>;
> > > switching-frequency = <24000000>; /* new property */
> > > ranges;
> > >
> > > reg_vddd: regulator@80044040 {
> > > reg = <0x80044040 0x10>,
> > > <0x80044010 0x10>,
> > > <0x800440c0 0x10>;
> > > reg-names = "base-address",
> > > "v5ctrl-address",
> > > "status-address";
> > > compatible = "fsl,imx28-vddd"; /* handled by mxs-regulator.c */
> > > regulator-name = "vddd";
> > > regulator-min-microvolt = <1350000>;
> > > regulator-max-microvolt = <1550000>;
> > > vddd-supply = <&reg_vdda>;
> > > };
> > >
> > > reg_vdda: regulator@80044050 {
> > > reg = <0x80044050 0x10>,
> > > <0x80044010 0x10>,
> > > <0x800440c0 0x10>;
> > > reg-names = "base-address",
> > > "v5ctrl-address",
> > > "status-address";
> > > compatible = "fsl,imx28-vdda"; /* handled by mxs-regulator.c */
> > > regulator-name = "vdda";
> > > regulator-min-microvolt = <1725000>;
> > > regulator-max-microvolt = <1950000>;
> > > vdda-supply = <&reg_vddio>;
> > > };
> > >
> > > reg_vddio: regulator@80044060 {
> > > reg = <0x80044060 0x10>,
> > > <0x80044010 0x10>,
> > > <0x800440c0 0x10>;
> > > reg-names = "base-address",
> > > "v5ctrl-address",
> > > "status-address";
> > > compatible = "fsl,imx28-vddio"; /* handled by mxs-regulator.c */
> > > regulator-name = "vddio";
> > > regulator-min-microvolt = <3000000>;
> > > regulator-max-microvolt = <3575000>;
> > > regulator-microvolt-offset = <80000>;
> > > };
> > > };
> > >
> > > Please correct me if i'm wrong.
> > >
> > > Stefan
> >
> > Gentle Ping.
>
> The binding looks ok to me. It would be nice to get an ACK of a DT
> binding maintainer, though.

any objections about implementing DC-DC switching frequency as a DT property
instead of module parameter?

Stefan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
