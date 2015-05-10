From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 4/7] drivers/cpufreq: Convert non-modular drivers to use builtin_driver_register
Date: Sun, 10 May 2015 15:49:42 -0400
Message-ID: <1431287385-1526-5-git-send-email-paul.gortmaker@windriver.com>
References: <1431287385-1526-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:47420 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbbEJTuw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2015 15:50:52 -0400
In-Reply-To: <1431287385-1526-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

These files depend on Kconfig options all of which are a bool, so
we use the appropriate registration function, which avoids us
relying on an implicit inclusion of <module.h> which we are
doing currently.

While this currently works, we really don't want to be including
the module.h header in non-modular code, which we'd be forced
to do, pending some upcoming code relocation from init.h into
module.h.  So we fix it now by using the non-modular equivalent.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/cpufreq/exynos-cpufreq.c  | 2 +-
 drivers/cpufreq/s5pv210-cpufreq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 82d2fbb20f7e..2c2a19f035ee 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -236,4 +236,4 @@ static struct platform_driver exynos_cpufreq_platdrv = {
 	},
 	.probe = exynos_cpufreq_probe,
 };
-module_platform_driver(exynos_cpufreq_platdrv);
+builtin_platform_driver(exynos_cpufreq_platdrv);
diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index b0dac7d6ba31..9e231f52150c 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -659,4 +659,4 @@ static struct platform_driver s5pv210_cpufreq_platdrv = {
 	},
 	.probe = s5pv210_cpufreq_probe,
 };
-module_platform_driver(s5pv210_cpufreq_platdrv);
+builtin_platform_driver(s5pv210_cpufreq_platdrv);
-- 
2.2.1

