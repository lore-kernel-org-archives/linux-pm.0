From: Rocky Hao <rocky.hao@rock-chips.com>
Subject: [PATCH 5/5] arm: dts: rockchip: enable tsadc module on RV1108 evaluation board
Date: Thu, 24 Aug 2017 18:32:14 +0800
Message-ID: <1503570734-8942-1-git-send-email-rocky.hao@rock-chips.com>
References: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.137]:38353 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbdHXK1P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2017 06:27:15 -0400
In-Reply-To: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: shawn.lin@rock-chips.com, cl@rock-chips.com, william.wu@rock-chips.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, xxx@rock-chips.com, jay.xu@rock-chips.com, wxt@rock-chips.com, huangtao@rock-chips.com, rocky.hao@rock-chips.com

Enable tsadc module on RV1108 evaluation board

Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
---
 arch/arm/boot/dts/rv1108-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
index 39197c3e9e0e..885f760d8ca1 100644
--- a/arch/arm/boot/dts/rv1108-evb.dts
+++ b/arch/arm/boot/dts/rv1108-evb.dts
@@ -218,6 +218,10 @@
 	status = "okay";
 };
 
+&tsadc {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
1.9.1
