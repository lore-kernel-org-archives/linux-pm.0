From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 00/17] thermal: enable/check sensor after its setup is
 finished
Date: Fri, 14 Sep 2018 15:17:53 +0200
Message-ID: <20180914131756eucas1p266c09a2e6c6dc8e303acd1174cd38c5a~URqvRKrwN2497224972eucas1p2u@eucas1p2.samsung.com>
References: <CGME20180410124240epcas2p25c8979583c41f147ac34c49faf30aa14@epcas2p2.samsung.com>
        <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <20180910173659.GB4196@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910173659.GB4196@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 09/10/2018 07:37 PM, Eduardo Valentin wrote:
> On Tue, Apr 10, 2018 at 02:41:54PM +0200, Bartlomiej Zolnierkiewicz wrote:
>> Hi,
>>
>> [devm]_thermal_zone_of_sensor_register() is used to register
>> thermal sensor by thermal drivers using DeviceTree. Besides
>> registering sensor this function also immediately enables it
>> (using ->set_mode method) and then checks it with a update call
>> to the thermal core (which ends up using ->get_temp method).
> 
> Yeah, pretty much the driver needs to be ready to answer to callbacks
> once it calls thermal_*_register() method.
> 
>> For many DT thermal drivers this causes a problem because
> 
> Can you be more specific? Are you seeing this problem in samsung driver
> or in other drivers too?

