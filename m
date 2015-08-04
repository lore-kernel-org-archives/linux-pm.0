From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v4 0/6] Add support for DA9150 Fuel-Gauge
Date: Tue, 4 Aug 2015 17:16:23 +0100
Message-ID: <cover.1438692348.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.148]:5841 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751784AbbHDQQc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 12:16:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>

This patch set adds support for the Dialog DA9150 Fuel-Gauge.

In this patch set the following is provided:
 - MFD Core and DT bindings updates.
 - Power Supply Fuel-Gauge support and DT bindings documentation.

This patch set is baselined against the v4.2-rc5 kernel version.

Changes in v4:
 - MFD, Power, DT: Update DT compatible & driver name strings for Fuel Gauge,
                   in line with maintainers request.
 - Power: Update Kconfig and Makefile to use BATTERY_* for config entry instead
          of FG_*. Also fuel-gauge module now depends on MFD not Charger.
 - Power: Added helper function to simplify single attribute accesses using QIF
          interface of fuel-gauge.
 - Power: Use of devm_* functions for IRQ and power_supply registration.
 - Power: Added checking of result from platform_get_irq_byname().

Changes in v3:
 - MFD: Some tidy up of code (gotos, dropped FG header, DEFINE_RES_IRQ_NAMED)
 - MFD & Power: Drop use of callback function for temperature reading, as
                requested by Lee Jones.
 - MFD (DT): Binding doc update to flesh out example text.
 - MFD (DT): New patch to change MFD binding doc to use relative paths.
 - MFD: New patch to use DEFINE_RES_IRQ_NAMED for all other IRQ resources.

Changes in v2:
 - Moved temp callback function prototype to be part of power fuel-gauge patch,
   as requested by Lee Jones.

Adam Thomson (6):
  mfd: da9150: Add support for Fuel-Gauge
  mfd: da9150: Update DT bindings for Fuel-Gauge support
  power: Add support for DA9150 Fuel-Gauge
  power: da9150: Add DT bindings documentation for Fuel-Gauge
  mfd: da9150: Use relative paths in DT bindings document
  mfd: da9150: Use DEFINE_RES_IRQ_NAMED() help macro for IRQ resource

 Documentation/devicetree/bindings/mfd/da9150.txt   |  33 +-
 .../devicetree/bindings/power/da9150-fg.txt        |  23 +
 drivers/mfd/da9150-core.c                          | 191 +++++--
 drivers/power/Kconfig                              |  10 +
 drivers/power/Makefile                             |   1 +
 drivers/power/da9150-fg.c                          | 578 +++++++++++++++++++++
 include/linux/mfd/da9150/core.h                    |  19 +-
 7 files changed, 810 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/da9150-fg.txt
 create mode 100644 drivers/power/da9150-fg.c

--
1.9.3

