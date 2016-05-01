From: Michael Haas <haas@computerlinguist.org>
Subject: [PATCH v2 6/6] ARM: dts: sunxi: add ac-power to A20 OLinuXino Lime2 board
Date: Sun,  1 May 2016 10:57:27 +0200
Message-ID: <1462093047-7885-7-git-send-email-haas@computerlinguist.org>
References: <1462093047-7885-1-git-send-email-haas@computerlinguist.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:37974 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602AbcEAI6A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 1 May 2016 04:58:00 -0400
In-Reply-To: <1462093047-7885-1-git-send-email-haas@computerlinguist.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, maxime.ripard@free-electrons.com, wens@csie.org, lee.jones@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: degoede@redhat.com, bonbons@linux-vserver.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-sunxi@googlegroups.com, Michael Haas <haas@computerlinguist.org>

The A20-olinuxino-lime2 has an AC power input.
This patch enables support for current and voltage monitoring
via the axp20x-ac-power driver.

Signed-off-by: Michael Haas <haas@computerlinguist.org>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index d5c796c..bcd4a89 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -163,6 +163,10 @@
 				regulator-always-on;
 			};
 		};
+		ac_power_supply: ac_power_supply {
+			status = "okay";
+			compatible = "x-powers,axp202-ac-power-supply";
+		};
 	};
 };
 
-- 
2.8.0

