From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 6/7] cpufreq: make cpufreq_generic_init transition_latency default to CPUFREQ_ETERNAL
Date: Thu, 24 Aug 2017 00:10:09 +0800
Message-ID: <1503504610-12880-7-git-send-email-aisheng.dong@nxp.com>
References: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sboyd@codeaurora.org, vireshk@kernel.org, nm@ti.com, rjw@rjwysocki.net, shawnguo@kernel.org, Anson.Huang@nxp.com, ping.bai@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>
List-Id: linux-pm@vger.kernel.org

If no valid transition_latency specified, let's make it default to
CPUFREQ_ETERNAL which is consistent with its definition.

This can save some of the same checkings like this:
        transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
-       if (!transition_latency)
-               transition_latency = CPUFREQ_ETERNAL;
        ret = cpufreq_generic_init(policy, freq_table, transition_latency);

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/cpufreq/cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 9bf97a3..da07de6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -180,6 +180,8 @@ int cpufreq_generic_init(struct cpufreq_policy *policy,
 		return ret;
 	}
 
+	if (!transition_latency)
+		transition_latency = CPUFREQ_ETERNAL;
 	policy->cpuinfo.transition_latency = transition_latency;
 
 	/*
-- 
2.7.4
