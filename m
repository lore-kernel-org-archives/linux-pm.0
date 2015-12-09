From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v6 04/10] ARM: STi: STiH407: Provide generic (safe) DVFS
 configuration
Date: Wed,  9 Dec 2015 15:58:11 +0000
Message-ID: <1449676697-25432-5-git-send-email-lee.jones@linaro.org>
References: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, kernel@stlinux.com, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, Lee Jones <lee.jones@linaro.org>, ajitpal.singh@st.com, maxime.coquelin@st.com
List-Id: linux-pm@vger.kernel.org

You'll notice that the voltage cell is populated with 0's.  Voltage
information is very platform specific, even depends on 'cut' and
'substrate' versions.  Thus it is left blank for a generic (safe)
implementation.  If other nodes/properties are provided by the
bootloader, the ST CPUFreq driver will over-ride these generic
values.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 81f8121..9fa1e58 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -22,15 +22,29 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+
 			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
 			cpu-release-addr = <0x94100A4>;
+
+					 /* kHz     uV   */
+			operating-points = <1500000 0
+					    1200000 0
+					    800000  0
+					    500000  0>;
 		};
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+
 			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
 			cpu-release-addr = <0x94100A4>;
+
+					 /* kHz     uV   */
+			operating-points = <1500000 0
+					    1200000 0
+					    800000  0
+					    500000  0>;
 		};
 	};
 
-- 
1.9.1