We were hitting the issue in exynos driver and we have added
workaround for it in the driver itself (commit 0eb875d88aaa
"thermal: exynos: Reading temperature makes sense only when TMU
is turned on").

After that I did the audit of all DT thermal drivers and found
the issue in majority of them (patches #5-16):

- bcm2835
- brcmstb
- hisi_thermal
- tsens
- qoriq
- rcar_gen3_thermal
- rockchip_thermal
- exynos
- tegra
- ti-soc-thermal
- uniphier
- zx2967

>> [devm]_thermal_zone_of_sensor_register() need to be called in
>> order to obtain data about thermal trips which are then used to
>> finish hardware sensor setup (only after which ->get_temp can
>> be used). The issue has been observed when using Samsung Exynos
> 
> Oh I see, this is because trip info is read by the of thermal thermal
> then, correct?

Yes, some drivers need trip info for sensor configuration.

There is also related issue for drivers that support IRQ
(i.e. exynos and rockchip ones):

- sensor should be enabled only after IRQ handler is requested
  (because otherwise we might get IRQs that we can't handle)

- IRQ handler needs tzd structure which is obtained from
  [devm_]thermal_zone_of_sensor_register()

- after [devm_]thermal_zone_of_sensor_register() call core
  thermal code assumes that sensor is enabled and ready to
  use (the core may call ->get_temp)

>> thermal driver and fixed internally in the driver in commit
>> d8efad71e5b6 ("thermal: exynos: Reading temperature makes sense
>> only when TMU is turned on"). However after this commit there
>> are now following warnings from the thermal core visible:
>>
>> [    3.453602] thermal thermal_zone0: failed to read out thermal zone (-22)
>> [    3.483468] thermal thermal_zone1: failed to read out thermal zone (-22)
>> [    3.505965] thermal thermal_zone2: failed to read out thermal zone (-22)
>> [    3.528455] thermal thermal_zone3: failed to read out thermal zone (-22)
>> [    3.550939] thermal thermal_zone4: failed to read out thermal zone (-22)
>>
>> This patchset attempts to directly address the thermal core
>> problem with [devm]_thermal_zone_of_sensor_register() and
>> affected DT thermal drivers. In order to achieve this sensor
>> registration, enable and check operations are separated and
>> corresponding drivers are modified to use the new helpers to
>> enable and check sensor explicitly.
>>
> 
> Ok. Up to this point I followed that this is a samsung driver issue, not
> we need to change the core to fix adapt to it?

Well, we need core changes (patches #2 and #4) for (IMHO) cleaner and
more straightforward solution (with it the core can have the valid info
about the sensor state all the time).

Alternatively we can add workarounds (like the one we added in exynos
driver) to all affected DT thermal drivers (with this solution sensor
can be disabled while the core will think that it is enabled)..

> And adapting the core should be fine to fit a new use/fix something,
> as long the issue is well described..
> 
>> Tested on Exynos5422 based Odroid-XU3 Lite board (aforementioned
>> warnings from the thermal core are now gone).
>>
>> Best regards,
>> --
>> Bartlomiej Zolnierkiewicz
>> Samsung R&D Institute Poland
>> Samsung Electronics
>>
>>
>> Bartlomiej Zolnierkiewicz (17):
>>   thermal: add thermal_zone_device_toggle() helper
>>   thermal: separate sensor registration and enable
>>   thermal: add thermal_zone_device_check() helper
>>   thermal: do sensor checking explicitly in drivers
>>   thermal: bcm2835: enable/check sensor after its setup is finished
>>   thermal: brcmstb: enable/check sensor after its setup is finished
>>   thermal: hisi_thermal: enable/check sensor after its setup is finished
>>   thermal: qcom: tsens: enable/check sensor after its setup is finished
>>   thermal: qoriq: enable/check sensor after its setup is finished
>>   thermal: rcar_gen3_thermal: enable/check sensor after its setup is
>>     finished
>>   thermal: rockchip_thermal: enable/check sensor after its setup is
>>     finished
>>   thermal: exynos: enable/check sensor after its setup is finished
>>   thermal: tegra: enable/check sensor after its setup is finished
>>   thermal: ti-soc-thermal: enable/check sensor after its setup is
>>     finished
>>   thermal: uniphier: enable/check sensor after its setup is
>>     finished
>>   thermal: zx2967: enable/check sensor after its setup is finished
>>   thermal: warn on attempts to read temperature on disabled sensors
>>
>>  drivers/acpi/thermal.c                             |  5 ++--
>>  drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  1 -
>>  drivers/platform/x86/acerhdf.c                     |  6 +++-
>>  drivers/regulator/max8973-regulator.c              |  3 +-
>>  drivers/thermal/broadcom/bcm2835_thermal.c         |  3 ++
>>  drivers/thermal/broadcom/brcmstb_thermal.c         |  3 ++
>>  drivers/thermal/broadcom/ns-thermal.c              |  3 ++
>>  drivers/thermal/da9062-thermal.c                   |  7 ++---
>>  drivers/thermal/db8500_thermal.c                   |  5 +++-
>>  drivers/thermal/hisi_thermal.c                     | 22 ++++----------
>>  drivers/thermal/imx_thermal.c                      |  3 +-
>>  drivers/thermal/int340x_thermal/int3400_thermal.c  |  1 +
>>  drivers/thermal/intel_bxt_pmic_thermal.c           |  3 +-
>>  drivers/thermal/intel_soc_dts_iosf.c               |  3 +-
>>  drivers/thermal/max77620_thermal.c                 |  6 ++--
>>  drivers/thermal/mtk_thermal.c                      |  3 ++
>>  drivers/thermal/of-thermal.c                       |  6 ++--
>>  drivers/thermal/qcom-spmi-temp-alarm.c             |  5 +++-
>>  drivers/thermal/qcom/tsens.c                       |  6 ++++
>>  drivers/thermal/qoriq_thermal.c                    |  3 ++
>>  drivers/thermal/rcar_gen3_thermal.c                |  7 +++--
>>  drivers/thermal/rcar_thermal.c                     |  8 +++--
>>  drivers/thermal/rockchip_thermal.c                 | 34 ++++++++++------------
>>  drivers/thermal/samsung/exynos_tmu.c               |  7 ++++-
>>  drivers/thermal/st/st_thermal_memmap.c             |  3 +-
>>  drivers/thermal/tango_thermal.c                    |  5 ++++
>>  drivers/thermal/tegra/soctherm.c                   |  3 ++
>>  drivers/thermal/tegra/tegra-bpmp-thermal.c         |  3 ++
>>  drivers/thermal/thermal-generic-adc.c              |  3 ++
>>  drivers/thermal/thermal_core.c                     | 14 ++++-----
>>  drivers/thermal/thermal_helpers.c                  | 33 +++++++++++++++++++++
>>  drivers/thermal/thermal_sysfs.c                    | 17 +++++++----
>>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  7 ++++-
>>  drivers/thermal/uniphier_thermal.c                 |  6 +++-
>>  drivers/thermal/x86_pkg_temp_thermal.c             |  2 +-
>>  drivers/thermal/zx2967_thermal.c                   |  3 ++
>>  include/linux/thermal.h                            |  5 ++++
>>  37 files changed, 173 insertions(+), 84 deletions(-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
