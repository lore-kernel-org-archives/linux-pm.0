From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3 0/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Date: Wed, 10 Apr 2019 13:41:37 -0400
Message-ID: <20190410174139.20012-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiny.windzz@gmail.com, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, nicolas.ferre@microchip.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add sunxi nvmem based CPU scaling driver, refers to qcom-cpufreq-kryo.

Yangtao Li (2):
  cpufreq: Add sunxi nvmem based CPU scaling driver
  dt-bindings: cpufreq: Document allwinner,cpu-operating-points-v2

 .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 168 +++++++++++++
 MAINTAINERS                                   |   7 +
 drivers/cpufreq/Kconfig.arm                   |  10 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 drivers/cpufreq/sunxi-cpufreq-nvmem.c         | 232 ++++++++++++++++++
 6 files changed, 420 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
 create mode 100644 drivers/cpufreq/sunxi-cpufreq-nvmem.c

---
v3:
-update changelog and title
-convert compatibles to allwinner,cpu-operating-points-v2
-document the valid names for opp-microvolt-<name>
v2:
-update changelog
-convert to dev_pm_opp_set_prop_name instead of
 dev_pm_opp_set_supported_hw
-some change in OPP Node 
---
2.17.0
