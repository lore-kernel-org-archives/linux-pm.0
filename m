From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 3/4] ARM: mvebu: Add thermal support to Armada 370 device tree
Date: Mon, 25 Mar 2013 12:27:08 -0300
Message-ID: <1364225229-2857-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1364225229-2857-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47662 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758128Ab3CYP11 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 11:27:27 -0400
In-Reply-To: <1364225229-2857-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lior Amsalem <alior@marvell.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This patch adds support for the thermal controller available in
all Armada 370 boards. This controller has two 4-byte registers:
one to read the thermal sensor, the other for sensor initialization.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
This patch depends on the patch to support Armada 370 thermal driver:
'thermal: Add driver for Armada 370/XP SoC thermal management'

 arch/arm/boot/dts/armada-370.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 8188d13..5831994 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -153,5 +153,11 @@
 			clocks = <&coreclk 0>;
 		};
 
+		thermal@d0018300 {
+			compatible = "marvell,armada370-thermal";
+			reg = <0xd0018300 0x4
+			       0xd0018304 0x4>;
+			status = "okay";
+		};
 	};
 };
-- 
1.7.8.6

