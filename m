From: Feng Kan <fkan@apm.com>
Subject: [PATCH RESEND V9 2/6] Documentation: power: reset: Add documentation
 for generic SYSCON reboot driver
Date: Tue, 30 Sep 2014 16:25:04 -0700
Message-ID: <1412119508-22864-3-git-send-email-fkan@apm.com>
References: <1412119508-22864-1-git-send-email-fkan@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1412119508-22864-1-git-send-email-fkan@apm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux@roeck-us.net, dbaryshkov@gmail.com, catalin.marinas@arm.com, dwmw2@infradead.org, arnd@arndb.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patches@apm.com, linux-pm@vger.kernel.org, will.deacon@arm.com
Cc: Feng Kan <fkan@apm.com>
List-Id: linux-pm@vger.kernel.org

Add documentation for generic SYSCON reboot driver.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 .../bindings/power/reset/syscon-reboot.txt         | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot.txt

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
new file mode 100644
index 0000000..1190631
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
@@ -0,0 +1,23 @@
+Generic SYSCON mapped register reset driver
+
+This is a generic reset driver using syscon to map the reset register.
+The reset is generally performed with a write to the reset register
+defined by the register map pointed by syscon reference plus the offset
+with the mask defined in the reboot node.
+
+Required properties:
+- compatible: should contain "syscon-reboot"
+- regmap: this is phandle to the register map node
+- offset: offset in the register map for the reboot register (in bytes)
+- mask: the reset value written to the reboot register (32 bit access)
+
+Default will be little endian mode, 32 bit access only.
+
+Examples:
+
+	reboot {
+	   compatible = "syscon-reboot";
+	   regmap = <&regmapnode>;
+	   offset = <0x0>;
+	   mask = <0x1>;
+	};
-- 
1.9.1
