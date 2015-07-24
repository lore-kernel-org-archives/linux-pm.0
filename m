From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 0/2] PM / devfreq: exynos-ppmu: Add the support of PPMUv2
Date: Fri, 24 Jul 2015 13:17:23 +0900
Message-ID: <1437711445-7386-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:56965 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbbGXER3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2015 00:17:29 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: kgene@kernel.org, k.kozlowski@samsung.com, cw00.choi@samsung.com, dan.carpenter@oracle.com, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

This patch-set add the support of PPMU ((Platform Performance Monitoring Unit)
version 2.0 which is used on Exynos5433. The exynos-ppmu.c driver supports
both PPMUv1.1 and PPMUv2. This patch-set is testd on Exynos5433-based board.

The SoC list using PPMUv1.1
- Exynos4210/4212/4412, Exynos3250, Exynos5260
The SoC list using PPMUv2
- Exynos5433, Exynos7420

Changes from v1:
(https://lkml.org/lkml/2015/7/22/834)
- Add const keyword to the instance of struct devfreq_event_ops/of_device_id
- Modify the register name of PPMU v2 ('PPMUv2_*' -> 'PPMU_V2_*')
- Reduce the unneed call function of exynos_bus_get_ops()

Chanwoo Choi (2):
  PM / devfreq: exynos-ppmu: Add the support of PPMUv2 for Exynos5433
  PM / devfreq: exynos-ppmu: Update documentation to support PPMUv2

 .../bindings/devfreq/event/exynos-ppmu.txt         |  42 ++++-
 drivers/devfreq/event/exynos-ppmu.c                | 170 ++++++++++++++++++++-
 drivers/devfreq/event/exynos-ppmu.h                |  70 +++++++++
 3 files changed, 273 insertions(+), 9 deletions(-)

-- 
1.8.5.5

