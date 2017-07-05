From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 0/2] add UniPhier thermal support
Date: Wed,  5 Jul 2017 20:50:17 +0900
Message-ID: <1499255419-31684-1-git-send-email-hayashi.kunihiko@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, yamada.masahiro@socionext.com, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
List-Id: linux-pm@vger.kernel.org

This series adds support for CPU temperature monitor modules implemented
on UniPhier LD20 and PXs2 SoCs. This driver supports temperature monitoring
and alert function on the module.

Changes in v2:
- add nsleep after starting and stopping PVT
- replace temperature calculation with sign_extend32()

Changes in v1:
- separate dts from this patchset as another patchset
- remove 'reg' description on the dt-bindings document
- fix the order of calling initialization functions
- replace mask bits to use GENMASK
- fix calculation of temperature because of not considering a negative value
- use devm_request_threaded_irq() instead of devm_request_irq() and
  separate a thread function from the interrupt handler
- add dependency to Kconfig
- set 120C to CRITICAL_TEMP_LIMIT as maximum temperature
- shrink each line of parameters to save the number of lines
- improve some comments and copyright description

Kunihiko Hayashi (2):
  dt-bindings: thermal: add binding documentation for UniPhier thermal
    monitor
  thermal: uniphier: add UniPhier thermal driver

 .../bindings/thermal/uniphier-thermal.txt          |  64 ++++
 drivers/thermal/Kconfig                            |   8 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/uniphier_thermal.c                 | 390 +++++++++++++++++++++
 4 files changed, 463 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
 create mode 100644 drivers/thermal/uniphier_thermal.c

-- 
2.7.4
