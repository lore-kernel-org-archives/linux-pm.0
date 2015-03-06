From: Jenny TC <jenny.tc@intel.com>
Subject: [RFC 0/4] Enable power supply charging control
Date: Fri,  6 Mar 2015 16:03:23 +0530
Message-ID: <1425638007-9411-1-git-send-email-jenny.tc@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: Anton Vorontsov <anton.vorontsov@linaro.org>, David Woodhouse <dwmw2@infradead.org>, jonghwa3.lee@samsung.com, myungjoo.ham@gmail.com, Pallala Ramakrishna <ramakrishna.pallala@intel.com>, Jenny TC <jenny.tc@intel.com>
List-Id: linux-pm@vger.kernel.org

Enable power supply based charging control for charger manager.
At present charger manager allows to control charging using
regulator interface. This series of patch extends the charger
manager to setup and monitor charging using power supply based
controls. This patch moves the features introduced in
https://lkml.org/lkml/2014/8/13/355  to charger manager.

Jenny TC (4):
  power_supply: Introduce charging object table
  power: core: Add generic interface to get battery specification.
  power_supply: Introduce charger control interface
  charger-manager: Enable psy based charge control

 drivers/power/charger-manager.c       |  486 +++++++++++++++++++++++++--------
 drivers/power/power_supply_core.c     |   86 ++++++
 include/linux/power/charger-manager.h |   30 +-
 include/linux/power_supply.h          |   67 +++++
 4 files changed, 552 insertions(+), 117 deletions(-)

-- 
1.7.9.5
