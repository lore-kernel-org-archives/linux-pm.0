From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 15/30] thermal: cpu_cooling: update documentation for cpufreq_apply_cooling
Date: Wed, 17 Apr 2013 13:12:08 -0400
Message-ID: <1366218743-20841-16-git-send-email-eduardo.valentin@ti.com>
References: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: amit.kachhap@linaro.org
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Update kernel-doc comments for cpufreq_apply_cooling function.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/cpu_cooling.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 593da29..934c0b0 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -265,6 +265,12 @@ static unsigned int get_cpu_frequency(unsigned int cpu, unsigned long level)
  * @cpufreq_device: cpufreq_cooling_device pointer containing frequency
  *	clipping data.
  * @cooling_state: value of the cooling state.
+ *
+ * Function used to make sure the cpufreq layer is aware of current thermal
+ * limits. The limits are applied by updating the cpufreq policy.
+ *
+ * Return: 0 on success, an error code otherwise (-EINVAL in case wrong
+ * cooling state).
  */
 static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpufreq_device,
 				unsigned long cooling_state)
-- 
1.8.2.1.342.gfa7285d
