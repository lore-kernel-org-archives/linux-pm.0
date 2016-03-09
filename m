From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 00/13] thermal: convert users of thermal_zone_of_sensor_register to devm_
Date: Wed,  9 Mar 2016 13:35:22 -0800
Message-ID: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35110 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbcCIVfk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 16:35:40 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Eduardo Valentin <edubezval@gmail.com>

Hello,

Given that now we have a devm version of thermal_zone_of_sensor_register [1],
I am sending this series of patches to convert its users to use the devm_
API.

Driver's authors, please comment.

BR,

Eduardo Valentin (13):
  hwmon: convert lm75 to use devm_thermal_zone_of_sensor_register
  hwmon: convert ntc_thermistor to use
    devm_thermal_zone_of_sensor_register
  hwmon: convert tmp102 to use devm_thermal_zone_of_sensor_register
  hwmon: convert scpi-hwmon to use devm_thermal_zone_of_sensor_register
  input: convert sun4i-ts to use devm_thermal_zone_of_sensor_register
  thermal: convert hisi_thermal to use
    devm_thermal_zone_of_sensor_register
  thermal: convert mtk_thermal to use
    devm_thermal_zone_of_sensor_register
  thermal: convert qcom-spmi to use devm_thermal_zone_of_sensor_register
  thermal: convert rcar_thermal to use
    devm_thermal_zone_of_sensor_register
  thermal: convert rockchip_thermal to use
    devm_thermal_zone_of_sensor_register
  thermal: convert exynos to use devm_thermal_zone_of_sensor_register
  thermal: convert tegra_thermal to use
    devm_thermal_zone_of_sensor_register
  thermal: convert ti-thermal to use
    devm_thermal_zone_of_sensor_register

 drivers/hwmon/lm75.c                               | 10 ++----
 drivers/hwmon/ntc_thermistor.c                     | 12 +++----
 drivers/hwmon/scpi-hwmon.c                         | 41 +++++-----------------
 drivers/hwmon/tmp102.c                             |  8 ++---
 drivers/input/touchscreen/sun4i-ts.c               |  9 +----
 drivers/thermal/hisi_thermal.c                     |  5 ++-
 drivers/thermal/mtk_thermal.c                      | 12 ++-----
 drivers/thermal/qcom-spmi-temp-alarm.c             |  3 +-
 drivers/thermal/rcar_thermal.c                     |  2 +-
 drivers/thermal/rockchip_thermal.c                 | 17 +++------
 drivers/thermal/samsung/exynos_tmu.c               | 12 +++----
 drivers/thermal/tegra_soctherm.c                   | 31 +++++-----------
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  5 +--
 13 files changed, 42 insertions(+), 125 deletions(-)

-- 
2.1.4

