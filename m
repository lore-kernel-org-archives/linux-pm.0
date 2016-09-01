From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v9 0/4] power: act8945a_charger: Improvements
Date: Thu, 1 Sep 2016 17:29:57 +0800
Message-ID: <1472722201-31872-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, Wenyou Yang <wenyou.yang@microchip.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>
List-Id: linux-pm@vger.kernel.org

This patch series is to improve the implementation of act8945a-charger
driver, such as regard the act8945-charger as a sub-device, improve
the way to check the status, fix the power supply type property,
add the status change update, and add more properties: capacity level
property and max current property.

Changes in v9:
 - For "lbo-gpios", use devm_gpiod_get_optional(), instead of
   devm_gpiod_get(), for simpler and more reasonable.
 - Remove unnecessary GPIOLIB dependency.
 - For "chglev-gpios", use devm_gpiod_get_optional(), instead of
   devm_gpiod_get(), for simper and more reasonable.
 - Not include seven patches which have been queued or applied.

Changes in v8:
 - As the act8945a_charger is regarded as a sub-device, all
   properties can be achieved from its own device node,
   use devm_gpiod_get() properly as well to get "lbo-gpios".
 - Add missing return -EPROBE_DEFER  for "lbo-gpios".
 - As the act8945a_charger is regarded as a sub-device, all
   properties can be achieved from its own device node,
   use devm_gpiod_get() properly as well to get "chglev-gpios".
 - Add missing return -EPROBE_DEFER  for "chglev-gpios".
 - Add 4 new patches: 1/11, 2/11, 9/11, and 11/11.

Changes in v7:
 - For "lbo-gpios", use gpiod_get() to fix devm_gpiod_get() wrong use
   with parent device as *dev argument.
 - Add the handle -EPROBE_DEFER returned from gpiod_get "lbo-gpios".
 - Use dev_info() to print log if the lbo irq request failed.
 - Remove unneeded semicolon.
 - Add depends on GPIOLIB for use gpiod.
 - For "chglev-gpios", use gpiod_get() to fix devm_gpiod_get() wrong use
   with parent device as *dev argument.
 - Add the handle -EPROBE_DEFER returned from gpiod_get "chglev-gpio".
 - Remove unneeded semicolon.

Changes in v6:
 - For "lbo-gpios", use gpiod API instead of old gpio API to handle.
 - For "chglev-gpios", use gpiod API instead of old gpio API to handle.

Changes in v4:
 - Change devname of devm_request_irq() from "lbo-detect" to
   "act8945a, lbo-detect".
 - Fix wrong gpio assignment for chglev_pin.

Wenyou Yang (4):
  power: act8945a_charger: Add capacity level property
  power: act8945a_charger: Add max current property
  doc: bindings: mfd: act8945a: Update the example
  ARM: at91/dt: sama5d2_xplained: Add act8945a-charger node.

 Documentation/devicetree/bindings/mfd/act8945a.txt |  22 ++-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  23 ++-
 drivers/power/supply/act8945a_charger.c            | 166 +++++++++++++++++++--
 3 files changed, 187 insertions(+), 24 deletions(-)

-- 
2.7.4
