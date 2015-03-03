From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/6] ARM64: cpuidle: Replace cpu_suspend by the common ARM/ARM64 function
Date: Tue,  3 Mar 2015 13:29:34 +0100
Message-ID: <1425385777-14766-4-git-send-email-daniel.lezcano@linaro.org>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Catalin.Marinas@arm.com, robherring2@gmail.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lina.iyer@linaro.org
List-Id: linux-pm@vger.kernel.org

Call the common ARM/ARM64 'arm_cpuidle_suspend' instead of cpu_suspend function
which is specific to ARM64.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-arm64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
index 39a2c62..0cea244 100644
--- a/drivers/cpuidle/cpuidle-arm64.c
+++ b/drivers/cpuidle/cpuidle-arm64.c
@@ -49,7 +49,7 @@ static int arm64_enter_idle_state(struct cpuidle_device *dev,
 		 * call the CPU ops suspend protocol with idle index as a
 		 * parameter.
 		 */
-		ret = cpu_suspend(idx);
+		arm_cpuidle_suspend(idx);
 
 		cpu_pm_exit();
 	}
-- 
1.9.1
