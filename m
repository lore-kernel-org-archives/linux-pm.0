From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cpufreq: s3c64xx: remove incorrect __init annotation
Date: Fri, 16 Dec 2016 10:06:15 +0100
Message-ID: <20161216090625.2235668-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

s3c64xx_cpufreq_config_regulator is incorrectly annotated
as __init, since the caller is also not init:

WARNING: vmlinux.o(.text+0x92fe1c): Section mismatch in reference from the function s3c64xx_cpufreq_driver_init() to the function .init.text:s3c64xx_cpufreq_config_regulator()

With modern gcc versions, the function gets inline, so we don't
see the warning, this only happens with gcc-4.6 and older.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/s3c64xx-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index 176e84cc3991..0cb9040eca49 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -107,7 +107,7 @@ static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
 }
 
 #ifdef CONFIG_REGULATOR
-static void __init s3c64xx_cpufreq_config_regulator(void)
+static void s3c64xx_cpufreq_config_regulator(void)
 {
 	int count, v, i, found;
 	struct cpufreq_frequency_table *freq;
-- 
2.9.0
