From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH v3 0/2] power: rt5033: Add Richtek RT533 drivers
Date: Thu, 22 Jan 2015 09:38:10 +0900
Message-ID: <1421887092-4070-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:49290 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbbAVAiQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jan 2015 19:38:16 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sre@kernel.org, robh+dt@kernel.org
Cc: lee.jone@linaro.org, broonie@kernel.org, dbaryshkov@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, cw00.choi@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com, Beomho Seo <beomho.seo@samsung.com>

This patchset adds driver for Richtek rt5033 chip The chip contains
switching charge mode Li-Ion/Li-Polymer battery charger, fuelgauge.
Additionally, This includes document for device tree of RT5033 device.

RT5033 core driver is applied by Lee Jones.
RT5033 regulator driver is applied by Mark Brown.
RT5033 fuelgauge driver is applied by Sebastian Reichel.

Changes in v3:
- Applied one of patchset.
- Add acked-by.

Changes in v2:
- Revise binding documentation..

Beomho Seo (2):
  power: rt5033_charger: Add RT5033 charger device driver
  Documentation: Add documentation for rt5033 multifunction device

 Documentation/devicetree/bindings/mfd/rt5033.txt   |  101 ++++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/power/Kconfig                              |    8 +
 drivers/power/Makefile                             |    1 +
 drivers/power/rt5033_charger.c                     |  485 ++++++++++++++++++++
 5 files changed, 596 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rt5033.txt
 create mode 100644 drivers/power/rt5033_charger.c

-- 
1.7.9.5

