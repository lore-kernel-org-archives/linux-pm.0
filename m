From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2 v2]  cpufreq: s3c: remove last use of resume_clocks callback
Date: Wed, 18 Feb 2015 21:55:53 +0100
Message-ID: <7832522.n5E2i6JVhJ@wuerfel>
References: <7331404.XKGG8rohnR@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <7331404.XKGG8rohnR@wuerfel>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: stable@vger.kernel.org # v3.17+

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
