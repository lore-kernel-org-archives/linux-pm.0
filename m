From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH RESEND 0/3] power: rt5033: Add Richtek RT533 drivers
Date: Tue, 06 Jan 2015 14:45:14 +0900
Message-ID: <1420523117-6814-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54412 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbbAFFpV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 00:45:21 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: lee.jone@linaro.org, broonie@kernel.org, sre@kernel.org, dbaryshkov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, cw00.choi@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com, Beomho Seo <beomho.seo@samsung.com>

This patchset adds driver for Richtek rt5033 chip The chip contains
switching charge mode Li-Ion/Li-Polymer battery charger, fuelgauge.
Additionally, This includes document for device tree of RT5033 device.

RT5033 core driver is applied by Lee Jones.
RT5033 regulator driver have been merged by Mark Brown. commit is below,

commit b1917578fd5d8efa67afa05a0d6d7e323f2802da

Beomho Seo (3):
  power: rt5033_battery: Add RT5033 Fuel gauge device driver
  power: rt5033_charger: Add RT5033 charger device driver
  Documentation: Add documentation for rt5033 multifunction device

 Documentation/devicetree/bindings/mfd/rt5033.txt   |  108 +++++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/power/Kconfig                              |   16 +
 drivers/power/Makefile                             |    2 +
 drivers/power/rt5033_battery.c                     |  177 +++++++
 drivers/power/rt5033_charger.c                     |  485 ++++++++++++++++++++
 6 files changed, 789 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rt5033.txt
 create mode 100644 drivers/power/rt5033_battery.c
 create mode 100644 drivers/power/rt5033_charger.c

-- 
1.7.9.5

