From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V12 3/4] ARM64: dts: bcm2837: Define CPU thermal coefficients
Date: Fri, 31 Mar 2017 20:03:05 +0000
Message-ID: <1490990586-30898-4-git-send-email-stefan.wahren@i2se.com>
References: <1490990586-30898-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60446 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754896AbdCaUED (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2017 16:04:03 -0400
In-Reply-To: <1490990586-30898-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, kernel@martin.sperl.org
Cc: Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

This defines the bcm2837 SoC specific thermal coefficients in
order to initialize the thermal driver correctly.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2837.dtsi b/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
index 19f2fe6..2d5de6f0 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
@@ -75,6 +75,10 @@
 	interrupts = <8>;
 };
 
+&cpu_thermal {
+	coefficients = <(-538)	412000>;
+};
+
 /* enable thermal sensor with the correct compatible property set */
 &thermal {
 	compatible = "brcm,bcm2837-thermal";
-- 
1.7.9.5
