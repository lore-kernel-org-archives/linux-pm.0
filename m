From: kernel@martin.sperl.org
Subject: [PATCH V5 0/6] thermal: bcm2835: add thermal driver
Date: Tue, 13 Sep 2016 09:34:16 +0000
Message-ID: <1473759262-27031-1-git-send-email-kernel@martin.sperl.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:57312
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932282AbcIMJe2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 05:34:28 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Stefan Wahren <stefan.wahren@i2se.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Martin Sperl <kernel@martin.sperl.org>

From: Martin Sperl <kernel@martin.sperl.org>

Add a thermal driver for the TSENSE device of the bcm2835/6/7 SOC.

If the firmware enables the HW, then the configuration is not touched.
In case the firmware has not enabled the device, then we try to set
it up correctly (which unfortunately can not get tested).

It exposes temperature and a critical trip point
(using a hardcoded default of 80C or the temperature configured
in the control register by the firmware, which reads as
407C currently)

The calibrations are (potentially) different for bcm2835, bcm2836
and bcm2837 and can get selected by the compatible property
in the device tree.

The driver also exposes the registers via debugfs.

Possible future enhancements:
* the device has the ability to trigger interrupts on reaching
  the programmed critical temperature.
  I have no knowledge which interrupt could be responsible
  for this on the ARM side, so if we get to know which irq
  it is we can implement that.
  Instead the driver right now implements polling in 1 second intervals
* the device can also reset the HW after the trip point
  has been reached (also with some delay, so that corrective
  actions can get taken) - this is currently not enabled by the
  firmware, but could.
* we could define more trip points for THERMAL_TRIP_HOT
* make the trip point limits modifiable (ops.set_trip_temp)

Note:
  No support for 32-bit arm bcm2837, as there is no
  arch/arm/boot/dts/bcm2836.dtsi upstream as of now.
  64-bit arm support is not tested

Changelog:
 V1 -> V2: renamed dt-binding documentation file
       	   added specific settings depending on compatible
	   added trip point based on register
	   setting up ctrl-register if HW is not enabled by firmware
	     as per recommendation of Eric (untested)
	   check that clock frequency is in range
	     (1.9 - 5MHz - as per comment in clk-bcm2835.c)
 	   added driver to multi_v7_defconfig
 V2 -> V3: made a module in multi_v7_defconfig
           fixed typo in dt-binding document
 V3 -> V4: moved driver back to thermal (not using bcm sub-directory)
       	   set polling interval to 1second (was 0ms, so interrupt driven)
 V4 -> V5: use correct compatiblity for different soc versions in dt
       	   support ARM64 for bcm2837 in devicetree and defconfig

Martin Sperl (6):
  dt: bindings: add thermal device driver for bcm2835
  thermal: bcm2835: add thermal driver for bcm2835 soc
  ARM: bcm2835: dts: add thermal node to device-tree of bcm283x
  ARM64: bcm2835: dts: add thermal node to device-tree of bcm2837
  ARM: bcm2835: add thermal driver to default_config
  ARM64: bcm2835: add thermal driver to default_config

 .../bindings/thermal/brcm,bcm2835-thermal.txt      |  17 ++
 arch/arm/boot/dts/bcm2835.dtsi                     |   6 +
 arch/arm/boot/dts/bcm2836.dtsi                     |   6 +
 arch/arm/boot/dts/bcm283x.dtsi                     |   7 +
 arch/arm/configs/bcm2835_defconfig                 |   2 +
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi          |   6 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/thermal/Kconfig                            |   5 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/bcm2835_thermal.c                  | 327 +++++++++++++++++++++
 10 files changed, 378 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
 create mode 100644 drivers/thermal/bcm2835_thermal.c

--
2.1.4
