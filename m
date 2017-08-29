From: Tao Wang <kevin.wangtao@hisilicon.com>
Subject: [PATCH v4 0/3] thermal: add thermal sensor driver for Hi3660
Date: Tue, 29 Aug 2017 16:17:43 +0800
Message-ID: <1503994666-13954-1-git-send-email-kevin.wangtao@hisilicon.com>
References: <e313015d-11d5-91b8-aa64-37e9410cb882@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e313015d-11d5-91b8-aa64-37e9410cb882@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: leo.yan@linaro.org, kevin.wangtao@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sunzhaosheng@hisilicon.com, gengyanping@hisilicon.com
List-Id: linux-pm@vger.kernel.org

From: Tao Wang <kevin.wangtao@linaro.org>

This series adds thermal support for Hi3660 Soc, which support
all the hardware temperture sensors and two virtual sensors(one
for maximum value of all and one for average value of all).

Patch 1 add dt-binding document to describe how to config dt
for the driver.
Patch 2 introduces the thermal sensor driver.
Patch 3 add dts for the thermal senor driver on Hi3660.

Changes in v2:
- correct alphabet order
- correct compatible name
- remove redundant property
- rebase changes on linux next

Changes in v3:
- remove unnecessary log print
- described all platform related parameters in DT
- make the driver forward compatible

Changes in v4:
- add more description about the sensor in Documentation
- correct dts property name

Tao Wang (3):
  dt-bindings: Document the hi3660 thermal sensor bindings
  thermal: hisilicon: add thermal sensor driver for Hi3660
  arm64: dts: register Hi3660's thermal sensor

 .../devicetree/bindings/thermal/hisi-tsensor.txt   |  37 ++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  14 ++
 drivers/thermal/Kconfig                            |  13 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/hisi_tsensor.c                     | 209 +++++++++++++++++++++
 include/dt-bindings/thermal/hi3660-thermal.h       |  31 +++
 6 files changed, 305 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/hisi-tsensor.txt
 create mode 100644 drivers/thermal/hisi_tsensor.c
 create mode 100644 include/dt-bindings/thermal/hi3660-thermal.h

-- 
2.8.1
