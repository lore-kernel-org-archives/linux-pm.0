From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V8 00/14] Add T210 support in Tegra soctherm
Date: Fri, 25 Mar 2016 13:37:17 +0800
Message-ID: <56F4CE8D.5020108@nvidia.com>
References: <1458118571-29717-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458118571-29717-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi, Eduardo
Will you take this series, it seems no more comments.

Thanks.
Wei.

On 2016=E5=B9=B403=E6=9C=8816=E6=97=A5 16:55, Wei Ni wrote:
> This patchset adds following functions for tegra_soctherm driver:
> 1. add T210 support.
> 2. export debugfs to show some registers.
> 3. add thermtrip funciton.
> 4. add suspend/resume function.
>=20
> The v7 series is in:
> https://patchwork.kernel.org/patch/8561681/
> The v6 series is in:
> https://lkml.org/lkml/2016/2/22/66
> The v5 series is in:
> http://www.spinics.net/lists/linux-tegra/msg25079.html
> The v4 series is in:
> http://www.spinics.net/lists/linux-tegra/msg24972.html
> The V3 series is in:
> http://www.spinics.net/lists/linux-tegra/msg24911.html
> The V2 series is in:
> http://www.spinics.net/lists/linux-tegra/msg24901.html
> The V1 series is in:
> http://www.spinics.net/lists/linux-tegra/msg24808.html
>=20
> Main changes from V7:
> 1. Split PM support patch into three smaller patches.
> 2. Few changes per Eduardo's comments.
>=20
> Main changes from V6:
> 1. rebased patches on Eduardo's
> [PATCH 00/13] thermal: convert users of thermal_zone_of_sensor_regist=
er to devm_
>=20
> Main changes from V5:
> 1. Change to use linux thermal framework to implement
> thermtrip funciton, per Rob's comment.
> 2. Add .set_trip_temp() in of-thermal driver, so that
> we can set trips on hardware.
>=20
> Main changes from V4:
> 1. Change description of devicetree binding per Rob's comment.
> 2. Call of_node_put to decrement refcount of the node.
>=20
> Main changes from V3:
> 1. Change structures to "const" in chip specific files.
> 2. Minor changes per Thieery's comments.
>=20
> Main changes from V2:
> 1. Fix build error in patch [1/11].
> 2. Use of_get_child_by_name instead of of_find_node_by_name in patch =
[8/11].
> 3. Use debugfs_remove_recursive to remove debugfs in patch [6/11].
>=20
> Main changes from V1:
> 1. Use the new type to handl different Tegra chips in one driver, whi=
ch suggested by Thierry.
> 2. Changes per Thieery's other comments.
>=20
> Wei Ni (14):
>   thermal: tegra: move tegra thermal files into tegra directory
>   thermal: tegra: combine sensor group-related data
>   thermal: tegra: get rid of PDIV/HOTSPOT hack
>   thermal: tegra: split tegra_soctherm driver
>   thermal: tegra: add Tegra210 specific SOC_THERM driver
>   thermal: tegra: add a debugfs to show registers
>   thermal: of-thermal: allow setting trip_temp on hardware
>   of: add notes of critical trips for soctherm
>   thermal: tegra: add thermtrip function
>   thermal: tegra: handle clocks in one function
>   thermal: tegra: handle HW initialization in one funcotion
>   thermal: tegra: add PM support
>   arm64: tegra: add soctherm node for Tegra210
>   arm: tegra: set critical trips for Tegra124
>=20
>  .../devicetree/bindings/thermal/tegra-soctherm.txt |  12 +
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  18 +-
>  arch/arm/boot/dts/tegra124.dtsi                    |  48 ++
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  92 +++
>  drivers/thermal/Kconfig                            |  12 +-
>  drivers/thermal/Makefile                           |   2 +-
>  drivers/thermal/of-thermal.c                       |   8 +
>  drivers/thermal/tegra/Kconfig                      |  13 +
>  drivers/thermal/tegra/Makefile                     |   5 +
>  drivers/thermal/tegra/soctherm-fuse.c              | 169 +++++
>  drivers/thermal/tegra/soctherm.c                   | 682 +++++++++++=
++++++++++
>  drivers/thermal/tegra/soctherm.h                   | 123 ++++
>  drivers/thermal/tegra/tegra124-soctherm.c          | 196 ++++++
>  drivers/thermal/tegra/tegra210-soctherm.c          | 197 ++++++
>  drivers/thermal/tegra_soctherm.c                   | 463 -----------=
---
>  include/dt-bindings/thermal/tegra124-soctherm.h    |   1 +
>  include/linux/thermal.h                            |   1 +
>  17 files changed, 1553 insertions(+), 489 deletions(-)
>  create mode 100644 drivers/thermal/tegra/Kconfig
>  create mode 100644 drivers/thermal/tegra/Makefile
>  create mode 100644 drivers/thermal/tegra/soctherm-fuse.c
>  create mode 100644 drivers/thermal/tegra/soctherm.c
>  create mode 100644 drivers/thermal/tegra/soctherm.h
>  create mode 100644 drivers/thermal/tegra/tegra124-soctherm.c
>  create mode 100644 drivers/thermal/tegra/tegra210-soctherm.c
>  delete mode 100644 drivers/thermal/tegra_soctherm.c
>=20
