From: Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH v4 5/6] arm64: dts: add QorIQ LX2160A SoC support
Date: Mon, 15 Oct 2018 09:48:33 -0700
Message-ID: <153962211360.5275.18031876744546062419@swboyd.mtv.corp.google.com>
References: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
 <1538615031-7507-6-git-send-email-vabhav.sharma@nxp.com>
 <20181008054510.GG3587@dragon>
 <VI1PR04MB4800C0AB214B258793AF9ABAF3FD0@VI1PR04MB4800.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB4800C0AB214B258793AF9ABAF3FD0@VI1PR04MB4800.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Vabhav Sharma <vabhav.sharma@nxp.com>
Cc: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "oss@buserror.net" <oss@buserror.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org" <linux-kernel-owner@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Quoting Vabhav Sharma (2018-10-14 19:58:15)
> > > +
> > > +   pmu {
> > > +           compatible =3D "arm,cortex-a72-pmu";
> > > +           interrupts =3D <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> > > +   };
> > > +
> > > +   psci {
> > > +           compatible =3D "arm,psci-0.2";
> > > +           method =3D "smc";
> > > +   };
> > > +
> > > +   memory@80000000 {
> > > +           // DRAM space - 1, size : 2 GB DRAM
> > > +           device_type =3D "memory";
> > > +           reg =3D <0x00000000 0x80000000 0 0x80000000>;
> > > +   };
> > > +
> > > +   ddr1: memory-controller@1080000 {
> > > +           compatible =3D "fsl,qoriq-memory-controller";
> > > +           reg =3D <0x0 0x1080000 0x0 0x1000>;
> > > +           interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > > +           little-endian;
> > > +   };
> > > +
> > > +   ddr2: memory-controller@1090000 {
> > > +           compatible =3D "fsl,qoriq-memory-controller";
> > > +           reg =3D <0x0 0x1090000 0x0 0x1000>;
> > > +           interrupts =3D <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> > > +           little-endian;
> > > +   };
> > > +
> > > +   sysclk: sysclk {
> > =

> > Name the node a bit generic like clock-xxx.
> There is only one clock-unit, Bootloader(U-boot) require sysclk node duri=
ng device tree fix-up as different platform support varied platform frequen=
cy as per reset configuration word used.
> Referred other ARM based platform with one clock using name as x: x

Please add a comment above this node with this information. Newcomers
reading this DTS file won't have any idea why this node is specially
named and a comment will help tremendously here.
