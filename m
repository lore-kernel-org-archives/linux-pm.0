From: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Subject: [0/3] Battery monitor MAX1721x with w1-regmap and w1-slave (resend v2)
Date: Thu,  1 Jun 2017 09:45:56 +0300
Message-ID: <20170601064559.7401-1-minimumlaw@rambler.ru>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from huan2.mail.rambler.ru ([81.19.78.108]:10914 "EHLO
        huan2.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdFAGqJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2017 02:46:09 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Alex A. Mihaylov" <minimumlaw@rambler.ru>

Coding style fixes.

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
