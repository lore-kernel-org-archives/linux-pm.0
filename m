From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH V5 00/30] thermal: exynos: Add thermal driver for exynos5440
Date: Wed, 12 Jun 2013 13:09:05 +0900
Message-ID: <51B7F461.5040405@samsung.com>
References: <1370955220-2949-1-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1370955220-2949-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, jonghwa3.lee@samsung.com
List-Id: linux-pm@vger.kernel.org

On 2013=EB=85=84 06=EC=9B=94 11=EC=9D=BC 21:53, Amit Daniel Kachhap wro=
te:

> Most of the changes in this version is as per suggestion from Jonghwa=
 Lee. I
> have retained one to one mapping of platform data with TMU instances =
as the
> TMU's are different devices. In exynos5440 soc there is some register
> sharing across multiple TMU's but in exynos5420 there is no register =
between
> multiple TMU's, so the current implementation is useful to support bo=
th of the
> above.
>=20
> This patch uses localized ARCH_HAS_TMU Kconfig option and is a tempor=
ary solution
> until a more generic macro ARCH_HAS_BANDGAP is introduced as per disc=
ussion in
> the link https://patchwork.kernel.org/patch/2659001/.
>=20
> Changes in V5:
> * trip type is passed as platform data.
> * HW trip is allowed only for maximum level.
> * Platform data structure is now abstracted inside 1 more structure t=
o support
>   strong multiple sensor TMU data.=20
>=20
> Changes in V4:
>  Almost all the changes in this version is as per suggestion from Edu=
ardo.The
>  major ones are listed below,
> * Added kconfig symbol ARCH_HAS_TMU which needs to be enabled by plat=
form. With
>   this change existing symbol EXYNOS_TMU_DATA is not needed.
> * Movement of freq_clip_table from exynos_tmu.h to exynos_thermal_com=
mon.h is
>   explained in the commit logs.
> * Wrote all register description documentation.
> * Split 5440 TMU support patch into controller change, configuration =
data and
>   feature addition patches.
> * Remove all *LINUX_* in the header files.
> * Still regulator enable is kept optional but a TODO: comment is adde=
d to fix
>   it later.
>=20
> Changes in V3:
> * Added proper dependency of different exynos thermal Kconfig symbols=
=2E Basically 3
>  Kconfig can be enabled now and corresponds to tmu driver. exynos com=
mon part
>  and exynos configuration data. This issue was raised by Rui Zhang.
>=20
> Changes in V2:
> * Separated SOC data from TMU driver. This is as per suggestion from =
Eduardo.
> * Merged the new file created for exynos5440 TMU controller with the =
existing
>  TMU controller code.
> * Removed the DT parsing code as now the SOC specific data are cleanl=
y put
>  inside the data specific file.
> * Even the register definations/bitfields are treated as data as ther=
e is
>  some variation across SOC's.
>=20
> This patchset adds TMU(Thermal management Unit) driver support for
> exynos5440 platform. There are 3 instances of the TMU controllers so
> necessary cleanup/re-structure is done to handle multiple thermal zon=
e.
>=20
> Patch (exynos4: Add documentation for Exynos SoC thermal bindings) fr=
om
> Lukasz Majewski is already posted to mainline. Adding it here for com=
pleteness.
> (http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg178=
17.html)
>=20
> Patch (thermal: exynos: Support thermal tripping ) from Jonghwan Choi=
 is
