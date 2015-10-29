From: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Subject: [PATCH 0/2] power: Add support for TI BQ24261 charger
Date: Thu, 29 Oct 2015 22:04:13 +0530
Message-ID: <1446136455-20752-1-git-send-email-ramakrishna.pallala@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: Pallala Ramakrishna <ramakrishna.pallala@intel.com>, Jenny Tc <jenny.tc@intel.com>, Andreas Dannenberg <dannenberg@ti.com>
List-Id: linux-pm@vger.kernel.org

This patch series adds the support for TI BQ24261 charger driver.

TI BQ24261 charger driver relies on extcon notifications to get the
charger cable type and based on that it will set the charging parameters.

Ramakrishna Pallala (2):
  dt: power: Add support for BQ24261 charger
  power: Add support for TI BQ24261 charger

 .../devicetree/bindings/power/bq24261.txt          |   34 +
 drivers/power/Kconfig                              |    6 +
 drivers/power/Makefile                             |    1 +
 drivers/power/bq24261_charger.c                    | 1195 ++++++++++++++++++++
 include/linux/power/bq24261_charger.h              |   26 +
 5 files changed, 1262 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/bq24261.txt
 create mode 100644 drivers/power/bq24261_charger.c
 create mode 100644 include/linux/power/bq24261_charger.h

-- 
1.7.9.5
