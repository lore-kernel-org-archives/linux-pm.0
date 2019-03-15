From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [RFC PATCH 0/3] Add support of busfreq
Date: Fri, 15 Mar 2019 02:39:48 +0000
Message-ID: <AM0PR04MB421150DF12C869161E7ED4C180440@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190313193408.23740-1-abailon@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Bailon <abailon@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "georgi.djakov@linaro.org" <georgi.djakov@linaro.org>
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>, "ptitiano@baylibre.com" <ptitiano@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Zening Wang <zening.wang@nxp.com>, "khilman@baylibre.com" <khilman@baylibre.com>, "ccaione@baylibre.com" <ccaione@baylibre.com>, Jacky Bai <ping.bai@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
List-Id: linux-pm@vger.kernel.org

+Jacky and Leonard, Ranjani

Hi Alexandre,

> From: Alexandre Bailon [mailto:abailon@baylibre.com]
>=20
> This series implements busfreq, a framework used in MXP's tree to scale t=
he
> interconnect and dram frequencies.
> In the vendor tree, device's driver request for a performance level, whic=
h is
> used to scale the frequencies.
> This series implements it using the interconnect framework.
> Devices' driver request for bandwidth which is use by busfreq to determin=
e a
> performance level, and then scale the frequency.
>=20
> Busfreq is quite generic. It could be used for any i.MX SoC.
> A busfreq platform driver just have to define a list of interconnect node=
s, and
> some OPPs.
>=20

It's really great to see this patch series.
And it should be the correct direction we're heading to upstream busfreq su=
pport.

> This series is sent as RFC mostly because the current support of i.MX SoC=
 won't
> benefit of busfreq framework, because the clocks' driver don't support
> interconnect / dram frequency scaling.
> As exemple, this series implements busfreq for i.MX8MM whose upstreaming
> is in progress. Because this relies on ATF to do the frequency scaling, i=
t won't
> be hard make it work.
>=20

How can I test this patch series?
Any additional patches you can share with us?
Or what else we need to do to test it? We can help with it.

Regards
Dong Aisheng

> As exemple, this series implements busfreq for Alexandre Bailon (3):
>   drivers: interconnect: Add a driver for i.MX SoC
>   drivers: interconnect: imx: Add support of i.MX8MM
>   dt-bindings: interconnect: Document fsl,busfreq-imx8mm bindings
>=20
>  .../bindings/interconnect/imx8mm.txt          |  24 +
>  drivers/interconnect/Kconfig                  |   1 +
>  drivers/interconnect/Makefile                 |   1 +
>  drivers/interconnect/imx/Kconfig              |  17 +
>  drivers/interconnect/imx/Makefile             |   2 +
>  drivers/interconnect/imx/busfreq-imx8mm.c     | 132 ++++
>  drivers/interconnect/imx/busfreq.c            | 570
> ++++++++++++++++++
>  drivers/interconnect/imx/busfreq.h            | 123 ++++
>  include/dt-bindings/interconnect/imx8mm.h     |  37 ++
>  9 files changed, 907 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/interconnect/imx8mm.txt
>  create mode 100644 drivers/interconnect/imx/Kconfig  create mode
> 100644 drivers/interconnect/imx/Makefile  create mode 100644
> drivers/interconnect/imx/busfreq-imx8mm.c
>  create mode 100644 drivers/interconnect/imx/busfreq.c
>  create mode 100644 drivers/interconnect/imx/busfreq.h
>  create mode 100644 include/dt-bindings/interconnect/imx8mm.h
>=20
> --
> 2.19.2
