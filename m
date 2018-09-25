From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 00/14] thermal/drivers/hi3660: Dual cluster sensors support
Date: Tue, 25 Sep 2018 11:02:58 +0200
Message-ID: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, leo.yan@linaro.org
List-Id: linux-pm@vger.kernel.org

This patch series provides the changes to support the dual clusters sensor on
the hikey960 board.

Most of the patches set the scene for the addition of other sensors which comes
at the end of the series.

Daniel Lezcano (14):
  thermal/drivers/hisi: Change the platform data pointer to sensor ops
  thermal/drivers/hisi: Change the driver to be sensor oriented
  thermal/drivers/hisi: Set the thermal zone private data to the sensor
    pointer
  thermal/drivers/hisi: Factor out the probe functions
  thermal/drivers/hisi: Prepare to support multiple sensors
  thermal/drivers/hisi: Add multiple sensors support
  thermal/drivers/hisi: Replace macro name with relevant sensor location
  ARM64: dts: hisilicon: Add tsensor interrupt name
  thermal/drivers/hisi: Use platform_get_irq_byname
  ARM64: dts: hisilicon: Add interrupt names for the tsensors
  thermal/drivers/hisi: Remove pointless irq field
  thermal/drivers/hisi: Add more sensors channel
  ARM64: dts: hisilicon: Add dual clusters thermal zones for hi3660
  thermal/drivers/hisi: Add the dual clusters sensors for hi3660

 .../bindings/thermal/hisilicon-thermal.txt         |   9 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  60 +++--
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |   1 +
 drivers/thermal/hisi_thermal.c                     | 249 ++++++++++++---------
 4 files changed, 204 insertions(+), 115 deletions(-)

-- 
2.7.4
