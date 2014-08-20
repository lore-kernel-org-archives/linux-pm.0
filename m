From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH 2/9] Documentation: devicetree: Add binding for Synopsys DDR
 controller
Date: Wed, 20 Aug 2014 13:41:48 -0700
Message-ID: <1408567315-28479-3-git-send-email-soren.brinkmann@xilinx.com>
References: <1408567315-28479-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1408567315-28479-1-git-send-email-soren.brinkmann@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michal Simek <michal.simek@xilinx.com>, Russell King <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, linux-pm@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

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
2.0.1.1.gfbfc394
