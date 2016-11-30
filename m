From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4] PM / OPP: Pass opp_table to dev_pm_opp_put_regulator()
Date: Wed, 30 Nov 2016 13:35:43 +0530
Message-ID: <20161130080543.GJ3288@vireshk-i7>
References: <CGME20161130040034epcas5p4344849b26e8b5c435e658e3a0179cef6@epcas5p4.samsung.com>
 <480ae6e161788d338fb1637aa2615a75588ac3c6.1480478081.git.viresh.kumar@linaro.org>
 <583E6F88.9010805@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <583E6F88.9010805@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, "# v4 . 4+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30-11-16, 15:19, Joonyoung Shim wrote:
> Hi Viresh,
> 
> On 11/30/2016 12:59 PM, Viresh Kumar wrote:
> > From: Stephen Boyd <sboyd@codeaurora.org>
> > 
> > Joonyoung Shim reported an interesting problem on his ARM octa-core
> > Odoroid-XU3 platform. During system suspend, dev_pm_opp_put_regulator()
> > was failing for a struct device for which dev_pm_opp_set_regulator() is
> > called earlier.
> > 
> > This happened because an earlier call to
> > dev_pm_opp_of_cpumask_remove_table() function (from cpufreq-dt.c file)
> > removed all the entries from opp_table->dev_list apart from the last CPU
> > device in the cpumask of CPUs sharing the OPP.
> > 
> > But both dev_pm_opp_set_regulator() and dev_pm_opp_put_regulator()
> > routines get CPU device for the first CPU in the cpumask. And so the OPP
> > core failed to find the OPP table for the struct device.
> > 
> > In order to fix that up properly, we need to revisit APIs like
> > dev_pm_opp_set_regulator() and make them talk in terms of cookies
> > provided by the OPP core. But such a solution will be hard to backport
> > to stable kernels.
> > 
> > This patch attempts to fix this problem by returning a pointer to the
> > opp_table from dev_pm_opp_set_regulator() and using that as the
> > parameter to dev_pm_opp_put_regulator(). This ensures that the
> > dev_pm_opp_put_regulator() doesn't fail to find the opp table.
> > 
> > Note that similar design problem also exists with other
> > dev_pm_opp_put_*() APIs, but those aren't used currently by anyone and
> > so we don't need to update them for now.
> > 
> > [Viresh]: Written commit log, minor improvements in the patch and tested
> > on exynos 5250.
> > 
> > Cc: # v4.4+ <stable@vger.kernel.org>
> > Reported-by: Joonyoung Shim <jy0922.shim@samsung.com>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V3->V4:
> > - Completely different approach, suggested earlier by Stephen.
> > - Can be merged safely now as both /me and Stephen agree to this one.
> > 
> > @Joonyoung: Can you please test this last patch please ?
> > 
> 
> Just system suspend/resume is working

Should I consider that as a Tested-by from you for the problem you
reported at least ?

> but i was missing below test case
> that you inform when i test for prior patches on my Odroid-XU3 board.
> 
> - offline CPU 4
> - suspend the system
> 
> With this test case, now all patches posted have the problem that is
> failed to get clk: -2.

That probably happens because your DT isn't good enough. Following DT
change may fix it for you:

diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
index bf3c6f1ec4ee..998a7dad95fc 100644
--- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
@@ -41,6 +41,7 @@
                        device_type = "cpu";
                        compatible = "arm,cortex-a7";
                        reg = <0x101>;
+                       clocks = <&clock CLK_KFC_CLK>;
                        clock-frequency = <1000000000>;
                        cci-control-port = <&cci_control0>;
                        operating-points-v2 = <&cluster_a7_opp_table>;
@@ -53,6 +54,7 @@
                        device_type = "cpu";
                        compatible = "arm,cortex-a7";
                        reg = <0x102>;
+                       clocks = <&clock CLK_KFC_CLK>;
                        clock-frequency = <1000000000>;
                        cci-control-port = <&cci_control0>;
                        operating-points-v2 = <&cluster_a7_opp_table>;
@@ -65,6 +67,7 @@
                        device_type = "cpu";
                        compatible = "arm,cortex-a7";
                        reg = <0x103>;
+                       clocks = <&clock CLK_KFC_CLK>;
                        clock-frequency = <1000000000>;
                        cci-control-port = <&cci_control0>;
                        operating-points-v2 = <&cluster_a7_opp_table>;
@@ -89,6 +92,7 @@
                cpu5: cpu@1 {
                        device_type = "cpu";
                        compatible = "arm,cortex-a15";
+                       clocks = <&clock CLK_ARM_CLK>;
                        reg = <0x1>;
                        clock-frequency = <1800000000>;
                        cci-control-port = <&cci_control1>;
@@ -101,6 +105,7 @@
                cpu6: cpu@2 {
                        device_type = "cpu";
                        compatible = "arm,cortex-a15";
+                       clocks = <&clock CLK_ARM_CLK>;
                        reg = <0x2>;
                        clock-frequency = <1800000000>;
                        cci-control-port = <&cci_control1>;
@@ -113,6 +118,7 @@
                cpu7: cpu@3 {
                        device_type = "cpu";
                        compatible = "arm,cortex-a15";
+                       clocks = <&clock CLK_ARM_CLK>;
                        reg = <0x3>;
                        clock-frequency = <1800000000>;
                        cci-control-port = <&cci_control1>;

-- 
viresh
