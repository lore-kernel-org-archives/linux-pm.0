From: kernel@martin.sperl.org
Subject: [PATCH V3 0/5] bcm2835: add thermal driver
Date: Tue, 17 May 2016 14:35:48 +0000
Message-ID: <1463495753-967-1-git-send-email-kernel@martin.sperl.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 212-186-180-163.static.surfer.at ([212.186.180.163]:55164 "EHLO
	cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbcEQOf7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2016 10:35:59 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Martin Sperl <kernel@martin.sperl.org>

From: Martin Sperl <kernel@martin.sperl.org>

Add a thermal driver for the TSENSE device of the bcm2835 SOC.

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
  it is we can implement that
* the device can also reset the HW after the trip point
  has been reached (also with some delay, so that corrective
  actions can get taken) - this is currently not enabled by the
  firmware, but could.
* we could define more trip points for THERMAL_TRIP_HOT
* make the trip point limits modifiable (ops.set_trip_temp)

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

Martin Sperl (5):
  dt: bindings: add thermal device driver for bcm2835
  thermal: bcm2835: add thermal driver for bcm2835 soc
  ARM: bcm2835: add thermal node to device-tree of bcm283x
  ARM: bcm2835: add thermal driver to default_config
  ARM: multi_v7_defconfig: bcm2835: add bcm2835-thermal driver

 .../bindings/thermal/brcm,bcm2835-thermal.txt      |  17 ++
 arch/arm/boot/dts/bcm283x.dtsi                     |   6 +
 arch/arm/configs/bcm2835_defconfig                 |   2 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/thermal/Kconfig                            |   5 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/bcm/Kconfig                        |   4 +
 drivers/thermal/bcm/Makefile                       |   1 +
 drivers/thermal/bcm/bcm2835_thermal.c              | 326 +++++++++++++++++++++
 9 files changed, 363 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
 create mode 100644 drivers/thermal/bcm/Kconfig
 create mode 100644 drivers/thermal/bcm/Makefile
 create mode 100644 drivers/thermal/bcm/bcm2835_thermal.c

--
2.1.4
