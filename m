From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH v3 RESEND 0/4] ARM: EXYNOS: Power domain DT support extension
Date: Tue, 13 Nov 2012 14:08:23 +0100
Message-ID: <1352812107-8777-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:30108 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab2KMNJ3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Nov 2012 08:09:29 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, kgene.kim@samsung.com, thomas.abraham@linaro.org, rjw@sisk.pl, m.szyprowski@samsung.com, t.figa@samsung.com, tomasz.figa@gmail.com

This patch series fixes two issues with existing DT support for Exynos
power domains and extends it with the ability of binding devices to domains,
basically making it possible to use power domains with DT.

Based on for-next branch of Kgene's tree.

Changes since v2:
 - Rebased to for-next of Kgene's tree.
Changes since v1:
 - Added "samsung," prefix to "power-domain" property.
 - Added power domain nodes to Exynos4 device tree sources.

Tomasz Figa (4):
  ARM: EXYNOS: pm_domain: Detect domain state on registration from DT
  ARM: EXYNOS: pm_domain: Fix power domain name initialization
  ARM: EXYNOS: pm_domain: Bind devices to power domains using DT
  ARM: dts: exynos4: Set up power domains

 .../bindings/arm/exynos/power_domain.txt           | 15 +++-
 arch/arm/boot/dts/exynos4.dtsi                     | 30 +++++++
 arch/arm/boot/dts/exynos4210.dtsi                  |  5 ++
 arch/arm/mach-exynos/pm_domains.c                  | 93 +++++++++++++++++++++-
 4 files changed, 135 insertions(+), 8 deletions(-)

-- 
1.8.0

