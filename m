From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 7/7] cpufreq: ppc_cbe: fix possible object reference leak
Date: Mon, 1 Apr 2019 09:37:54 +0800
Message-ID: <1554082674-2049-8-git-send-email-wen.yang99@zte.com.cn>
References: <1554082674-2049-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554082674-2049-1-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The call to of_get_cpu_node returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/cpufreq/ppc_cbe_cpufreq.c:89:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 76, but without a corresponding object release within this function.
./drivers/cpufreq/ppc_cbe_cpufreq.c:89:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 76, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/cpufreq/ppc_cbe_cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.c b/drivers/cpufreq/ppc_cbe_cpufreq.c
index 41a0f0b..8414c3a 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq.c
@@ -86,6 +86,7 @@ static int cbe_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (!cbe_get_cpu_pmd_regs(policy->cpu) ||
 	    !cbe_get_cpu_mic_tm_regs(policy->cpu)) {
 		pr_info("invalid CBE regs pointers for cpufreq\n");
+		of_node_put(cpu);
 		return -EINVAL;
 	}
 
-- 
2.9.5
