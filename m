From: Dawei Chien <dawei.chien@mediatek.com>
Subject: [PATCH v5 0/3] thermal: mediatek: Add cpu dynamic power cooling model.
Date: Wed, 16 Dec 2015 11:59:13 +0800
Message-ID: <1450238356-36319-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:54294 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754332AbbLPD7Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 22:59:24 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Dawei Chien <dawei.chien@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Punit Agrawal <punit.agrawal@arm.com>

Use Intelligent Power Allocation (IPA) technical to add dynamic power model
for binding CPU thermal zone. The power allocator governor allocates power
budget to control CPU temperature.

Power Allocator governor is able to keep SOC temperature within a defined
temperature range to avoid SOC overheat and keep it's performance.
mt8173-cpufreq.c need to register its' own power model with power allocator
thermal governor, so that power allocator governor can allocates suitable
power budget to control CPU temperature.

Binding document is refer to this patchset
https://lkml.org/lkml/2015/11/30/239

Change since V4:
1. Remove unnecessary error-checking for mt8173-cpufreq.c
2. Initializing variable capacitance with 0

Change since V3:
1. Remove static power model
2. Split V3's device tree in two for thermal zones and dynamic power models respectively

Change since V2:
1. Move dynamic/static power model in device tree

Change since V1:
1. Include mt8171.h and sort header file for mt8173.dtsi

Dawei Chien (3):
  thermal: mediatek: Add cpu dynamic power cooling model.
  arm64: dts: mt8173: Add thermal zone node.
  arm64: dts: mt8173: Add dynamic power node.

 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   47 ++++++++++++++++++++++++++++++
 drivers/cpufreq/mt8173-cpufreq.c         |   12 ++++++--
 2 files changed, 57 insertions(+), 2 deletions(-)

--
1.7.9.5
