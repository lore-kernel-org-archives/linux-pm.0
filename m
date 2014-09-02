From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH v2 2/9] Documentation: devicetree: Add binding for Synopsys DDR controller
Date: Tue,  2 Sep 2014 14:19:07 -0700
Message-ID: <1409692754-13437-3-git-send-email-soren.brinkmann@xilinx.com>
References: <1409692754-13437-1-git-send-email-soren.brinkmann@xilinx.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:52021 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305AbaIBVT1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Sep 2014 17:19:27 -0400
In-Reply-To: <1409692754-13437-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 .../devicetree/bindings/memory-controllers/synopsys.txt       | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/synopsys.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
new file mode 100644
index 000000000000..f9c6454146b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
@@ -0,0 +1,11 @@
+Binding for Synopsys IntelliDDR Multi Protocol Memory Controller
+
+Required properties:
+ - compatible: Should be 'xlnx,zynq-ddrc-a05'
+ - reg: Base address and size of the controllers memory area
+
+Example:
+	memory-controller@f8006000 {
+		compatible = "xlnx,zynq-ddrc-a05";
+		reg = <0xf8006000 0x1000>;
+	};
-- 
2.1.0.1.g27b9230