> added here with some changes.
> (https://patchwork.kernel.org/patch/1668371/)
>=20
> Patch (thermal: exynos: Support for TMU regulator defined at device t=
ree)
> is a repost of my earlier patch(https://patchwork-mail1.kernel.org/pa=
tch/2510771/)=20
> and adds regulator support.
>=20
> Patch (ARM: dts: Add device tree node for exynos5440 TMU controller) =
and
> patch (arm: exynos: enable ARCH_HAS_TMU) can be merged through exynos=
 platform
> maintainer as this can cause merge conflict.
>=20
> All these patches are based on thermal maintainers git tree,
> git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next.
>=20
> Amit Daniel Kachhap (29):
>   thermal: exynos: Moving exynos thermal files into samsung directory
>   thermal: exynos: Add ARCH_HAS_TMU config to know the supported soc'=
s
>   thermal: exynos: Remove CPU_THERMAL dependency for using TMU driver
>   thermal: exynos: Bifurcate exynos thermal common and tmu controller
>     code
>   thermal: exynos: Rename exynos_thermal.c to exynos_tmu.c
>   thermal: exynos: Move exynos_thermal.h from include/* to driver/*
>     folder
>   thermal: exynos: Bifurcate exynos tmu driver and configuration data
>   thermal: exynos: Add missing definations and code cleanup
>   thermal: exynos: Add extra entries in the tmu platform data
>   thermal: exynos: Move register definitions from driver to data file
>   thermal: exynos: Support thermal tripping
>   thermal: exynos: Fix to clear only the generated interrupts
>   thermal: exynos: Add support for instance based register/unregister
>   thermal: exynos: Modify private_data to appropriate name driver_dat=
a
>   thermal: exynos: Return success even if no cooling data supplied
>   thermal: exynos: Make the zone handling use trip information
>   thermal: exynos: Remove non DT based support
>   thermal: exynos: Add support to handle many instances of TMU
>   thermal: exynos: Add TMU features to check instead of using SOC typ=
e
>   thermal: exynos: use device resource management infrastructure
>   thermal: exynos: Add support to access common register for
>     multistance
>   thermal: exynos: Add driver support for exynos5440 TMU sensor
>   thermal: exynos: Add thermal configuration data for exynos5440 TMU
>     sensor
>   thermal: exynos: Fix to set the second point correction value
>   thermal: exynos: Add hardware mode thermal calibration support
>   Documentation: thermal: Explain the exynos thermal driver model
>   thermal: exynos: Support for TMU regulator defined at device tree
>   ARM: dts: Add device tree node for exynos5440 TMU controller
>   arm: exynos: enable ARCH_HAS_TMU
>=20
> Lukasz Majewski (1):
>   ARM: dts: thermal: exynos4: Add documentation for Exynos SoC therma=
l
>     bindings
>=20
>  .../devicetree/bindings/thermal/exynos-thermal.txt |   55 +
>  Documentation/thermal/exynos_thermal               |   43 +-
>  arch/arm/boot/dts/exynos5440.dtsi                  |   30 +
>  arch/arm/mach-exynos/Kconfig                       |    5 +
>  drivers/thermal/Kconfig                            |   14 +-
>  drivers/thermal/Makefile                           |    2 +-
>  drivers/thermal/exynos_thermal.c                   | 1058 ----------=
----------
>  drivers/thermal/samsung/Kconfig                    |   21 +
>  drivers/thermal/samsung/Makefile                   |    7 +
>  drivers/thermal/samsung/exynos_thermal_common.c    |  413 ++++++++
>  drivers/thermal/samsung/exynos_thermal_common.h    |  106 ++
>  drivers/thermal/samsung/exynos_tmu.c               |  750 ++++++++++=
++++
>  drivers/thermal/samsung/exynos_tmu.h               |  307 ++++++
>  drivers/thermal/samsung/exynos_tmu_data.c          |  250 +++++
>  drivers/thermal/samsung/exynos_tmu_data.h          |  155 +++
>  include/linux/platform_data/exynos_thermal.h       |  119 ---
>  16 files changed, 2140 insertions(+), 1195 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/exynos-=
thermal.txt
>  delete mode 100644 drivers/thermal/exynos_thermal.c
>  create mode 100644 drivers/thermal/samsung/Kconfig
>  create mode 100644 drivers/thermal/samsung/Makefile
>  create mode 100644 drivers/thermal/samsung/exynos_thermal_common.c
>  create mode 100644 drivers/thermal/samsung/exynos_thermal_common.h
>  create mode 100644 drivers/thermal/samsung/exynos_tmu.c
>  create mode 100644 drivers/thermal/samsung/exynos_tmu.h
>  create mode 100644 drivers/thermal/samsung/exynos_tmu_data.c
>  create mode 100644 drivers/thermal/samsung/exynos_tmu_data.h
>  delete mode 100644 include/linux/platform_data/exynos_thermal.h
>=20


Looks good to me.

Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
