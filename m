From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v6 5/6] mfd: da9150: Use relative paths in DT bindings document
Date: Mon, 5 Oct 2015 17:03:44 +0100
Message-ID: <9c7e79df7db805985acef8559eda03bfea914052.1444059987.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1444059987.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444059987.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

When referencing other DT bindings documentation, use relative
path rather than absolute.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Suggested-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---

Changes in v6:
 - Rebase to v4.3-rc4

Changes in v5:
 - Rebase to v4.2

Changes in v4:
 - N/A

Changes in v3:
 - Initial version.

Changes in v2:
 - N/A

 Documentation/devicetree/bindings/mfd/da9150.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/da9150.txt b/Documentation/devicetree/bindings/mfd/da9150.txt
index 970801d..fd4dca7 100644
--- a/Documentation/devicetree/bindings/mfd/da9150.txt
+++ b/Documentation/devicetree/bindings/mfd/da9150.txt
@@ -17,13 +17,13 @@ Required properties:
   the IRQs from da9150 are delivered to.
 - interrupts: IRQ line info for da9150 chip.
 - interrupt-controller: da9150 has internal IRQs (own IRQ domain).
-  (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt for
+  (See ../interrupt-controller/interrupts.txt for
    further information relating to interrupt properties)

 Sub-devices:
-- da9150-gpadc: See Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
-- da9150-charger: See Documentation/devicetree/bindings/power/da9150-charger.txt
-- da9150-fg: See Documentation/devicetree/bindings/power/da9150-fg.txt
+- da9150-gpadc: See ../iio/adc/da9150-gpadc.txt
+- da9150-charger: See ../power/da9150-charger.txt
+- da9150-fg: See ../power/da9150-fg.txt

 Example:

--
1.9.3
