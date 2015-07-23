From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 0/2] PM / devfreq: exynos-ppmu: Add the support of PPMUv2
Date: Thu, 23 Jul 2015 10:57:17 +0900
Message-ID: <1437616639-7448-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: kgene@kernel.org, k.kozlowski@samsung.com, cw00.choi@samsung.com, dan.carpenter@oracle.com, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch-set add the support of PPMU ((Platform Performance Monitoring Unit)
version 2.0 which is used on Exynos5433. The exynos-ppmu.c driver supports
both PPMUv1.1 and PPMUv2. This patch-set is testd on Exynos5433-based board.

The SoC list using PPMUv1.1
- Exynos4210/4212/4412, Exynos3250, Exynos5260
The SoC list using PPMUv2
- Exynos5433, Exynos7420

Chanwoo Choi (2):
  PM / devfreq: exynos-ppmu: Add the support of PPMUv2 for Exynos5433
  PM / devfreq: exynos-ppmu: Update documentation to support PPMUv2

 .../bindings/devfreq/event/exynos-ppmu.txt         |  42 +++++-
 drivers/devfreq/event/exynos-ppmu.c                | 168 ++++++++++++++++++++-
 drivers/devfreq/event/exynos-ppmu.h                |  70 +++++++++
 3 files changed, 271 insertions(+), 9 deletions(-)

-- 
1.8.5.5
