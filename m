From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 0/7] PM / OPP: Use - instead of @ for DT entries
Date: Thu, 20 Apr 2017 11:14:11 +0530
Message-ID: <cover.1492666725.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36218 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941120AbdDTFpB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2017 01:45:01 -0400
Received: by mail-oi0-f49.google.com with SMTP id r203so34883285oib.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2017 22:45:00 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: arm@kernel.org
Cc: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>

Compiling the DT file with W=1, DTC warns like follows:

Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
unit name, but no reg property

Fix this by replacing '@' with '-' as the OPP nodes will never have a
"reg" property.

This has been sent separately as a single patch earlier, and Olof
suggested to split it per-platform and get it merged via platform
specific trees. Please get these applied to your trees guys and the rest
can go via arm-soc.

V3->V4:
- split it per platform

V2->V3:
- Rebased over 4.11-rc7 and fixed a merge conflict for sun8i.

--
Viresh

Viresh Kumar (7):
  PM / OPP: Use - instead of @ for DT entries
  ARM: TI: Use - instead of @ for DT OPP entries
  ARM: exynos: Use - instead of @ for DT OPP entries
  ARM: pxa: Use - instead of @ for DT OPP entries
  ARM: sun8i: Use - instead of @ for DT OPP entries
  ARM: uniphier: Use - instead of @ for DT OPP entries
  ARM: ZTE: Use - instead of @ for DT OPP entries

 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 20 +++----
 .../devicetree/bindings/devfreq/exynos-bus.txt     | 46 +++++++--------
 Documentation/devicetree/bindings/opp/opp.txt      | 38 ++++++-------
 arch/arm/boot/dts/am4372.dtsi                      | 10 ++--
 arch/arm/boot/dts/exynos3250.dtsi                  | 46 +++++++--------
 arch/arm/boot/dts/exynos4210.dtsi                  | 32 +++++------
 arch/arm/boot/dts/exynos4412-prime.dtsi            |  4 +-
 arch/arm/boot/dts/exynos4412.dtsi                  | 66 +++++++++++-----------
 arch/arm/boot/dts/exynos5420.dtsi                  | 40 ++++++-------
 arch/arm/boot/dts/exynos5800.dtsi                  | 56 +++++++++---------
 arch/arm/boot/dts/pxa25x.dtsi                      |  8 +--
 arch/arm/boot/dts/pxa27x.dtsi                      | 14 ++---
 arch/arm/boot/dts/sun8i-a33.dtsi                   |  6 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi               | 32 +++++------
 arch/arm/boot/dts/uniphier-pxs2.dtsi               | 16 +++---
 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi     | 48 ++++++++--------
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 50 ++++++++--------
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   | 14 ++---
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 32 +++++------
 arch/arm64/boot/dts/zte/zx296718.dtsi              | 10 ++--
 20 files changed, 294 insertions(+), 294 deletions(-)

-- 
2.12.0.432.g71c3a4f4ba37
