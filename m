From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 0/7] PM / OPP: Use - instead of @ for DT entries
Date: Thu, 20 Apr 2017 16:25:04 +0530
Message-ID: <cover.1492685450.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34124 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942878AbdDTKzT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2017 06:55:19 -0400
Received: by mail-oi0-f48.google.com with SMTP id x184so45409291oia.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2017 03:55:19 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: arm@kernel.org
Cc: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>

Compiling the DT file with W=1, DTC warns like follows:

Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
unit name, but no reg property

Fix this by replacing '@' with '-' as the OPP nodes will never have a
"reg" property.

This is rebased over arm-soc/for-next:
	commit 6f714927c553 ("ARM: SoC: Document merges")

Platform maintainers shall apply patches touching their code.

V4->V5:
- Rebased on arm-soc/for-next. Couldn't do that on linux-next/master as
  it still had the V3 patch via the PM tree (which will be dropped
  today).
- Some more OPP entries got the update as they were present only in
  next.

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
 arch/arm/boot/dts/am335x-boneblack.dts             |  2 +-
 arch/arm/boot/dts/am33xx.dtsi                      | 20 +++----
 arch/arm/boot/dts/am4372.dtsi                      | 10 ++--
 arch/arm/boot/dts/dra7.dtsi                        |  4 +-
 arch/arm/boot/dts/exynos3250.dtsi                  | 46 +++++++--------
 arch/arm/boot/dts/exynos4210.dtsi                  | 32 +++++------
 arch/arm/boot/dts/exynos4412-prime.dtsi            |  4 +-
 arch/arm/boot/dts/exynos4412.dtsi                  | 66 +++++++++++-----------
 arch/arm/boot/dts/exynos5420.dtsi                  | 40 ++++++-------
 arch/arm/boot/dts/exynos5800.dtsi                  | 56 +++++++++---------
 arch/arm/boot/dts/pxa25x.dtsi                      |  8 +--
 arch/arm/boot/dts/pxa27x.dtsi                      | 14 ++---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  4 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                   | 30 +++++-----
 arch/arm/boot/dts/uniphier-pro5.dtsi               | 32 +++++------
 arch/arm/boot/dts/uniphier-pxs2.dtsi               | 16 +++---
 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi     | 48 ++++++++--------
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 50 ++++++++--------
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   | 14 ++---
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 32 +++++------
 arch/arm64/boot/dts/zte/zx296718.dtsi              | 10 ++--
 24 files changed, 321 insertions(+), 321 deletions(-)

-- 
2.12.0.432.g71c3a4f4ba37
