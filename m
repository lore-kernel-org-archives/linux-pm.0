From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v8 5/5] ARM: dts: enable Thermal on rk3288-evb board
Date: Fri, 10 Oct 2014 18:24:15 +0800
Message-ID: <1412936655-27897-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.134]:58048 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbaJJKYW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Oct 2014 06:24:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, arnd@arndb.de
Cc: zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dmitry.torokhov@gmail.com, dbasehore@chromium.org, huangtao@rock-chips.com, cjf@rock-chips.com, zhengsq@rock-chips.com, Caesar Wang <caesar.wang@rock-chips.com>

when a thermal temperature over TSHUT.Default to via
CRU reset the entire chip on rk3288-evb Board

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3288-evb.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 2964370..d257cd8 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -101,6 +101,11 @@
 	status = "okay";
 };
 
+&tsadc {
+	tsadc-ht-reset-mode = <0>; /* reset mode 0:CRU 1:GPIO */
+	status = "okay";
+};
+
 &pinctrl {
 	buttons {
 		pwrbtn: pwrbtn {
-- 
1.9.1


