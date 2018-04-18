From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 00/17] thermal: enable/check sensor after its setup is
 finished
Date: Thu, 19 Apr 2018 00:26:07 +0200 (CEST)
Message-ID: <1578244948.69815.1524090367636@email.1und1.de>
References: <CGME20180410124240epcas2p25c8979583c41f147ac34c49faf30aa14@epcas2p2.samsung.com>
 <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Markus Mayer <mmayer@broadcom.com>, linux-pm@vger.kernel.org, Eric Anholt <eric@anholt.net>, Keerthy <j-keerthy@ti.com>, bcm-kernel-feedback-list@broadcom.com, Jonathan Hunter <jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org, Jun Nie <jun.nie@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Baoyou Xie <baoyou.xie@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Bartlomiej,

> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> hat am 10. April 2018 um 14:41 geschrieben:
> 
> 
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

i've tested patch 1-5 + 17 on a Raspberry Pi 1 B and didn't see any regressions.

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
