From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH 00/17] thermal: enable/check sensor after its setup is finished
Date: Fri, 7 Sep 2018 14:40:00 +0530
Message-ID: <CAHLCerM21eVkxigVN7vJvSCOfbyc2ow+R16LCA8QJ724b1+9xQ@mail.gmail.com>
References: <CGME20180410124240epcas2p25c8979583c41f147ac34c49faf30aa14@epcas2p2.samsung.com>
 <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Bartlomiej,

Do you have an updated version of this patchset on 4.19-rc1 somewhere
that I can look at? I might be seeing this issue on the QCom TSENS
driver and would like to verify.

Regards,
Amit

On Tue, Apr 10, 2018 at 6:11 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Hi,
>
> [devm]_thermal_zone_of_sensor_register() is used to register
> thermal sensor by thermal drivers using DeviceTree. Besides
> registering sensor this function also immediately enables it
> (using ->set_mode method) and then checks it with a update call
> to the thermal core (which ends up using ->get_temp method).
> For many DT thermal drivers this causes a problem because
> [devm]_thermal_zone_of_sensor_register() need to be called in
> order to obtain data about thermal trips which are then used to
> finish hardware sensor setup (only after which ->get_temp can
> be used). The issue has been observed when using Samsung Exynos
> thermal driver and fixed internally in the driver in commit
> d8efad71e5b6 ("thermal: exynos: Reading temperature makes sense
> only when TMU is turned on"). However after this commit there
> are now following warnings from the thermal core visible:
>
> [    3.453602] thermal thermal_zone0: failed to read out thermal zone (-22)
> [    3.483468] thermal thermal_zone1: failed to read out thermal zone (-22)
> [    3.505965] thermal thermal_zone2: failed to read out thermal zone (-22)
> [    3.528455] thermal thermal_zone3: failed to read out thermal zone (-22)
> [    3.550939] thermal thermal_zone4: failed to read out thermal zone (-22)
>
> This patchset attempts to directly address the thermal core
> problem with [devm]_thermal_zone_of_sensor_register() and
> affected DT thermal drivers. In order to achieve this sensor
> registration, enable and check operations are separated and
> corresponding drivers are modified to use the new helpers to
> enable and check sensor explicitly.
>
> Tested on Exynos5422 based Odroid-XU3 Lite board (aforementioned
> warnings from the thermal core are now gone).
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
>
> Bartlomiej Zolnierkiewicz (17):
>   thermal: add thermal_zone_device_toggle() helper
>   thermal: separate sensor registration and enable
>   thermal: add thermal_zone_device_check() helper
>   thermal: do sensor checking explicitly in drivers
>   thermal: bcm2835: enable/check sensor after its setup is finished
>   thermal: brcmstb: enable/check sensor after its setup is finished
>   thermal: hisi_thermal: enable/check sensor after its setup is finished
>   thermal: qcom: tsens: enable/check sensor after its setup is finished
>   thermal: qoriq: enable/check sensor after its setup is finished
>   thermal: rcar_gen3_thermal: enable/check sensor after its setup is
>     finished
>   thermal: rockchip_thermal: enable/check sensor after its setup is
>     finished
>   thermal: exynos: enable/check sensor after its setup is finished
>   thermal: tegra: enable/check sensor after its setup is finished
>   thermal: ti-soc-thermal: enable/check sensor after its setup is
>     finished
>   thermal: uniphier: enable/check sensor after its setup is
>     finished
>   thermal: zx2967: enable/check sensor after its setup is finished
>   thermal: warn on attempts to read temperature on disabled sensors
>
>  drivers/acpi/thermal.c                             |  5 ++--
>  drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  1 -
>  drivers/platform/x86/acerhdf.c                     |  6 +++-
>  drivers/regulator/max8973-regulator.c              |  3 +-
>  drivers/thermal/broadcom/bcm2835_thermal.c         |  3 ++
>  drivers/thermal/broadcom/brcmstb_thermal.c         |  3 ++
>  drivers/thermal/broadcom/ns-thermal.c              |  3 ++
>  drivers/thermal/da9062-thermal.c                   |  7 ++---
>  drivers/thermal/db8500_thermal.c                   |  5 +++-
>  drivers/thermal/hisi_thermal.c                     | 22 ++++----------
>  drivers/thermal/imx_thermal.c                      |  3 +-
>  drivers/thermal/int340x_thermal/int3400_thermal.c  |  1 +
>  drivers/thermal/intel_bxt_pmic_thermal.c           |  3 +-
>  drivers/thermal/intel_soc_dts_iosf.c               |  3 +-
>  drivers/thermal/max77620_thermal.c                 |  6 ++--
>  drivers/thermal/mtk_thermal.c                      |  3 ++
>  drivers/thermal/of-thermal.c                       |  6 ++--
>  drivers/thermal/qcom-spmi-temp-alarm.c             |  5 +++-
>  drivers/thermal/qcom/tsens.c                       |  6 ++++
>  drivers/thermal/qoriq_thermal.c                    |  3 ++
>  drivers/thermal/rcar_gen3_thermal.c                |  7 +++--
>  drivers/thermal/rcar_thermal.c                     |  8 +++--
>  drivers/thermal/rockchip_thermal.c                 | 34 ++++++++++------------
>  drivers/thermal/samsung/exynos_tmu.c               |  7 ++++-
>  drivers/thermal/st/st_thermal_memmap.c             |  3 +-
>  drivers/thermal/tango_thermal.c                    |  5 ++++
>  drivers/thermal/tegra/soctherm.c                   |  3 ++
>  drivers/thermal/tegra/tegra-bpmp-thermal.c         |  3 ++
>  drivers/thermal/thermal-generic-adc.c              |  3 ++
>  drivers/thermal/thermal_core.c                     | 14 ++++-----
>  drivers/thermal/thermal_helpers.c                  | 33 +++++++++++++++++++++
>  drivers/thermal/thermal_sysfs.c                    | 17 +++++++----
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  7 ++++-
>  drivers/thermal/uniphier_thermal.c                 |  6 +++-
>  drivers/thermal/x86_pkg_temp_thermal.c             |  2 +-
>  drivers/thermal/zx2967_thermal.c                   |  3 ++
>  include/linux/thermal.h                            |  5 ++++
>  37 files changed, 173 insertions(+), 84 deletions(-)
>
> --
> 1.9.1
