From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 041/228] cpufreq: sh: use cpufreq_table_validate_and_show()
Date: Fri, 13 Sep 2013 18:29:47 +0530
Message-ID: <04eded57c208c65caa64ac44cea9a1eee8507f0d.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, patches@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sh-cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
index f671aa1..f1fb944 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -117,9 +117,9 @@ static int sh_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (freq_table) {
 		int result;
 
-		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
-		if (!result)
-			cpufreq_frequency_table_get_attr(freq_table, cpu);
+		result = cpufreq_table_validate_and_show(policy, freq_table);
+		if (result)
+			return result;
 	} else {
 		dev_notice(dev, "no frequency table found, falling back "
 			   "to rate rounding.\n");
-- 
1.7.12.rc2.18.g61b472e
