From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 10/14] cpufreq: exynox-cpufreq: pass exynos_dvfs_info to .set_freq callback
Date: Mon,  2 Feb 2015 16:58:13 -0400
Message-ID: <1422910697-5920-11-git-send-email-edubezval@gmail.com>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This change passes the exynos_dvfs_info to the .set_freq callback
to avoid using local static variables. Now, the core can use
same allocated data structure and child code can work on same
data structure.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/exynos-cpufreq.c     |  2 +-
 drivers/cpufreq/exynos-cpufreq.h     |  2 +-
 drivers/cpufreq/exynos4210-cpufreq.c | 17 ++++++++++-------
 drivers/cpufreq/exynos4x12-cpufreq.c | 19 +++++++++++--------
 drivers/cpufreq/exynos5250-cpufreq.c | 19 +++++++++++--------
 5 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 5e98c6b..a964602 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -108,7 +108,7 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 		}
 	}
 
-	exynos_info->set_freq(old_index, index);
+	exynos_info->set_freq(exynos_info, old_index, index);
 
 	/* When the new frequency is lower than current frequency */
 	if ((target_freq < old_freq) ||
diff --git a/drivers/cpufreq/exynos-cpufreq.h b/drivers/cpufreq/exynos-cpufreq.h
index 9f2062a..b59558e 100644
--- a/drivers/cpufreq/exynos-cpufreq.h
+++ b/drivers/cpufreq/exynos-cpufreq.h
@@ -48,7 +48,7 @@ struct exynos_dvfs_info {
 	struct clk	*cpu_clk;
 	unsigned int	*volt_table;
 	struct cpufreq_frequency_table	*freq_table;
-	void (*set_freq)(unsigned int, unsigned int);
+	void (*set_freq)(struct exynos_dvfs_info *, unsigned int, unsigned int);
 	bool (*need_apll_change)(unsigned int, unsigned int);
 	void __iomem	*cmu_regs;
 };
diff --git a/drivers/cpufreq/exynos4210-cpufreq.c b/drivers/cpufreq/exynos4210-cpufreq.c
index fc02a39..00889a4 100644
--- a/drivers/cpufreq/exynos4210-cpufreq.c
+++ b/drivers/cpufreq/exynos4210-cpufreq.c
@@ -55,7 +55,8 @@ static struct apll_freq apll_freq_4210[] = {
 	APLL_FREQ(200,  0, 1, 3, 1, 3, 1, 0, 0, 3, 0, 0, 200, 6, 3),
 };
 
-static void exynos4210_set_clkdiv(unsigned int div_index)
+static void exynos4210_set_clkdiv(struct exynos_dvfs_info *cpufreq,
+				  unsigned int div_index)
 {
 	unsigned int tmp;
 
@@ -80,7 +81,8 @@ static void exynos4210_set_clkdiv(unsigned int div_index)
 	} while (tmp & 0x11);
 }
 
-static void exynos4210_set_apll(unsigned int index)
+static void exynos4210_set_apll(struct exynos_dvfs_info *cpufreq,
+				unsigned int index)
 {
 	unsigned int tmp, freq = apll_freq_4210[index].freq;
 
@@ -104,15 +106,16 @@ static void exynos4210_set_apll(unsigned int index)
 	} while (tmp != (0x1 << EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT));
 }
 
