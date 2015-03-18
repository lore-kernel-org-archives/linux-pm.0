From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 1/5] ARM: EXYNOS: fix exynos_boot_secondary() return value
 on timeout
Date: Wed, 18 Mar 2015 14:09:53 +0100
Message-ID: <1426684197-22281-2-git-send-email-b.zolnierkie@samsung.com>
References: <1426684197-22281-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1426684197-22281-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Colin Cross <ccross@google.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

exynos_boot_secondary() can erroneously return 0 or -ENOSYS even
when waiting on pen_release being set to -1 timeouts.  Fix it by
adjusting ret variable value to -ETIMEDOUT when necessary.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index a825bca..48f950d 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -337,6 +337,9 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 		udelay(10);
 	}
 
+	if (pen_release != -1)
+		ret = -ETIMEDOUT;
+
 	/*
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
-- 
1.8.2.3
