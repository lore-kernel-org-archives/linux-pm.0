From: Alexandre Bailon <abailon@baylibre.com>
Subject: [RFC PATCH 0/3] Add support of busfreq
Date: Wed, 13 Mar 2019 20:34:05 +0100
Message-ID: <20190313193408.23740-1-abailon@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, georgi.djakov@linaro.org
Cc: mturquette@baylibre.com, ptitiano@baylibre.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, zening.wang@nxp.com, aisheng.dong@nxp.com, khilman@baylibre.com, ccaione@baylibre.com, Alexandre Bailon <abailon@baylibre.com>
List-Id: linux-pm@vger.kernel.org

This series implements busfreq, a framework used in MXP's
tree to scale the interconnect and dram frequencies.
In the vendor tree, device's driver request for a
performance level, which is used to scale the frequencies.
This series implements it using the interconnect framework.
Devices' driver request for bandwidth which is use by busfreq
to determine a performance level, and then scale the frequency.

Busfreq is quite generic. It could be used for any i.MX SoC.
A busfreq platform driver just have to define a list of
interconnect nodes, and some OPPs.

This series is sent as RFC mostly because the current support
of i.MX SoC won't benefit of busfreq framework, because the
clocks' driver don't support interconnect / dram frequency
scaling.
As exemple, this series implements busfreq for i.MX8MM whose
upstreaming is in progress. Because this relies on ATF to
do the frequency scaling, it won't be hard make it work.

As exemple, this series implements busfreq for 
Alexandre Bailon (3):
  drivers: interconnect: Add a driver for i.MX SoC
  drivers: interconnect: imx: Add support of i.MX8MM
  dt-bindings: interconnect: Document fsl,busfreq-imx8mm bindings

 .../bindings/interconnect/imx8mm.txt          |  24 +
 drivers/interconnect/Kconfig                  |   1 +
 drivers/interconnect/Makefile                 |   1 +
 drivers/interconnect/imx/Kconfig              |  17 +
 drivers/interconnect/imx/Makefile             |   2 +
 drivers/interconnect/imx/busfreq-imx8mm.c     | 132 ++++
 drivers/interconnect/imx/busfreq.c            | 570 ++++++++++++++++++
 drivers/interconnect/imx/busfreq.h            | 123 ++++
 include/dt-bindings/interconnect/imx8mm.h     |  37 ++
 9 files changed, 907 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/imx8mm.txt
 create mode 100644 drivers/interconnect/imx/Kconfig
 create mode 100644 drivers/interconnect/imx/Makefile
 create mode 100644 drivers/interconnect/imx/busfreq-imx8mm.c
 create mode 100644 drivers/interconnect/imx/busfreq.c
 create mode 100644 drivers/interconnect/imx/busfreq.h
 create mode 100644 include/dt-bindings/interconnect/imx8mm.h

-- 
2.19.2
