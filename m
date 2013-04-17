From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 23/30] thermal: cpu_cooling: update kernel-doc comment for cpufreq_cooling_unregister
Date: Wed, 17 Apr 2013 13:12:16 -0400
Message-ID: <1366218743-20841-24-git-send-email-eduardo.valentin@ti.com>
References: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: amit.kachhap@linaro.org
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Update comments for this exported function.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/cpu_cooling.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 560692b..b55cfc2 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -493,6 +493,8 @@ EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
 /**
  * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
  * @cdev: thermal cooling device pointer.
+ *
+ * This interface function unregisters the "thermal-cpufreq-%x" cooling device.
  */
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
-- 
1.8.2.1.342.gfa7285d
