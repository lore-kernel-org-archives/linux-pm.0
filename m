From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv2 0/2] rpi: add support for rpi power domain driver
Date: Tue,  3 Nov 2015 23:45:09 +0100
Message-ID: <1446590711-18928-1-git-send-email-alex.aring@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f193.google.com ([209.85.212.193]:32780 "EHLO
	mail-wi0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871AbbKCWpZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2015 17:45:25 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, linux@arm.linux.org.uk, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series contains at first a patch for the power domain subsystem
which offers to uninit generic power domains when init was called before.

The RPi Power-Domains need to be enabled/disabled by interacting with the
RPi firmware which can fail. To cleanup the probing we need to undo the
power domains again which was registered before.

- Alex

Alexander Aring (2):
  power: domain: add pm_genpd_uninit
  rpi: add support to enable usb power domain

 .../bindings/arm/bcm/raspberrypi,bcm2835-power.txt |  25 +++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  11 ++
 arch/arm/boot/dts/bcm2835.dtsi                     |   2 +-
 arch/arm/mach-bcm/Kconfig                          |  10 ++
 arch/arm/mach-bcm/Makefile                         |   1 +
 arch/arm/mach-bcm/raspberrypi-power.c              | 180 +++++++++++++++++++++
 drivers/base/power/domain.c                        |  15 ++
 include/dt-bindings/arm/raspberrypi-power.h        |  14 ++
 include/linux/pm_domain.h                          |   4 +
 9 files changed, 261 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
 create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
 create mode 100644 include/dt-bindings/arm/raspberrypi-power.h

-- 
2.6.1

