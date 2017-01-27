From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/4] Provide real domain names for Exynos power domain driver
Date: Fri, 27 Jan 2017 11:47:48 +0100
Message-ID: <1485514072-29502-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170127104801eucas1p2ca06f8ba0b44e41c0f7dbf0c571bb9a3@eucas1p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:34153 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932626AbdA0KsE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jan 2017 05:48:04 -0500
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
"power-domain@10023C40"). This patch series adds human readable names
for all supported Exynos SoCs by the Exynos power domain driver. While
touching this, I've also fixes a few obvious issues related to power
domain driver code.

Patches are based on the following git branch:
git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux for-v4.11/drivers-soc-exynos-pmu-the-joy-never-ends

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Patch summary:

Marek Szyprowski (4):
  soc: samsung: pm_domains: Use full names in subdomains registration
    log
  soc: samsung: pm_domains: Remove unused name field
  soc: samsung: pm_domains: Remove message about failed memory
    allocation
  soc: samsung: pm_domains: Provide real name for all supported domains

 drivers/soc/samsung/pm_domains.c | 137 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 127 insertions(+), 10 deletions(-)

-- 
1.9.1

