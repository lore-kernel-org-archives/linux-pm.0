From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v12 0/6] cpufreq: use generic cpufreq drivers for exynos platforms
Date: Mon, 24 Nov 2014 10:58:16 -0800
Message-ID: <7hioi4l92v.fsf@deeprootsystems.com>
References: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:64052 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbaKXS6T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Nov 2014 13:58:19 -0500
Received: by mail-pd0-f178.google.com with SMTP id g10so8110141pdj.9
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2014 10:58:19 -0800 (PST)
In-Reply-To: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com> (Thomas
	Abraham's message of "Fri, 21 Nov 2014 19:01:16 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, tomasz.figa@gmail.com, l.majewski@samsung.com, viresh.kumar@linaro.org, heiko@sntech.de, cw00.choi@samsung.com

Hi Thomas,

Thomas Abraham <thomas.ab@samsung.com> writes:

> Changes since v11:
> - Rebased on top of git://linuxtv.org/snawrocki/samsung.git for-v3.19-exynos-clk

Thanks for rebasing/reposting.

> This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
> drivers and enables the use of cpufreq-dt driver for these platforms. This
> series also enables cpufreq support for Exynos5420 using arm_big_little cpufreq
> driver.
>
> This series is based on the following branch.
> git://linuxtv.org/snawrocki/samsung.git for-v3.19-exynos-clk
>
> This series depends on the following patch which can be picked from
> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git samsung/dt
> e540920cf21c (ARM: dts: add CPU nodes for Exynos4 SoCs).
>
> This patch series has been tested on Exynos4210/5250/5420 based boards.
> Tomasz Figa had plans to take this in the Samsung clock tree for v3.19
> (http://www.spinics.net/lists/linux-samsung-soc/msg37933.html).
> Sylwester, could you consider to merge this in your tree?

I tested this on exynos5800-peach-pi, and noticed a few things.

First, since voltage scaling is not currently supported, the CPU cluster
regulators (vdd_arm, and vdd_kfc) have to be set at sufficietnly high
voltage to support all the OPPs, otherwise things will likely hang.  I
think you should include something like the patch below[1] in this
series as well.

Second, as with earlier versions of this series, I'm still seeing lots
of "wait_until_divider_stable: timeout in divider stablization" messages
coming out when running powertop.

Speaking of powertop, in the "frequency stats" tab, I'm not seeing 0%
time spent in all the P-states, so not sure what's going on there.  The
stats/time_in_state sysfs files under cpufreq seem to show the right
values, so I'm not sure what's going on with powertop there.

Kevin

[1]
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts
b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index e8fdda827fc9..5160735aad3b 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -195,8 +195,8 @@

                        buck2_reg: BUCK2 {
                                regulator-name = "vdd_arm";
-                               regulator-min-microvolt = <800000>;
-                               regulator-max-microvolt = <1500000>;
+                               regulator-min-microvolt = <1250000>;
+                               regulator-max-microvolt = <1250000>;
                                regulator-always-on;
                                regulator-boot-on;
                                regulator-ramp-delay = <12500>;
@@ -230,8 +230,8 @@

                        buck6_reg: BUCK6 {
                                regulator-name = "vdd_kfc";
-                               regulator-min-microvolt = <800000>;
-                               regulator-max-microvolt = <1500000>;
+                               regulator-min-microvolt = <1275000>;
+                               regulator-max-microvolt = <1275000>;
                                regulator-always-on;
                                regulator-boot-on;
                                regulator-ramp-delay = <12500>;



> Thomas Abraham (6):
>   clk: samsung: add infrastructure to register cpu clocks
>   clk: samsung: add cpu clock configuration data and instantiate cpu clock
>   ARM: dts: Exynos: add CPU OPP and regulator supply property
>   ARM: Exynos: switch to using generic cpufreq driver for Exynos4210/5250/5420
>   cpufreq: exynos: remove exynos4210/5250 specific cpufreq driver support
>   clk: samsung: remove unused clock aliases and update clock flags
>
>  arch/arm/boot/dts/exynos4210-origen.dts         |    4 +
>  arch/arm/boot/dts/exynos4210-trats.dts          |    4 +
>  arch/arm/boot/dts/exynos4210-universal_c210.dts |    4 +
>  arch/arm/boot/dts/exynos4210.dtsi               |   14 ++-
>  arch/arm/boot/dts/exynos5250-arndale.dts        |    4 +
>  arch/arm/boot/dts/exynos5250-smdk5250.dts       |    4 +
>  arch/arm/boot/dts/exynos5250-snow.dts           |    4 +
>  arch/arm/boot/dts/exynos5250.dtsi               |   25 +++-
>  arch/arm/boot/dts/exynos5420.dtsi               |   38 ++++
>  arch/arm/mach-exynos/exynos.c                   |   26 +++-
>  drivers/clk/samsung/Makefile                    |    2 +-
>  drivers/clk/samsung/clk-exynos4.c               |   63 +++++---
>  drivers/clk/samsung/clk-exynos5250.c            |   44 ++++-
>  drivers/clk/samsung/clk-exynos5420.c            |   72 +++++++-
>  drivers/cpufreq/Kconfig.arm                     |   22 ---
>  drivers/cpufreq/Makefile                        |    2 -
>  drivers/cpufreq/exynos4210-cpufreq.c            |  184 --------------------
>  drivers/cpufreq/exynos5250-cpufreq.c            |  210 -----------------------
>  include/dt-bindings/clock/exynos5250.h          |    1 +
>  include/dt-bindings/clock/exynos5420.h          |    2 +
>  20 files changed, 266 insertions(+), 463 deletions(-)
>  delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c
>  delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
