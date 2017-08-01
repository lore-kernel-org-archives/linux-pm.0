From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v6 0/2] add UniPhier thermal support
Date: Tue,  1 Aug 2017 17:04:49 +0900
Message-ID: <1501574691-8961-1-git-send-email-hayashi.kunihiko@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, yamada.masahiro@socionext.com, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
List-Id: linux-pm@vger.kernel.org

This series adds support for CPU temperature monitor modules implemented
on UniPhier LD20 and PXs2 SoCs. This driver supports temperature monitoring
and alert function on the module.

Changes since v5:
- replace of_get_property() with of_property_get_u32_array()
- get the cariblation value in DT after failure to get the value from register

Changes since v4:
- fix warnings from sparse by replacing u32 with __be32

Changes since v3:
- remove TMOD_MASK and use TMOD_WIDTH representing the bit width of TMOD

Changes since v2:
- add nsleep after starting and stopping PVT
- replace temperature calculation with sign_extend32()

Changes since v1:
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
 drivers/thermal/uniphier_thermal.c                 | 384 +++++++++++++++++++++
 4 files changed, 457 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
 create mode 100644 drivers/thermal/uniphier_thermal.c

-- 
2.7.4
