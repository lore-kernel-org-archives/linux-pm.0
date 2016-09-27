From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 3/3] power_supply: max77693: Listen for cable events and
 enable charging
Date: Tue, 27 Sep 2016 10:13:44 +0200
Message-ID: <20160927081344.GC4394@kozik-lap>
References: <1474932670-11953-1-git-send-email-wolfgit@wiedmeyer.de>
 <1474932670-11953-4-git-send-email-wolfgit@wiedmeyer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:32875 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753643AbcI0INu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2016 04:13:50 -0400
Content-Disposition: inline
In-Reply-To: <1474932670-11953-4-git-send-email-wolfgit@wiedmeyer.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Cc: krzk@kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, cw00.choi@samsung.com, b.zolnierkie@samsung.com, broonie@kernel.org, lgirdwood@gmail.com, lee.jones@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 27, 2016 at 01:31:10AM +0200, Wolfgang Wiedmeyer wrote:
> This patch adds a listener for extcon cable events and enables
> charging if an USB cable is connected. It recognizes SDP and DCP cable
> types and treats them the same (same input current and fast charge
> current). The maximum input current is set before the charger is
> enabled and before the charger gets disabled, the maximum input
> current is set to zero. The listener is inspired by the listener
> implementation that was used for the AXP288 Charger driver.
> 
> The patch also adds support for the CURRENT_NOW property. It reads the
> fast charge current that gets set before the charger is enabled or
> disabled.
> 
> Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>

No. This power supply driver should not manage regulators. It is not a
regulator consumer. For that specific need, there is a charger-manager driver.

I agree that you might configure here the charger. You might even expose
some writeable properties through power supply class. However the
purpose of this driver is to expose the battery charger to user-space,
not to replace the user-space with its work.

So... NACK.

If you would like to play with charger-manager, here is my old DTS for
Trats2 (might need updates):

index 595ad4ba6977..b4361b4a9de7 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -856,6 +856,44 @@
                };
        };
 
+       charger-manager@0 {
+               compatible = "charger-manager";
+               status = "okay";
+               chg-reg-supply = <&charger_reg>;
+
+               cm-name = "battery";
+               /* Polling only for external power source */
+               cm-poll-mode = <2>;
+               cm-poll-interval = <30000>;
+
+               cm-fullbatt-vchkdrop-ms = <30000>;
+               cm-fullbatt-vchkdrop-volt = <150000>;
+               cm-fullbatt-soc = <100>;
+
+               cm-battery-stat = <0>;
+               cm-fuel-gauge = "max170xx_battery";
+
+               /* Allow charging for 5hr */
+               cm-charging-max = <18000000>;
+               /* Allow discharging for 2hr */
+               cm-discharging-max = <7200000>;
+
+               cm-num-chargers = <1>;
+               cm-chargers = "max77693-charger";
+
+               charger@0 {
+                       cm-regulator-name = "chg-reg";
+                       cable@0 {
+                               cm-cable-name = "USB";
+                               cm-cable-extcon = "max77693-muic";
+                       };
+                       cable@1 {
+                               cm-cable-name = "TA";
+                               cm-cable-extcon = "max77693-muic";
+                       };
+               };
+       };
+
        exynos-usbphy@125B0000 {
                status = "okay";
        };

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

