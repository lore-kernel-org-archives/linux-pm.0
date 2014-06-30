From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH 4/4] ARM: zynq: dt: Use properly rounded frequencies in OPPs
Date: Mon, 30 Jun 2014 09:56:36 -0700
Message-ID: <1404147396-8041-5-git-send-email-soren.brinkmann@xilinx.com>
References: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Soren Brinkmann <soren.brinkmann@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Due to the clk_find_nearest_rate() API, OPPs can be specified
using proper rounding, now.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

---
 arch/arm/boot/dts/zynq-7000.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 760bbc463c5b..b8e39ed5b132 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -29,8 +29,8 @@
 			operating-points = <
 				/* kHz    uV */
 				666667  1000000
-				333334  1000000
-				222223  1000000
+				333333  1000000
+				222222  1000000
 			>;
 		};
 
-- 
2.0.1.1.gfbfc394
