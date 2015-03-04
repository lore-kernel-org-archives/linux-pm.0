From: "pi-cheng.chen" <pi-cheng.chen@linaro.org>
Subject: [PATCH v2 0/4] cpufreq: add cpufreq driver for Mediatek MT8173 SoC
Date: Wed,  4 Mar 2015 16:49:12 +0800
Message-ID: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33019 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759347AbbCDItc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2015 03:49:32 -0500
Received: by padet14 with SMTP id et14so35219516pad.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2015 00:49:32 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "pi-cheng.chen" <pi-cheng.chen@linaro.org>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Mike Turquette <mturquette@linaro.org>, fan.chen@mediatek.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-mediatek@lists.infradead.org

MT8173 is a ARMv8 based SoC with 2 clusters. All CPUs in a single cluster
share the same power and clock domain. This series tries to add cpufreq support
for MT8173 SoC by using DT based cpufreq driver. 

>From v1 to v2:
1. Add intermediate frequency support in cpufreq-dt driver
2. Use voltage scaling code of cpufreq-dt for little cluster instead of
   implementaion in notifier of mtk-cpufreq driver
3. Code refinement for mtk-cpufreq driver

pi-cheng.chen (4):
  cpufreq-dt: add clock domain and intermediate frequency support
  cpufreq: dt-bindings: add bindings for mtk-cpufreq driver
  cpufreq: mediatek: add Mediatek cpufreq driver
  ARM64: dts: mediatek: add cpufreq dts for MT8173 SoC

 .../devicetree/bindings/cpufreq/cpufreq-mtk.txt    |  17 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |  10 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  25 ++
 drivers/cpufreq/Kconfig.arm                        |   6 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/cpufreq-dt.c                       |  68 +++-
 drivers/cpufreq/mtk-cpufreq.c                      | 346 +++++++++++++++++++++
 include/linux/cpufreq-dt.h                         |   7 +
 8 files changed, 473 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mtk.txt
 create mode 100644 drivers/cpufreq/mtk-cpufreq.c

-- 
1.9.1

