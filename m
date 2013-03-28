From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH V5 2/4] cpufreq: exynos: Remove error return even if no soc is
 found
Date: Thu, 28 Mar 2013 13:35:20 +0530
Message-ID: <1364457923-8499-3-git-send-email-amit.daniel@samsung.com>
References: <1364457923-8499-1-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1364457923-8499-1-git-send-email-amit.daniel@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org
Cc: Kukjin Kim <kgene.kim@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, Thomas Abraham <thomas.abraham@linaro.org>, Inderpal Singh <inderpal.singh@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch helps to have single binary for exynos5440 and previous
exynos soc's. This change is needed for adding exynos5440 cpufreq driver
which does not uses exynos-cpufreq common file and adds it own driver.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/cpufreq/exynos-cpufreq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 78057a3..ee75997 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -297,7 +297,7 @@ static int __init exynos_cpufreq_init(void)
 	else if (soc_is_exynos5250())
 		ret = exynos5250_cpufreq_init(exynos_info);
 	else
-		pr_err("%s: CPU type not found\n", __func__);
+		return 0;
 
 	if (ret)
 		goto err_vdd_arm;
-- 
1.7.1
