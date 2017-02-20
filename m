From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 6/6] arm64: dts: r8a7796: Fix non-PMIC wake-up sources
Date: Mon, 20 Feb 2017 21:33:29 +0100
Message-ID: <1487622809-25127-7-git-send-email-geert+renesas@glider.be>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

The PSCI firmware on boards equipped with an R-Car M3-W SoC implements
the PSCI SYSTEM_SUSPEND operation by cutting power to the SoC.  Hence
the only possibly wake-up sources are the ones connected to the PMIC,
unless the "arm,psci-system-suspend-is-power-down" property is
specified.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 02febb434d1ca028..a11f030e97902e1c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -31,6 +31,7 @@
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
+		arm,psci-system-suspend-is-power-down;
 	};
 
 	cpus {
-- 
2.7.4
