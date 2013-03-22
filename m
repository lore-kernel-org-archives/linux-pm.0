From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 12/14] ARM: mvebu: Add thermal support to Armada XP device tree
Date: Fri, 22 Mar 2013 19:25:12 -0300
Message-ID: <1363991114-4225-13-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33496 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423375Ab3CVW0K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 18:26:10 -0400
In-Reply-To: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This patch adds support for the thermal controller available in
all Armada XP boards. This controller has two 4-byte registers:
one to read the thermal sensor, the other for sensor initialization.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
This patch depends on the patch to support Armada XP
in mvebu_thermal driver:
'thermal: mvebu: Add support for Armada XP thermal sensor'

 arch/arm/boot/dts/armada-xp.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index ca00d83..29dfeb6 100644
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

