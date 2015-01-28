From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/3] cpufreq: s3c: remove last use of resume_clocks callback
Date: Wed, 28 Jan 2015 14:16:54 +0100
Message-ID: <1422451015-390439-3-git-send-email-arnd@arndb.de>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422451015-390439-1-git-send-email-arnd@arndb.de>
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
Cc: linux-samsung-soc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Commit 32726d2d550 ("ARM: SAMSUNG: Remove legacy clock code")
already removed the callback pointer, but there was one remaining
user:

drivers/cpufreq/s3c24xx-cpufreq.c: In function 's3c_cpufreq_resume_clocks':
drivers/cpufreq/s3c24xx-cpufreq.c:149:14: error: 'struct s3c_cpufreq_info' has no member named 'resume_clocks'
  cpu_cur.info->resume_clocks();
              ^

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 32726d2d550 ("ARM: SAMSUNG: Remove legacy clock code")
Cc: stable@vger.kernel.org # v3.17+
---
 drivers/cpufreq/s3c24xx-cpufreq.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index bd340a1ca87d..733aa5153e74 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -144,11 +144,6 @@ static void s3c_cpufreq_setfvco(struct s3c_cpufreq_config *cfg)
 	(cfg->info->set_fvco)(cfg);
 }
 
-static inline void s3c_cpufreq_resume_clocks(void)
-{
-	cpu_cur.info->resume_clocks();
-}
-
 static inline void s3c_cpufreq_updateclk(struct clk *clk,
 					 unsigned int freq)
 {
@@ -417,9 +412,6 @@ static int s3c_cpufreq_resume(struct cpufreq_policy *policy)
 
 	last_target = ~0;	/* invalidate last_target setting */
 
-	/* first, find out what speed we resumed at. */
-	s3c_cpufreq_resume_clocks();
-
 	/* whilst we will be called later on, we try and re-set the
 	 * cpu frequencies as soon as possible so that we do not end
 	 * up resuming devices and then immediately having to re-set
-- 
2.1.0.rc2
