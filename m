From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] cpufreq: s3c24xx: rename CONFIG_CPU_FREQ_S3C24XX_DEBUGFS
Date: Sun, 14 Jul 2013 20:29:56 +0200
Message-ID: <1373826596.1370.59.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The Kconfig symbol CPU_FREQ_S3C24XX_DEBUGFS was renamed to
ARM_S3C24XX_CPUFREQ_DEBUGFS in commit f023f8dd59 ("cpufreq: s3c24xx:
move cpufreq driver to drivers/cpufreq"). But that commit missed one
instance of its macro CONFIG_CPU_FREQ_S3C24XX_DEBUGFS. Rename it too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested. Needs compile testing. But please note that setting
ARM_S3C24XX_CPUFREQ_DEBUGFS should currently lead to compile errors.

 drivers/cpufreq/s3c24xx-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 3513e74..87781eb 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -49,7 +49,7 @@ static struct clk *clk_hclk;
 static struct clk *clk_pclk;
 static struct clk *clk_arm;
 
-#ifdef CONFIG_CPU_FREQ_S3C24XX_DEBUGFS
+#ifdef CONFIG_ARM_S3C24XX_CPUFREQ_DEBUGFS
 struct s3c_cpufreq_config *s3c_cpufreq_getconfig(void)
 {
 	return &cpu_cur;
@@ -59,7 +59,7 @@ struct s3c_iotimings *s3c_cpufreq_getiotimings(void)
 {
 	return &s3c24xx_iotiming;
 }
-#endif /* CONFIG_CPU_FREQ_S3C24XX_DEBUGFS */
+#endif /* CONFIG_ARM_S3C24XX_CPUFREQ_DEBUGFS */
 
 static void s3c_cpufreq_getcur(struct s3c_cpufreq_config *cfg)
 {
-- 
1.8.1.4