-static void exynos4210_set_frequency(unsigned int old_index,
+static void exynos4210_set_frequency(struct exynos_dvfs_info *cpufreq,
+				     unsigned int old_index,
 				     unsigned int new_index)
 {
 	if (old_index > new_index) {
-		exynos4210_set_clkdiv(new_index);
-		exynos4210_set_apll(new_index);
+		exynos4210_set_clkdiv(cpufreq, new_index);
+		exynos4210_set_apll(cpufreq, new_index);
 	} else if (old_index < new_index) {
-		exynos4210_set_apll(new_index);
-		exynos4210_set_clkdiv(new_index);
+		exynos4210_set_apll(cpufreq, new_index);
+		exynos4210_set_clkdiv(cpufreq, new_index);
 	}
 }
 
diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c b/drivers/cpufreq/exynos4x12-cpufreq.c
index 7e0dd2a..d12087b 100644
--- a/drivers/cpufreq/exynos4x12-cpufreq.c
+++ b/drivers/cpufreq/exynos4x12-cpufreq.c
@@ -100,7 +100,8 @@ static struct apll_freq apll_freq_4412[] = {
 	APLL_FREQ(200,  0, 1, 3, 0, 1, 1, 1, 0, 3, 0, 0, 100, 3, 2),
 };
 
-static void exynos4x12_set_clkdiv(unsigned int div_index)
+static void exynos4x12_set_clkdiv(struct exynos_dvfs_info *cpufreq,
+				  unsigned int div_index)
 {
 	unsigned int tmp;
 
@@ -125,7 +126,8 @@ static void exynos4x12_set_clkdiv(unsigned int div_index)
 	} while (tmp != 0x0);
 }
 
-static void exynos4x12_set_apll(unsigned int index)
+static void exynos4x12_set_apll(struct exynos_dvfs_info *cpufreq,
+				unsigned int index)
 {
 	unsigned int tmp, freq = apll_freq_4x12[index].freq;
 
@@ -151,15 +153,16 @@ static void exynos4x12_set_apll(unsigned int index)
 	} while (tmp != (0x1 << EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT));
 }
 
-static void exynos4x12_set_frequency(unsigned int old_index,
-				  unsigned int new_index)
+static void exynos4x12_set_frequency(struct exynos_dvfs_info *cpufreq,
+				     unsigned int old_index,
+				     unsigned int new_index)
 {
 	if (old_index > new_index) {
-		exynos4x12_set_clkdiv(new_index);
-		exynos4x12_set_apll(new_index);
+		exynos4x12_set_clkdiv(cpufreq, new_index);
+		exynos4x12_set_apll(cpufreq, new_index);
 	} else if (old_index < new_index) {
-		exynos4x12_set_apll(new_index);
-		exynos4x12_set_clkdiv(new_index);
+		exynos4x12_set_apll(cpufreq, new_index);
+		exynos4x12_set_clkdiv(cpufreq, new_index);
 	}
 }
 
diff --git a/drivers/cpufreq/exynos5250-cpufreq.c b/drivers/cpufreq/exynos5250-cpufreq.c
index d3ce829..191a511 100644
--- a/drivers/cpufreq/exynos5250-cpufreq.c
+++ b/drivers/cpufreq/exynos5250-cpufreq.c
@@ -80,7 +80,8 @@ static struct apll_freq apll_freq_5250[] = {
 	APLL_FREQ(200,  0, 1, 7, 7, 1, 1, 1, 0, 0, 2, 0, 100, 3, 2),
 };
 
-static void set_clkdiv(unsigned int div_index)
+static void set_clkdiv(struct exynos_dvfs_info *cpufreq,
+		       unsigned int div_index)
 {
 	unsigned int tmp;
 
@@ -103,7 +104,8 @@ static void set_clkdiv(unsigned int div_index)
 		cpu_relax();
 }
 
-static void set_apll(unsigned int index)
+static void set_apll(struct exynos_dvfs_info *cpufreq,
+		     unsigned int index)
 {
 	unsigned int tmp;
 	unsigned int freq = apll_freq_5250[index].freq;
@@ -130,15 +132,16 @@ static void set_apll(unsigned int index)
 	} while (tmp != (0x1 << 16));
 }
 
-static void exynos5250_set_frequency(unsigned int old_index,
-				  unsigned int new_index)
+static void exynos5250_set_frequency(struct exynos_dvfs_info *exynos_info,
+				     unsigned int old_index,
+				     unsigned int new_index)
 {
 	if (old_index > new_index) {
-		set_clkdiv(new_index);
-		set_apll(new_index);
+		set_clkdiv(exynos_info, new_index);
+		set_apll(exynos_info, new_index);
 	} else if (old_index < new_index) {
-		set_apll(new_index);
-		set_clkdiv(new_index);
+		set_apll(exynos_info, new_index);
+		set_clkdiv(exynos_info, new_index);
 	}
 }
 
-- 
2.1.3
