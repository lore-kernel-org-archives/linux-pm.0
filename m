From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 5/7] cpufreq/pasemi: fix possible object reference leak
Date: Mon, 1 Apr 2019 09:37:52 +0800
Message-ID: <1554082674-2049-6-git-send-email-wen.yang99@zte.com.cn>
References: <1554082674-2049-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554082674-2049-1-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The call to of_get_cpu_node returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/cpufreq/pasemi-cpufreq.c:212:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 147, but without a corresponding object release within this function.
./drivers/cpufreq/pasemi-cpufreq.c:220:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 147, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/cpufreq/pasemi-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 75dfbd2..c7710c1 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -146,6 +146,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	cpu = of_get_cpu_node(policy->cpu, NULL);
 
+	of_node_put(cpu);
 	if (!cpu)
 		goto out;
 
-- 
2.9.5
