From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/5] ARM: dts: Add Integrator/CP cpus node and operating points
Date: Wed, 19 Oct 2016 11:59:12 +0200
Message-ID: <1476871154-32243-4-git-send-email-linus.walleij@linaro.org>
References: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This adds the cpus node to the Integrator/CP device tree so
that we have a proper placeholder to put in the DT-defined
operating points for the generic DT/OPP cpufreq driver,
along with two working operating points.

I have only put in 48 and 50 MHz because going to e.g. 36
MHz hangs the system when CLCD graphics are active.
Presumably the memory bus gets to slow to feed the display
and the systems hangs for this reason. The ideal solution
would be for the display controller to put constraints on
the memory bus frequency, but that need to be a separate
longer-term project.

We define a CPU node since this is required for cpufreq-dt,
however we do not define any compatible string for the CPU
since this architecture has pluggable CPU modules and we
do not know which one will be used. If necessary, the CPU
compatible can be filled in by the boot loader, but for
just cpufreq-dt it is not required.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorcp.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
index 1b5e4b006b72..97f38b57a702 100644
--- a/arch/arm/boot/dts/integratorcp.dts
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -13,6 +13,32 @@
 		bootargs = "root=/dev/ram0 console=ttyAMA0,38400n8 earlyprintk";
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			/*
+			 * Since the board has pluggable CPU modules, we
+			 * cannot define a proper compatible here. Let the
+			 * boot loader fill in the apropriate compatible
+			 * string if necessary.
+			 */
+			/* compatible = "arm,arm920t"; */
+			reg = <0>;
+			/*
+			 * TBD comment.
+			 */
+					 /* kHz     uV   */
+			operating-points = <50000  0
+					    48000  0>;
+			clocks = <&cmcore>;
+			clock-names = "cpu";
+			clock-latency = <1000000>; /* 1 ms */
+		};
+	};
+
 	/*
 	 * The Integrator/CP overall clocking architecture can be found in
 	 * ARM DUI 0184B page 7-28 "Integrator/CP922T system clocks" which
-- 
2.7.4
