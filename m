From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 0/2] add thermal driver for h6
Date: Thu, 16 May 2019 13:26:31 -0400
Message-ID: <20190516172633.12607-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, linus.walleij@linaro.org, Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patchset supprt H6 thermal controller.

Yangtao Li (2):
  thermal: sun8i: add thermal driver for h6
  dt-bindings: thermal: add binding document for h6 thermal controller

 .../bindings/thermal/sun8i-thermal.txt        |  34 ++
 MAINTAINERS                                   |   7 +
 drivers/thermal/Kconfig                       |  14 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/sun8i_thermal.c               | 422 ++++++++++++++++++
 5 files changed, 478 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.txt
 create mode 100644 drivers/thermal/sun8i_thermal.c

---
v2:
-Additions and deletions of some comments
-Change some function prefix to "ths_"
-Support interrupt
---
2.17.0
