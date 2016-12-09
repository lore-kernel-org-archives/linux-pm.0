From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 07/11] ARM: dtsi: add DTSI for AXP223
Date: Fri,  9 Dec 2016 12:04:15 +0100
Message-ID: <20161209110419.28981-8-quentin.schulz@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38729 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933371AbcLILEg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2016 06:04:36 -0500
In-Reply-To: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com

The AXP223 shares most of its logic with the AXP221 but it has some
differences for the VBUS driver.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---

v2:
 - adding small explanation of AXP223 variation compared to AXP221,

 arch/arm/boot/dts/axp223.dtsi | 58 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 arch/arm/boot/dts/axp223.dtsi

diff --git a/arch/arm/boot/dts/axp223.dtsi b/arch/arm/boot/dts/axp223.dtsi
new file mode 100644
index 0000000..b91b6c1
--- /dev/null
+++ b/arch/arm/boot/dts/axp223.dtsi
@@ -0,0 +1,58 @@
+/*
+ * Copyright 2016 Free Electrons
+ *
+ * Quentin Schulz <quentin.schulz@free-electrons.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/*
+ * AXP223 Integrated Power Management Chip
+ * http://www.x-powers.com/product/AXP22X.php
+ * http://dl.linux-sunxi.org/AXP/AXP223-en.pdf
+ *
+ * The AXP223 shares most of its logic with the AXP221 but it has some
+ * differences, for the VBUS driver for example.
+ */
+
+#include "axp22x.dtsi"
+
+&usb_power_supply {
+	compatible = "x-powers,axp223-usb-power-supply";
+};
-- 
2.9.3

