From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 0/3] add thermal driver for h6
Date: Sun, 12 May 2019 04:26:11 -0400
Message-ID: <20190512082614.9045-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiny.windzz@gmail.com, rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, catalin.marinas@arm.com, will.deacon@arm.com, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com, paulmck@linux.ibm.com, andy.gross@linaro.org, olof@lixom.net, bjorn.andersson@linaro.org, jagan@amarulasolutions.com, marc.w.gonzalez@free.fr, stefan.wahren@i2se.com, enric.balletbo@collabora.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patchset support thermal driver of allwinner H6.

Yangtao Li (3):
  arm64: defconfig: add allwinner sid support
  thermal: sun50i: add thermal driver for h6
  dt-bindings: thermal: add binding document for h6 thermal controller

 .../bindings/thermal/sun50i-thermal.txt       |  32 ++
 MAINTAINERS                                   |   7 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/thermal/Kconfig                       |  14 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/sun50i_thermal.c              | 357 ++++++++++++++++++
 6 files changed, 412 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun50i-thermal.txt
 create mode 100644 drivers/thermal/sun50i_thermal.c

-- 
2.17.0
