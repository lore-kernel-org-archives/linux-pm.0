From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 14/16] ARM: mvebu: Add thermal support to Armada XP device tree
Date: Wed, 20 Mar 2013 19:36:35 -0300
Message-ID: <1363818997-23137-15-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:50670 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab3CTWhr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Mar 2013 18:37:47 -0400
In-Reply-To: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This patch depends on the patch to support Armada XP
in mvebu_thermal driver:
'thermal: mvebu: Add support for Armada XP thermal sensor'

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 1443949..d85fa6a 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -151,5 +151,11 @@
 			status = "disabled";
 		};
 
+		thermal@d00182b0 {
+			compatible = "marvell,armadaxp-thermal";
+			reg = <0xd00182b0 0x4
+			       0xd00184d0 0x4>;
+			status = "okay";
+		};
 	};
 };
-- 
1.7.8.6

