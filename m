From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v3 0/6] power: add power sequence library
Date: Wed, 20 Jul 2016 17:40:23 +0800
Message-ID: <1469007629-31757-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, Peter Chen <peter.chen@nxp.com>
List-Id: linux-pm@vger.kernel.org

Hi all,

This is a follow-up for my last power sequence framework patch set [1].
According to Rob Herring and Ulf Hansson's comments[2], I use a generic
power sequence library for parsing the power sequence elements on DT,
and implement generic power sequence on library. The host driver
can allocate power sequence instance, and calls pwrseq APIs accordingly.

In future, if there are special power sequence requirements, the special
power sequence library can be created.

This patch set is tested on i.mx6 sabresx evk using a dts change, I use
two hot-plug devices to simulate this use case, the related binding
change is updated at patch [1/6], The udoo board changes were tested
using my last power sequence patch set.[3]

Except for hard-wired MMC and USB devices, I find the USB ULPI PHY also
need to power on itself before it can be found by ULPI bus.

[1] http://www.spinics.net/lists/linux-usb/msg142755.html
[2] http://www.spinics.net/lists/linux-usb/msg143106.html
[3] http://www.spinics.net/lists/linux-usb/msg142815.html

Changes for v3:
- Delete "power-sequence" property at binding-doc, and change related code
  at both library and user code.
- Change binding-doc example node name with Rob's comments
- of_get_named_gpio_flags only gets the gpio, but without setting gpio flags,
  add additional code request gpio with proper gpio flags
- Add Philipp Zabel's Ack and MAINTAINER's entry

Changes for v2:
- Delete "pwrseq" prefix and clock-names for properties at dt binding
- Should use structure not but its pointer for kzalloc
- Since chipidea core has no of_node, let core's of_node equals glue
  layer's at core's probe

Peter Chen (6):
  binding-doc: power: pwrseq-generic: add binding doc for generic power
    sequence library
  power: add power sequence library
  binding-doc: usb: usb-device: add optional properties for power
    sequence
  usb: core: add power sequence handling for USB devices
  usb: chipidea: let chipidea core device of_node equal's glue layer
    device of_node
  ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB property

 .../bindings/power/pwrseq/pwrseq-generic.txt       |  48 +++++++
 .../devicetree/bindings/usb/usb-device.txt         |  10 +-
 MAINTAINERS                                        |   9 ++
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  26 ++--
 drivers/power/Kconfig                              |   1 +
 drivers/power/Makefile                             |   1 +
 drivers/power/pwrseq/Kconfig                       |  20 +++
 drivers/power/pwrseq/Makefile                      |   2 +
 drivers/power/pwrseq/core.c                        |  71 ++++++++++
 drivers/power/pwrseq/pwrseq_generic.c              | 151 +++++++++++++++++++++
 drivers/usb/chipidea/core.c                        |  10 ++
 drivers/usb/core/Makefile                          |   1 +
 drivers/usb/core/hub.c                             |  12 +-
 drivers/usb/core/hub.h                             |  12 ++
 drivers/usb/core/pwrseq.c                          | 100 ++++++++++++++
 include/linux/power/pwrseq.h                       |  50 +++++++
 16 files changed, 507 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
 create mode 100644 drivers/power/pwrseq/Kconfig
 create mode 100644 drivers/power/pwrseq/Makefile
 create mode 100644 drivers/power/pwrseq/core.c
 create mode 100644 drivers/power/pwrseq/pwrseq_generic.c
 create mode 100644 drivers/usb/core/pwrseq.c
 create mode 100644 include/linux/power/pwrseq.h

-- 
1.9.1
