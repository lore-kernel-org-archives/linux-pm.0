From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 0/4] ARM: bcm2835: add support for rpi power domain driver
Date: Sun, 29 Nov 2015 17:59:29 +0100
Message-ID: <1448816373-18235-1-git-send-email-alex.aring@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38724 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbK2Q7v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 29 Nov 2015 11:59:51 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, linux@arm.linux.org.uk, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series contains at first a patch for the power domain subsystem
which offers to exit generic power domains when init was called before.

The RPi Power-Domains need to be enabled/disabled by interacting with the
RPi firmware which can fail. To cleanup the probing we need to undo the
power domains again which was registered before.

- Alex

changes since PATCHv2:
 - rename pm_genpd_uninit to pm_genpd_exit. I adapted here a review note
   from another patch. Usually kernel naming style is like "foobar_init"
   and "foobar_exit" but rarely "uninit". That's why I don't add the ack
   from Ulf Hansson here.
 - split dtsi updates into a separate patch.
 - remove testing steps from commit message.
 - change to "depends on ARCH_BCM2835 || COMPILE_TEST".
 - Add Rob Herring ack.
 - Add Eric Anholt sob.

changes since PATCH (was RFCv2 before):
 - add WARN_ON_ONCE if there are still references from generic power domain
   inside the power domain subsystem when running pm_genpd_uninit.
 - add mutex_destroy when running pm_genpd_uninit.
 - split devicetree binding for rpi power domain driver into a separate patch.
 - rename config RASPBERRY_POWER to RASPBERRYPI_POWER
 - order list of <linux/...> includes alphabetical.
 - use rpi_ prefix than raspberrypi_ prefix.
 - rename _DT_BINDINGS_ARM_BCM2835_MBOX_POWER_H to _DT_BINDINGS_ARM_BCM2835_RPI_POWER_H

changes since RFCv2:
 - add pm_genpd_uninit to handle probing failure.
 - move power domain drive to his own driver in arch/arm/mach-bcm/
   Also add own devicetree node for this driver, "raspberrypi,bcm2835-power".
 - Removing all power domains which might exists for the firmware API but
   we currently have no use-case for it. I tried to keep the same domain
   numbering in generic power domains subsystem like they are offered from
   the firmware API. This works, all power_domains which are NULL inside
   the array of genpd_onecell_data.domains[#] will be ignored.
 - Adding Eric Anholt and me to the authors.
 - Creating devicetree documentation for the power domain driver.
 - fix error handling in raspberrypi_firmware_set_power.
 - Remove comment about mapping between power domains array, this is not
   necessary anymore. I add a "enabled" attribute to raspberrypi_power_domain
   which indicates if a domain should be registered or not (zeroed values
   does not indicate such handling, but enabled is false then).
 - remove "goto mbox" not necessary anymore because an own driver
   implementation.
 - Update devicetrees for changes in v2.

Alexander Aring (4):
  power: domain: add pm_genpd_exit
  ARM: bcm2835: add rpi power domain driver
  devicetree: add rpi power domain driver bindings
  ARM: bcm2835: update rpi devicetree entries

 .../bindings/arm/bcm/raspberrypi,bcm2835-power.txt |  25 +++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  11 ++
 arch/arm/boot/dts/bcm2835.dtsi                     |   2 +-
 arch/arm/mach-bcm/Kconfig                          |  10 ++
 arch/arm/mach-bcm/Makefile                         |   1 +
 arch/arm/mach-bcm/raspberrypi-power.c              | 180 +++++++++++++++++++++
 drivers/base/power/domain.c                        |  22 +++
 include/dt-bindings/arm/raspberrypi-power.h        |  14 ++
 include/linux/pm_domain.h                          |   4 +
 9 files changed, 268 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
 create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
 create mode 100644 include/dt-bindings/arm/raspberrypi-power.h

-- 
2.6.1

