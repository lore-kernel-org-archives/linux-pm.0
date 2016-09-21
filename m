From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V7 0/6] thermal: bcm2835: add thermal driver
Date: Wed, 21 Sep 2016 08:23:41 +0000
Message-ID: <1474446227-1147-1-git-send-email-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

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
 V5 -> V6: incorporated changes recommended by Stefan Wahren
 V6 -> V7: removed depends on ARCH_BCM2836 || ARCH_BCM2837 in Kconfig

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
 drivers/thermal/Kconfig                            |   8 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/bcm2835_thermal.c                  | 340 +++++++++++++++++++++
 10 files changed, 394 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
 create mode 100644 drivers/thermal/bcm2835_thermal.c

--
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
