From: Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 3/5] cpufreq: Loongson1: Use dev_get_platdata() to get platform_data
Date: Mon, 11 Apr 2016 19:55:57 +0800
Message-ID: <1460375759-20705-3-git-send-email-keguang.zhang@gmail.com>
References: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Kelvin Cheung <keguang.zhang@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch uses dev_get_platdata() to get the platform_data
instead of referencing it directly.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/cpufreq/loongson1-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
index 2d83744..f0d40fd 100644
--- a/drivers/cpufreq/loongson1-cpufreq.c
+++ b/drivers/cpufreq/loongson1-cpufreq.c
@@ -134,7 +134,7 @@ static int ls1x_cpufreq_remove(struct platform_device *pdev)
 
 static int ls1x_cpufreq_probe(struct platform_device *pdev)
 {
-	struct plat_ls1x_cpufreq *pdata = pdev->dev.platform_data;
+	struct plat_ls1x_cpufreq *pdata = dev_get_platdata(&pdev->dev);
 	struct clk *clk;
 	int ret;
 
-- 
1.9.1
