From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/2] ARM: EXYNOS: Use dev_err() instead of printk() for cpuidle
 driver
Date: Mon, 21 Oct 2013 10:52:15 +0900
Message-ID: <003601cece00$2affeba0$80ffc2e0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:55414 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab3JUBwX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 20 Oct 2013 21:52:23 -0400
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@sisk.pl>, linux-pm@vger.kernel.org
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Tomasz Figa' <t.figa@samsung.com>, 'Amit Daniel Kachhap' <amit.daniel@samsung.com>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 'Jingoo Han' <jg1.han@samsung.com>

Change raw printk() call to dev_err() to provide a better message
to userspace so it can properly identify the device.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
- Based against pm-cpuidle branch
- Tested on Exynos5440

 arch/arm/mach-exynos/cpuidle.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 1bde6ad..6616e0f 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -206,7 +206,7 @@ static int __init exynos_cpuidle_probe(struct platform_device *pdev)
 
 	ret = cpuidle_register_driver(&exynos4_idle_driver);
 	if (ret) {
-		printk(KERN_ERR "CPUidle failed to register driver\n");
+		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
 		return ret;
 	}
 
@@ -220,7 +220,7 @@ static int __init exynos_cpuidle_probe(struct platform_device *pdev)
 
 		ret = cpuidle_register_device(device);
 		if (ret) {
-			printk(KERN_ERR "CPUidle register device failed\n");
+			dev_err(&pdev->dev, "failed to register cpuidle device\n");
 			return ret;
 		}
 	}
-- 
1.7.10.4


