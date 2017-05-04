From: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Subject: [PATCH 0/3] w1-regmap infrastructure and MAX1721x power_suply
Date: Thu,  4 May 2017 19:16:32 +0300
Message-ID: <20170504161635.12493-1-minimumlaw@rambler.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: "Alex A. Mihaylov" <minimumlaw@rambler.ru>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

  1. Introduce regmap infrastructure over Maxim/Dalas OneWire (W1) bus
  2. Introduce new OneWire (W1) family: 0x26 with slave device Maxim
     Semconductor MAX17211/MAX17215 Fuel Gauge IC
  3. Introduce Maxim Semiconductor MAX17211/MAX17215 Standalone Fuel Gauge
     IC support for power_supply class driver. This driver use w1-regmap API.

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
 drivers/w1/w1_family.h                  |   1 +
 include/linux/regmap.h                  |  34 +++
 12 files changed, 842 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/regmap/regmap-w1.c
 create mode 100644 drivers/power/supply/max1721x_battery.c
 create mode 100644 drivers/w1/slaves/w1_max1721x.c
 create mode 100644 drivers/w1/slaves/w1_max1721x.h

-- 
2.8.4 (Apple Git-73)
