From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 00/11] add support for VBUS max current and min voltage limits AXP20X and AXP22X PMICs
Date: Fri,  9 Dec 2016 12:04:08 +0100
Message-ID: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com
List-Id: linux-pm@vger.kernel.org

The X-Powers AXP209 and AXP20X PMICs are able to set a limit for the
VBUS power supply for both max current and min voltage supplied. This
series of patch adds the possibility to set these limits from sysfs.

Also, the AXP223 PMIC shares most of its behaviour with the AXP221 but
the former can set the VBUS power supply max current to 100mA, unlike
the latter. The AXP223 VBUS power supply driver used to probe on the
AXP221 compatible. This series of patch introduces a new compatible for
the AXP223 to be able to set the current max limit to 100mA.

With that new compatible, boards having the AXP223 see their DT updated
to use the VBUS power supply driver with the correct compatible.

This series of patch also migrates from of_device_is_compatible function
to the data field of of_device_id to identify the compatible used to
probe. This improves the code readability.

Mostly cosmetic changes in v2 and adding volatile and writeable regs to
AXP20X and AXP22X MFD cells for the VBUS power supply driver.

Quentin Schulz (11):
  power: supply: axp20x_usb_power: use of_device_id data field instead
    of device_is_compatible
  mfd: axp20x: add volatile and writeable reg ranges for VBUS power
    supply driver
  power: supply: axp20x_usb_power: set min voltage and max current from
    sysfs
  Documentation: DT: binding: axp20x_usb_power: add axp223 compatible
  power: supply: axp20x_usb_power: add 100mA max current limit for
    AXP223
  mfd: axp20x: add separate MFD cell for AXP223
  ARM: dtsi: add DTSI for AXP223
  ARM: dts: sun8i-a33-olinuxino: use AXP223 DTSI
  ARM: dts: sun8i-a33-sinlinx-sina33: use AXP223 DTSI
  ARM: dts: sun8i-r16-parrot: use AXP223 DTSI
  ARM: dtsi: sun8i-reference-design-tablet: use AXP223 DTSI

 .../bindings/power/supply/axp20x_usb_power.txt     |   5 +
 arch/arm/boot/dts/axp223.dtsi                      |  58 +++++++++++
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts          |   2 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   2 +-
 arch/arm/boot/dts/sun8i-r16-parrot.dts             |   2 +-
 .../boot/dts/sun8i-reference-design-tablet.dtsi    |   2 +-
 drivers/mfd/axp20x.c                               |  32 +++++-
 drivers/power/supply/axp20x_usb_power.c            | 116 ++++++++++++++++++---
 8 files changed, 197 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/boot/dts/axp223.dtsi

-- 
2.9.3
