From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 0/5] Provide real domain names for Exynos power domain driver
Date: Mon, 30 Jan 2017 13:18:55 +0100
Message-ID: <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170130121912eucas1p1002708fc40c2d385c41ef2d7574561f9@eucas1p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:41704 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752764AbdA3MTX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jan 2017 07:19:23 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>

Hi!

For everyone working on power management and runtime power management it
is important to have a meaningful information about the state of the
power domains. Current Exynos power domain driver created names of the
domains based on the device tree node name. Those name
we incorrectly a bit more descriptive (like "mfc-power-domain@10023C40"
in exynos4.dtsi) than they should be (it should be fixed to
"power-domain@10023C40"). This patch series adds reading human readable
names from the 'label' property. While touching this, I've also fixes
a few obvious issues related to power domain driver code.

Patches are based on the Linux next-20170130 branch.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:
v3:
- moved real domains names from hardcoded string in the driver to the label
  property in the device tree (suggested by Krzysztof Kozlowski)

v2:
- sorted all domains data by domain base address in the arrays in driver

v1:
- initial version


Patch summary:

Marek Szyprowski (5):
  soc: samsung: pm_domains: Use full names in subdomains registration
    log
  soc: samsung: pm_domains: Remove unused name field
  soc: samsung: pm_domains: Remove message about failed memory
    allocation
  soc: samsung: pm_domains: Read domain name from the new label property
  arm: dts: exynos: Add labels to all existing power domains

 .../devicetree/bindings/power/pd-samsung.txt       |  4 ++++
 arch/arm/boot/dts/exynos4.dtsi                     |  7 +++++++
 arch/arm/boot/dts/exynos4210.dtsi                  |  1 +
 arch/arm/boot/dts/exynos4412.dtsi                  |  1 +
 arch/arm/boot/dts/exynos5250.dtsi                  |  3 +++
 arch/arm/boot/dts/exynos5420.dtsi                  |  5 +++++
 drivers/soc/samsung/pm_domains.c                   | 24 +++++++++++++---------
 7 files changed, 35 insertions(+), 10 deletions(-)

-- 
1.9.1

