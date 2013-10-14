From: Jungseok Lee <jays.lee@samsung.com>
Subject: [PATCH V2] cpufreq: exynos: Show a list of available frequencies
Date: Tue, 15 Oct 2013 08:31:13 +0900
Message-ID: <00a301cec935$786cf7e0$6946e7a0$%lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
Content-language: ko
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl, viresh.kumar@linaro.org, amit.daniel@samsung.com
Cc: linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kgene.kim@samsung.com
List-Id: linux-pm@vger.kernel.org

This patch adds freq_attr to show a list of exynos5440 scaling
available frequencies through sysfs. Common exynos driver already
supports this attribute.

Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
---
Changes since v1:
- Used a generic attribute, not a specific one.

 drivers/cpufreq/exynos5440-cpufreq.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index 06b73e8..fecc3da 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -330,6 +330,7 @@ static struct cpufreq_driver exynos_driver = {
 	.init		= exynos_cpufreq_cpu_init,
 	.exit		= cpufreq_generic_exit,
 	.name		= CPUFREQ_NAME,
+	.attr		= cpufreq_generic_attr,
 };
 
 static const struct of_device_id exynos_cpufreq_match[] = {
-- 
1.7.10.4


