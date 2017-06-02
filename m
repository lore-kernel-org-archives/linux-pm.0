From: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Subject: [PATCH 0/3] Battery monitor MAX1721x with w1-regmap and w1-slave (resend)
Date: Fri,  2 Jun 2017 10:06:26 +0300
Message-ID: <20170602070629.8210-1-minimumlaw@rambler.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
List-Id: linux-pm@vger.kernel.org

Codding style fix. Maillist message subject fix.
Soryy for all. It's hard to be stuppid :-(

Alex A. Mihaylov (3):
  regmap: Add 1-Wire bus support
  w1: MAX1721x Stanalone Fuel Gauge - add 1-Wire slave drivers
  power: supply: Add support MAX1721x battery monitor

 drivers/base/regmap/Kconfig             |   6 +-
 drivers/base/regmap/Makefile            |   1 +
 drivers/base/regmap/regmap-w1.c         | 245 ++++++++++++++++++++++
 drivers/power/supply/Kconfig            |  14 ++
 drivers/power/supply/Makefile           |   1 +
 drivers/power/supply/max1721x_battery.c | 357 ++++++++++++++++++++++++++++++++
 drivers/w1/slaves/Kconfig               |  12 ++
 drivers/w1/slaves/Makefile              |   1 +
 drivers/w1/slaves/w1_max1721x.c         |  73 +++++++
 drivers/w1/slaves/w1_max1721x.h         | 102 +++++++++
 drivers/w1/w1_family.h                  |   1 +
 include/linux/regmap.h                  |  34 +++
 12 files changed, 846 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/regmap/regmap-w1.c
 create mode 100644 drivers/power/supply/max1721x_battery.c
 create mode 100644 drivers/w1/slaves/w1_max1721x.c
 create mode 100644 drivers/w1/slaves/w1_max1721x.h

-- 
2.13.0
