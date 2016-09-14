From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 17/19] power: reset: st: Remove obsolete platforms from dt doc
Date: Wed, 14 Sep 2016 14:27:55 +0100
Message-ID: <1473859677-9231-18-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, devicetree@vger.kernel.org
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch removes support for STiH415/6 SoC's from the
st-restart dt binding documentation, as support for these
platforms is being removed from the kernel. It also updates
the dt example to a currently supported platform.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: <dwmw2@infradead.org>
Cc: <dbaryshkov@gmail.com>
Cc: <sre@kernel.org>
Cc: <linux-pm@vger.kernel.org>
---
 Documentation/devicetree/bindings/power/reset/st-reset.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/st-reset.txt b/Documentation/devicetree/bindings/power/reset/st-reset.txt
index 809af54..83734dc 100644
--- a/Documentation/devicetree/bindings/power/reset/st-reset.txt
+++ b/Documentation/devicetree/bindings/power/reset/st-reset.txt
@@ -1,11 +1,12 @@
 *Device-Tree bindings for ST SW reset functionality
 
 Required properties:
-- compatible: should be "st,<chip>-restart".
+- compatible: should be "stih407-restart".
 - st,syscfg: should be a phandle of the syscfg node.
 
 Example node:
 	restart {
-		compatible = "st,stih416-restart";
-		st,syscfg = <&syscfg_sbc>;
+		compatible = "st,stih407-restart";
+		st,syscfg = <&syscfg_sbc_reg>;
+		status = "okay";
 	};
-- 
1.9.1
