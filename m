From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v3 0/6] Add support for DA9150 Fuel-Gauge
Date: Tue, 7 Jul 2015 17:34:07 +0100
Message-ID: <cover.1436284659.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

This patch set adds support for the Dialog DA9150 Fuel-Gauge.

In this patch set the following is provided:
 - MFD Core and DT bindings updates.
 - Power Supply Fuel-Gauge support and DT bindings documentation.

This patch set is baselined against the v4.2-rc1 kernel version.

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

 Documentation/devicetree/bindings/mfd/da9150.txt   |  31 +-
 .../devicetree/bindings/power/da9150-fg.txt        |  23 +
 drivers/mfd/da9150-core.c                          | 191 +++++--
 drivers/power/Kconfig                              |  10 +
 drivers/power/Makefile                             |   1 +
 drivers/power/da9150-fg.c                          | 574 +++++++++++++++++++++
 include/linux/mfd/da9150/core.h                    |  19 +-
 7 files changed, 805 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/da9150-fg.txt
 create mode 100644 drivers/power/da9150-fg.c

--
1.9.3
