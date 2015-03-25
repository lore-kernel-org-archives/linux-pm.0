From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 3/3] ARM: dts: BCM63xx: add soft-reset node
Date: Tue, 24 Mar 2015 17:17:12 -0700
Message-ID: <1427242632-7971-4-git-send-email-f.fainelli@gmail.com>
References: <1427242632-7971-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427242632-7971-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, jogo@openwrt.org, cernekee@gmail.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-pm@vger.kernel.org

Add the software reset Device Tree node allowing us to software reset a
BCM63138 device using bcm6328-soft-reset.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm63138.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/bcm63138.dtsi
index f46329c8ad75..cfd7f67fed02 100644
--- a/arch/arm/boot/dts/bcm63138.dtsi
+++ b/arch/arm/boot/dts/bcm63138.dtsi
@@ -114,6 +114,11 @@
 		#size-cells = <1>;
 		ranges = <0 0xfffe8000 0x8100>;
 
+		reset: soft-reset@b4 {
+			compatible = "brcm,bcm6328-soft-reset";
+			reg = <0xb4 0x4>;
+		};
+
 		serial0: serial@600 {
 			compatible = "brcm,bcm6345-uart";
 			reg = <0x600 0x1b>;
-- 
2.1.0
