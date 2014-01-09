From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] ARM: SA1100: Create dummy clk_get_rate() to avoid build failures
Date: Thu,  9 Jan 2014 20:38:42 +0530
Message-ID: <aaadbfa341a881c8250f2d23bc77062228d2e70b.1389279793.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, olof@lixom.net, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

There are some parts of common kernel which would be using routines like
clk_get_rate() on some platforms. Currently these wouldn't be called for SA1100
boards but we need these routines for successful builds of these boards.

So, this patch creates a dummy clk_get_rate() routine which is being used by
cpufreq core. More dummy routines might be added later if there is a need for
that.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd.bergmann@linaro.org>
Reported-by: <Olof Johansson> olof@lixom.net
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi Rafael,

This is the only new part here. 2/2 is still the same. Its compiled for Assabet
board. And the issue reported by Olof is resolved with it.

 arch/arm/mach-sa1100/clock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
index 172ebd0..9fa6a99 100644
--- a/arch/arm/mach-sa1100/clock.c
+++ b/arch/arm/mach-sa1100/clock.c
@@ -33,6 +33,13 @@ struct clk clk_##_name = {				\
 
 static DEFINE_SPINLOCK(clocks_lock);
 
+/* Dummy clk routine to build generic kernel parts that may be using them */
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
 static void clk_gpio27_enable(struct clk *clk)
 {
 	/*
-- 
1.7.12.rc2.18.g61b472e

