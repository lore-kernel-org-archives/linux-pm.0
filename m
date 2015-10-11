From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] bcm2835: Add Raspberry Pi CPU frequency control to the device
 tree
Date: Sun, 11 Oct 2015 21:46:35 +0200
Message-ID: <1444592795-15129-1-git-send-email-lkundrak@v3.sk>
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
To: linux-rpi-kernel@lists.infradead.org
Cc: Lee Jones <lee@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Lubomir Rintel <lkundrak@v3.sk>, linux-pm@vger.kernel.org, Eric Anholt <eric@anholt.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This adds a device tree binding for Broadcom BCM2834 CPU frequency control
driven via Raspberry Pi VideoCore 4 firmware interface.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org
---
Depends on the RPi Firmware driver submitted on linux-rpi-kernel a while ago. 
Can't see it in arm-soc or linux-next yet though (?). Available in branch 
'rpi-firmware' of https://github.com/anholt/linux

 .../bindings/cpufreq/raspberrypi,bcm2835-cpufreq.txt        | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/raspberrypi,bcm2835-cpufreq.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/raspberrypi,bcm2835-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/raspberrypi,bcm2835-cpufreq.txt
new file mode 100644
index 0000000..eb126d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/raspberrypi,bcm2835-cpufreq.txt
@@ -0,0 +1,13 @@
+Raspberry Pi Broadcom BCM2835 CPU frequency control
+
+Required properties:
+
+- compatible : should be "raspberrypi,bcm2835-cpufreq"
+- firmware : the Raspberry Pi firmware node
+
+Example:
+
+cpufreq {
+        compatible = "raspberrypi,bcm2835-cpufreq";
+        firmware = <&firmware>;
+};
-- 
2.4.3
