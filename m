From: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Subject: [PATCH 0/4] Maxim Semiconductor MAX1721x power_supply driver
Date: Thu, 25 May 2017 20:46:35 +0300
Message-ID: <20170525174639.3191-1-minimumlaw@rambler.ru>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from huan3.mail.rambler.ru ([81.19.78.109]:42116 "EHLO
        huan3.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758412AbdEYRqp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2017 13:46:45 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Alex A. Mihaylov" <minimumlaw@rambler.ru>

Maxim Semiconductor MAX1721x series chip is standalone fuel gauge
for singlecell (MAX17211) or multicell (MAX17215) batteries.
This device use OneWire (W1) interface with W1-Family code 0x26

PATCHES:
  1. Introduce regmap infrastructure over Maxim/Dalas OneWire (W1) bus
  2. Introduce new OneWire (W1) family 0x26 with slave device Maxim
    Semconductor MAX17211/MAX17215 Fuel Gauge IC
  3.Introduce Maxim Semiconductor MAX17211/MAX17215 Standalone Fuel Gauge
    IC support for power_supply class driver
  4. Fix W1 slave exchange with second device on probe step

 drivers/base/regmap/Kconfig             |   6 +-
 drivers/base/regmap/Makefile            |   1 +
 drivers/base/regmap/regmap-w1.c         | 241 +++++++++++++++++++++
 drivers/power/supply/Kconfig            |  14 ++
 drivers/power/supply/Makefile           |   1 +
 drivers/power/supply/max1721x_battery.c | 357 ++++++++++++++++++++++++++++++++
 drivers/w1/slaves/Kconfig               |  12 ++
 drivers/w1/slaves/Makefile              |   1 +
 drivers/w1/slaves/w1_max1721x.c         |  73 +++++++
 drivers/w1/slaves/w1_max1721x.h         | 102 +++++++++
 drivers/w1/w1.c                         |   4 +-
 drivers/w1/w1_family.h                  |   1 +
 include/linux/regmap.h                  |  34 +++
 13 files changed, 844 insertions(+), 3 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-w1.c
 create mode 100644 drivers/power/supply/max1721x_battery.c
 create mode 100644 drivers/w1/slaves/w1_max1721x.c
 create mode 100644 drivers/w1/slaves/w1_max1721x.h

-- 
2.8.4 (Apple Git-73)
