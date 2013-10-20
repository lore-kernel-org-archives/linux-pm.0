From: "Geyslan G. Bem" <geyslan@gmail.com>
Subject: [PATCH] cpufreq: intel_pstate: fix possible integer overflow
Date: Sun, 20 Oct 2013 00:31:16 -0300
Message-ID: <1382239876-12688-1-git-send-email-geyslan@gmail.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: kernel-br@googlegroups.com
Cc: "Geyslan G. Bem" <geyslan@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "open list:CPU FREQUENCY DRI..." <cpufreq@vger.kernel.org>, "open list:CPU FREQUENCY DRI..." <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The expression 'pstate << 8' is evaluated using 32-bit arithmetic while
'val' expects an expression of type u64.

Signed-off-by: Geyslan G. Bem <geyslan@gmail.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index badf620..43446b5 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -395,7 +395,7 @@ static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
 	trace_cpu_frequency(pstate * 100000, cpu->cpu);
 
 	cpu->pstate.current_pstate = pstate;
-	val = pstate << 8;
+	val = (u64)pstate << 8;
 	if (limits.no_turbo)
 		val |= (u64)1 << 32;
 
-- 
1.8.4

