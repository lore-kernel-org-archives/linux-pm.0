From: "pi-cheng.chen" <pi-cheng.chen@linaro.org>
Subject: [PATCH v3 0/2] cpufreq: add cpufreq driver for Mediatek MT8173 SoC
Date: Mon, 20 Apr 2015 17:27:25 +0800
Message-ID: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35421 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761AbbDTJ1f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2015 05:27:35 -0400
Received: by pdbqd1 with SMTP id qd1so202370036pdb.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2015 02:27:35 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Mike Turquette <mturquette@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: "pi-cheng.chen" <pi-cheng.chen@linaro.org>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, fan.chen@mediatek.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-mediatek@lists.infradead.org

MT8173 is a ARMv8 based SoC with 2 clusters. All CPUs in a single cluster
share the same power and clock domain. This series tries to add cpufreq support
for MT8173 SoC.

Changes in v3:
- Implement MT8173 specific standalone cpufreq driver instead of using
  cpufreq-dt driver
- Define OPP table in the driver source code until new OPP binding is ready

Changes in v2:
- Add intermediate frequency support in cpufreq-dt driver
- Use voltage scaling code of cpufreq-dt for little cluster instead of
  implementaion in notifier of mtk-cpufreq driver
- Code refinement for mtk-cpufreq driver

pi-cheng.chen (2):
  cpufreq: mediatek: Add Mediatek MT8173 cpufreq driver
  ARM64: mt8173: dts: Add MT8173 cpufreq driver support

 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |   9 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    |   6 +
 drivers/cpufreq/Kconfig.arm                 |   6 +
 drivers/cpufreq/Makefile                    |   1 +
 drivers/cpufreq/mt8173-cpufreq.c            | 509 ++++++++++++++++++++++++++++
 5 files changed, 531 insertions(+)
 create mode 100644 drivers/cpufreq/mt8173-cpufreq.c

-- 
1.9.1

