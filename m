From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v6 0/7] power: act8945a_charger: Improvements
Date: Fri, 19 Aug 2016 09:13:28 +0800
Message-ID: <1471569215-6046-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch series is to improve the implementation of act8945a-charger
driver, such as improve the way to check the status, fix the power
supply type property, add the status change update, and add more
properties: capacity level property and max current property.

Changes in v6:
 - Add .remove callback function.
 - Fix the 'dev' argument of devm_request_irq() to pdev->dev.parent.
 - For 'lbo-gpios', use gpiod API instead of old gpio API to handle.
 - For 'chglev-gpios', use gpiod API instead of old gpio API to handle.

Changes in v5:
 - Add Acked-by tag.

Changes in v4:
 - Use "interrupts" property, instead of "active-semi,irq-gpios"
   for irq.
 - Change devname of devm_request_irq() from "lbo-detect" to
   "act8945a, lbo-detect".
 - Fix wrong gpio assignment for chglev_pin.
 - Update the doc/binding for using "interrupts" property.

Changes in v3:
 - Remove unneeded semicolon to fix semicolon.cocci warning.

Changes in v2:
 - Add missing ret declaration.

Wenyou Yang (7):
  power: act8945a_charger: Remove "battery_temperature"
  power: act8945a_charger: Improve
  power: act8945a_charger: Add status change update support
  power: act8945a_charger: Fix the power supply type
  power: act8945a_charger: Add capacity level property
  power: act8945a_charger: Add max current property
  doc: bindings: act8945a-charger: Update properties

 .../bindings/power/supply/act8945a-charger.txt     |  16 +-
 drivers/power/supply/act8945a_charger.c            | 390 ++++++++++++++++++---
 2 files changed, 358 insertions(+), 48 deletions(-)

-- 
2.7.4
