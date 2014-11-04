From: Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: RE: [PATCH 02/12] drivers: mfd: Add support for Exynos PMU driver
Date: Tue, 04 Nov 2014 08:48:25 +0530
Message-ID: <002601cff7de$0f8db7e0$2ea927a0$@samsung.com>
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
 <1414986790-11940-3-git-send-email-amit.daniel@samsung.com>
 <20141103152604.GA10544@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20141103152604.GA10544@x1>
Content-language: en-us
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Lee Jones' <lee.jones@linaro.org>, 'Amit Daniel Kachhap' <amit.daniel@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, 'Sangbeom Kim' <sbkim73@samsung.com>, 'Samuel Ortiz' <sameo@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Lee,

On Monday, November 03, 2014 8:56 PM, Lee Jones wrote,
> Subject: Re: [PATCH 02/12] drivers: mfd: Add support for Exynos PMU d=
river
>=20
> On Mon, 03 Nov 2014, Amit Daniel Kachhap wrote:
>=20
> > From: Pankaj Dubey <pankaj.dubey@samsung.com>
> >
> > This patch moves Exynos PMU driver implementation from "arm/mach-ex=
ynos"
> > to "drivers/mfd". This driver is mainly used for setting misc bits =
of
> > register from PMU IP of Exynos SoC which will be required to config=
ure
> > before Suspend/Resume. Currently all these settings are done in
> > "arch/arm/mach-exynos/pmu.c" but moving ahead for ARM64 based SoC
> > support, there is a need of DT based implementation of PMU driver.
> >
> > This driver uses already existing DT binding information.
> >
> > CC: Sangbeom Kim <sbkim73@samsung.com>
> > CC: Samuel Ortiz <sameo@linux.intel.com>
> > CC: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> > ---
> >  arch/arm/mach-exynos/Kconfig                       |    1 +
> >  arch/arm/mach-exynos/Makefile                      |    2 +-
> >  drivers/mfd/Kconfig                                |    9 ++++++++=
+
> >  drivers/mfd/Makefile                               |    1 +
> >  .../mach-exynos/pmu.c =3D> drivers/mfd/exynos-pmu.c  |    0
> >  5 files changed, 12 insertions(+), 1 deletion(-)  rename
> > arch/arm/mach-exynos/pmu.c =3D> drivers/mfd/exynos-pmu.c (100%)
>=20
> I thought we spoke about this already [1]?  What's changed?
>=20
> [1] https://lkml.org/lkml/2014/4/29/193
>=20

Yes correct, we had discussion about this in above post. But at that ti=
me I was not having enough points to
put forward for keeping Exynos PMU driver in MFD folder.
At that point there was only one idea behind keeping Exynos PMU that in=
 future it will be reused for ARM64
based SoC for PM related functionalities.
But in this series we have implemented Exynos Power Domain for Samsung'=
s ARM64 based SoCs.

As far as I can see this will in following ways -

1: Moving out PM domain specific code from mach-exynos and reuse of sam=
e code for ARM64 based SoC also.
2: Since PM domain relies on PMU registers and does not have its own DT=
 binding, MFD client and MFD device
is most suitable for making this kind of platform drivers.

> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead Linaro.org =E2=94=82 Open=
 source software
> for ARM SoCs Follow Linaro: Facebook | Twitter | Blog
