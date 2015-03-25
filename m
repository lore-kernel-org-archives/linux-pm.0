From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/3] Documentation: bindings: add BCM6328-style soft reset binding
Date: Tue, 24 Mar 2015 17:17:10 -0700
Message-ID: <1427242632-7971-2-git-send-email-f.fainelli@gmail.com>
References: <1427242632-7971-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:32796 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbbCYASP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2015 20:18:15 -0400
In-Reply-To: <1427242632-7971-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, jogo@openwrt.org, cernekee@gmail.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com

Add a binding document for the BCM6328-style software reset block found
in MIPS and ARM based Broadcom BCM63xx DSL SoCs.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/arm/bcm/bcm63138.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt b/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
index bd49987a8812..bddf76d8dda4 100644
--- a/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
@@ -7,3 +7,19 @@ following properties:
 Required root node property:
 
 compatible: should be "brcm,bcm63138"
+
+
+reboot node
+-----------
+
+Required properties
+
+- compatible: sould be "brcm,bcm6328-soft-reset"
+- reg: should be the base register addresse and length
+
+Example:
+
+reboot@b0 {
+	compatible = "brcm,bcm6328-soft-reset";
+	reg = <0xb0 0x4>;
+};
-- 
2.1.0

