From: Taras Kondratiuk <taras@ti.com>
Subject: [RFC PATCH 1/2] regulator: core: Add regulator_set_voltage_min()
Date: Fri, 19 Apr 2013 14:55:53 +0300
Message-ID: <1366372554-20866-2-git-send-email-taras@ti.com>
References: <1366372554-20866-1-git-send-email-taras@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366372554-20866-1-git-send-email-taras@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, rjw@sisk.pl, viresh.kumar@linaro.org, shawn.guo@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Taras Kondratiuk <taras@ti.com>, Philip Rakity <prakity@nvidia.com>, Eric Miao <eric.y.miao@gmail.com>
List-Id: linux-pm@vger.kernel.org

Sometimes it is a need to constrain only a minimum voltage
and let system constraints to limit maximum.
Add a new function regulator_set_voltage_min() for this.

Signed-off-by: Taras Kondratiuk <taras@ti.com>
---
 include/linux/regulator/consumer.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 7bc732c..d40d909 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -380,4 +380,10 @@ static inline int regulator_is_supported_voltage_tol(struct regulator *regulator
 					      target_uV + tol_uV);
 }
 
+static inline int regulator_set_voltage_min(struct regulator *regulator,
+					    int new_uV)
+{
+	return regulator_set_voltage(regulator, new_uV, INT_MAX);
+}
+
 #endif
-- 
1.7.9.5
