From: <grygorii.strashko@linaro.org>
Subject: [PATCH 3/3] ARM: omap-device: use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
Date: Mon, 27 Apr 2015 21:24:32 +0300
Message-ID: <1430159072-31440-4-git-send-email-grygorii.strashko@linaro.org>
References: <1430159072-31440-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1430159072-31440-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Cc: ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <Grygorii.Strashko@linaro.org>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Grygorii Strashko <Grygorii.Strashko@linaro.org>

Use recently introduced macro SET_NOIRQ_SYSTEM_SLEEP_PM_OPS to
set up PM callbacks. This also fixes missed assignment of
.poweroff_noirq() callback.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
---
 arch/arm/mach-omap2/omap_device.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 166b18f..83a0f5a 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -688,11 +688,8 @@ struct dev_pm_domain omap_device_pm_domain = {
 		SET_RUNTIME_PM_OPS(_od_runtime_suspend, _od_runtime_resume,
 				   NULL)
 		USE_PLATFORM_PM_SLEEP_OPS
-		.suspend_noirq = _od_suspend_noirq,
-		.resume_noirq = _od_resume_noirq,
-		.freeze_noirq = _od_suspend_noirq,
-		.thaw_noirq = _od_resume_noirq,
-		.restore_noirq = _od_resume_noirq,
+		SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(_od_suspend_noirq,
+					      _od_resume_noirq)
 	}
 };
 
-- 
1.9.1

