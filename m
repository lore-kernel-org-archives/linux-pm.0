From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 1/6] dt-bindings: marvell: Add documentation for the North Bridge PM on Armada 37xx
Date: Fri,  1 Dec 2017 12:25:03 +0100
Message-ID: <20171201112508.14121-2-gregory.clement@free-electrons.com>
References: <20171201112508.14121-1-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60957 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbdLALZ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Dec 2017 06:25:27 -0500
In-Reply-To: <20171201112508.14121-1-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Hua Jing <jinghua@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Evan Wang <xswang@marvell.com>

Extend the documentation of the Armada 37xx SoC with the the North
Bridge Power Management component.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/arm/marvell/armada-37xx.txt   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
index 51336e5fc761..7ad9830d9177 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
@@ -14,3 +14,22 @@ following property before the previous one:
 Example:
 
 compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3710";
+
+
+Power management
+----------------
+
+For power management (particularly DVFS and AVS), the North Bridge
+Power Management component is needed:
+
+Required properties:
+- compatible     : should contain "marvell,armada-3700-nb-pm", "syscon";
+- reg            : the register start and length for the North Bridge
+		    Power Management
+
+Example:
+
+nb_pm: nb_pm@14000 {
+	compatible = "marvell,armada-3700-nb-pm", "syscon";
+	reg = <0x14000 0x60>;
+}
-- 
2.15.0
