From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] cpuidle: add MAINTAINERS entry for ARM Exynos cpuidle driver
Date: Tue, 02 Dec 2014 16:41:35 +0100
Message-ID: <1616359.KRpRrFqxfV@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Since there has been quite a lot of development going on for
ARM Exynos cpuidle driver recently I would like to add separate
MAINTAINERS entry for it and add myself as the primary maintainer.

The merging process would remain (almost) unchanged with patches
going (with my Ack) through Daniel's or Kukjin's tree.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 MAINTAINERS |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: b/MAINTAINERS
===================================================================
--- a/MAINTAINERS	2014-11-27 18:02:51.988225868 +0100
+++ b/MAINTAINERS	2014-12-02 15:56:52.792997513 +0100
@@ -2701,6 +2701,16 @@ T:	git git://git.kernel.org/pub/scm/linu
 S:	Maintained
 F:	drivers/cpuidle/cpuidle-big_little.c
 
+CPUIDLE DRIVER - ARM EXYNOS
+M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
+M:	Daniel Lezcano <daniel.lezcano@linaro.org>
+M:	Kukjin Kim <kgene@kernel.org>
+L:	linux-pm@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+S:	Supported
+F:	drivers/cpuidle/cpuidle-exynos.c
+F:	arch/arm/mach-exynos/pm.c
+
 CPUIDLE DRIVERS
 M:	Rafael J. Wysocki <rjw@rjwysocki.net>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
