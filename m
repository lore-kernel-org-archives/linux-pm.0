From: Caesar Wang <wxt@rock-chips.com>
Subject: [RESEND PATCH 8/8] ARM: dts: rockchip: enable the tsadc for rk3228 evb
Date: Mon, 15 Feb 2016 15:33:33 +0800
Message-ID: <1455521613-27340-9-git-send-email-wxt@rock-chips.com>
References: <1455521613-27340-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455521613-27340-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, edubezval@gmail.com
Cc: huangtao@rock-chips.com, Michael Turquette <mturquette@baylibre.com>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, zhangqing@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

This patch enables the tsadc for rk3228 evb board.

The rk3228 evb board uses the CRU to reset the chip since it hasn't the
PMIC to connect it, and TSHUT is low active on evb board.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

 arch/arm/boot/dts/rk3228-evb.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/rk3228-evb.dts b/arch/arm/boot/dts/rk3228-evb.dts
index e3898b8..c75cc41 100644
--- a/arch/arm/boot/dts/rk3228-evb.dts
+++ b/arch/arm/boot/dts/rk3228-evb.dts
@@ -61,6 +61,13 @@
 	status = "okay";
 };
 
+&tsadc {
+	status = "okay";
+
+	rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
+	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
1.9.1
