From: <sean.wang@mediatek.com>
Subject: [PATCH v1 00/16] Add support to MT6323 RTC and its power device
Date: Fri, 23 Mar 2018 17:14:57 +0800
Message-ID: <cover.1521794176.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, lee.jones@linaro.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, eddie.huang@mediatek.com
Cc: devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Hi,

The series keeps to extend the capability of BPI-R2 board with MT7623 and
the result can as well bring benefits into the other MediaTek PMICs such
as MT6397 or SoCs.

The series sent across mfd, rtc, pm, dt-binding sub-system is for hoping
to let people have a simple cross-reference to know the exact dependency
and why those patches are being split in that way between each one.

Patch 1-3: Add dt-binding to the related devices newly or already
	   supported.
Patch 4-5: Extend driver with the functionality of MT6323 RTC device.
Patch 6-9 and 12-13: Add a few of trivial fixups, cleanups and
	  improvements.
Patch 10-11: It's a preparation for Patch 14 adding a new driver.
Patch 14: Add a new driver for a power-off driver.
Patch 15-16: Update MAINTAINERS with these new files being added.

	Sean

Sean Wang (16):
  dt-bindings: power: reset: mediatek: add bindings for power device
  dt-bindings: rtc: mediatek: add bindings for PMIC RTC
  dt-bindings: mfd: mediatek: add a description for MT6323 RTC
  mfd: mt6397: add MT6323 RTC support into MT6397 driver
  rtc: mediatek: add MT6323 support to RTC driver
  rtc: mediatek: remove unnecessary parentheses
  rtc: mediatek: replace a poll with regmap_read_poll_timeout
  rtc: mediatek: remove unnecessary irq_dispose_mapping
  rtc: mediatek: convert to use device managed functions
  rtc: mediatek: add devm_of_platform_populate
  rtc: mediatek: move the declaration into a globally visible header
    file
  rtc: mediatek: cleanup header files to include
  rtc: mediatek: update license converting to using SPDX identifiers
  power: reset: mediatek: add a power-off driver using PMIC RTC device
  MAINTAINERS: update entry for ARM/Mediatek RTC DRIVER
  MAINTAINERS: add an entry for MediaTek board level shutdown driver

 Documentation/devicetree/bindings/mfd/mt6397.txt   |   4 +-
 .../bindings/power/reset/mt6397-rtc-poweroff.txt   |  24 ++++
 .../devicetree/bindings/rtc/rtc-mt6397.txt         |  39 ++++++
 MAINTAINERS                                        |   9 ++
 drivers/mfd/mt6397-core.c                          |  23 +++-
 drivers/power/reset/Kconfig                        |   9 ++
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/mt6397-rtc-poweroff.c          | 100 ++++++++++++++
 drivers/rtc/rtc-mt6397.c                           | 145 +++++----------------
 include/linux/rtc/mt6397.h                         |  73 +++++++++++
 10 files changed, 314 insertions(+), 113 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
 create mode 100644 drivers/power/reset/mt6397-rtc-poweroff.c
 create mode 100644 include/linux/rtc/mt6397.h

-- 
2.7.4
