From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 0/4] Add support for DA9150 Fuel-Gauge
Date: Thu, 18 Jun 2015 17:06:25 +0100
Message-ID: <cover.1434643491.git.Adam.Thomson.Opensource@diasemi.com>
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

Adam Thomson (4):
  mfd: da9150: Add support for Fuel-Gauge
  mfd: da9150: Update DT bindings for Fuel-Gauge support
  power: Add support for DA9150 Fuel-Gauge
  power: da9150: Add DT bindings documentation for Fuel-Gauge

 Documentation/devicetree/bindings/mfd/da9150.txt   |   6 +
 .../devicetree/bindings/power/da9150-fg.txt        |  23 +
 drivers/mfd/da9150-core.c                          | 162 +++++-
 drivers/power/Kconfig                              |  10 +
 drivers/power/Makefile                             |   1 +
 drivers/power/da9150-fg.c                          | 589 +++++++++++++++++++++
 include/linux/mfd/da9150/core.h                    |  19 +
 include/linux/mfd/da9150/fg.h                      |  39 ++
 8 files changed, 841 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/da9150-fg.txt
 create mode 100644 drivers/power/da9150-fg.c
 create mode 100644 include/linux/mfd/da9150/fg.h

--
1.9.3
