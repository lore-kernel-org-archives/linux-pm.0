From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/10] PM / OPP: Mark shared-opp for non-dt case
Date: Thu, 21 Apr 2016 14:28:57 +0530
Message-ID: <11b3f4234120113b3493e9adf5c3e1ce1700f886.1461228504.git.viresh.kumar@linaro.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461228504.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461228504.git.viresh.kumar@linaro.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

opp core allows OPPs to be explicitly marked as shared from platform
code, in case of operating-point v1 bindings.

Though we do everything fine in that case, we don't set the flag in the
opp-table to indicate that the OPPs are shared. It works fine today as
the flag isn't used anywhere else in the core, but we should be doing
the right thing by marking it set.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 491e8684bd5f..55cbf9bd8707 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -319,6 +319,9 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 				__func__, cpu);
 			continue;
 		}
+
+		/* Mark opp-table as multiple CPUs are sharing it now */
+		opp_table->shared_opp = true;
 	}
 unlock:
 	mutex_unlock(&opp_table_lock);
-- 
2.7.1.410.g6faf27b
