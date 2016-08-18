From: Finlye Xiao <finley.xiao@rock-chips.com>
Subject: [PATCH v2 3/4] dt-bindings: add binding document for Rockchip cpu avs
Date: Thu, 18 Aug 2016 16:52:20 +0800
Message-ID: <1471510341-63926-4-git-send-email-finley.xiao@rock-chips.com>
References: <1471510341-63926-1-git-send-email-finley.xiao@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1471510341-63926-1-git-send-email-finley.xiao@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: srinivas.kandagatla@linaro.org, maxime.ripard@free-electrons.com, heiko@sntech.de, robh+dt@kernel.org, frowand.list@gmail.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, mark.rutland@arm.com, khilman@kernel.org, nm@ti.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, sboyd@codeaurora.org
Cc: devicetree@vger.kernel.org, tim.chen@rock-chips.com, linux-pm@vger.kernel.org, lin.huang@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, tony.xie@rock-chips.com, Finley Xiao <finley.xiao@rock-chips.com>, ulysses.huang@rock-chips.com, rocky.hao@rock-chips.com, jay.xu@rock-chips.com, linux-arm-kernel@lists.infradead.org, wxt@rock-chips.com
List-Id: linux-pm@vger.kernel.org

From: Finley Xiao <finley.xiao@rock-chips.com>

This patch documents the Rockchip cpu avs device tree binding.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 .../devicetree/bindings/power/rockchip-cpu-avs.txt | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt

diff --git a/Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt b/Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt
new file mode 100644
index 0000000..705f516
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt
@@ -0,0 +1,37 @@
+Rockchip cpu avs device tree bindings
+-------------------------------------
+
+Under the same frequency, the operating voltage tends to decrease with
+increasing leakage. so it is necessary to adjust opp's voltage according
+to leakage for power.
+
+
+Required properties:
+- compatible: Should be one of the following.
+  - "rockchip,rk3399-cpu-avs" - for RK3399 SoCs.
+- leakage-volt-<name>: Named leakage-volt property. At runtime, the
+  platform can find a cpu's cluster_id according to it's cpu_id and match
+  leakage-volt-<name> property. The property is an array of 3-tuples
+  items, and each item consists of leakage and voltage like
+  <min-leakage-mA max-leakage-mA volt-uV>.
+	min-leakage: minimum leakage in mA, ranges from 0 to 254.
+	max-leakage: maximum leakage in mA, ranges from 0 to 254.
+	volt: voltage offset in mV to apply to the opp table entries.
+
+Example:
+
+	cpu_avs: cpu-avs {
+		compatible = "rockchip,rk3399-cpu-avs";
+		leakage-volt-cluster0 = <
+		/*  mA        mA         uV*/
+		    0         100        0
+		    101       200        (-25000)
+		    201       254        (-50000)
+		>;
+		leakage-volt-cluster1 = <
+		/*  mA        mA         uV*/
+		    0         100        0
+		    101       200        (-25000)
+		    201       254        (-50000)
+		>;
+	};
-- 
1.9.1
