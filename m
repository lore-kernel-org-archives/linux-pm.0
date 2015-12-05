From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: [PATCH 0/2] ARM64: dts: cpufreq: mt8173: Migrate mt8173-cpufreq to use OPPv2 bindings
Date: Sat,  5 Dec 2015 16:53:02 +0800
Message-ID: <1449305584-414-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35473 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbbLEIxN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 5 Dec 2015 03:53:13 -0500
Received: by pacej9 with SMTP id ej9so98913238pac.2
        for <linux-pm@vger.kernel.org>; Sat, 05 Dec 2015 00:53:12 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-mediatek@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

This series tries to migrate mt8173-cpufreq driver to use
operating-points-v2 bindings and add support for mt8173-cpufreq driver

Pi-Cheng Chen (2):
  cpufreq: mt8173: migrate to use operating-points-v2 bindings
  ARM64: dts: mt8173: Add CPU OPP, clock and regulator supply properties

 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 18 ++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 90 +++++++++++++++++++++++++++++
 drivers/cpufreq/mt8173-cpufreq.c            | 20 +++++--
 3 files changed, 122 insertions(+), 6 deletions(-)

-- 
1.9.1

