From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v4 5/6] mfd: da9150: Use relative paths in DT bindings document
Date: Tue, 4 Aug 2015 17:16:36 +0100
Message-ID: <624a615ce54f3be058165edf499f18cc56d5bfdb.1438692348.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1438692348.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.138]:35841 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753533AbbHDQQx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 12:16:53 -0400
In-Reply-To: <cover.1438692348.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>

When referencing other DT bindings documentation, use relative
path rather than absolute.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---

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

