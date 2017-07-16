From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/2] soc: bcm: brcmstb: PM: Implement target_state callback
Date: Sat, 15 Jul 2017 19:36:10 -0700
Message-ID: <20170716023610.4658-3-f.fainelli@gmail.com>
References: <20170623010837.11199-1-f.fainelli@gmail.com>
 <20170716023610.4658-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170716023610.4658-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Provide a target_state callback implementation which just returns the
suspend_state_t the system is about to enter. Broadcom STB drivers can
utilize platform_suspend_target_state() to retrieve that and take
appropriate actions (e.g: full vs. partial re-initialization). Two
states are implemented: PLATFORM_STATE_WORKING and
PLATFORM_STATE_BRCMSTB_S3MEM to that end.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/pm/pm-arm.c | 22 ++++++++++++++++++++++
 include/linux/suspend.h             |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
index dcf8c8065508..750a74b3fc9d 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -104,6 +104,7 @@ struct brcmstb_pm_control {
 	u32 phy_b_standby_ctrl_offs;
 	bool needs_ddr_pad;
 	struct platform_device *pdev;
+	suspend_state_t pm_state;
 };
 
 enum bsp_initiate_command {
@@ -533,9 +534,30 @@ static int brcmstb_pm_valid(suspend_state_t state)
 	}
 }
 
+static int brcmstb_pm_begin(suspend_state_t state)
+{
+	ctrl.pm_state = state;
+
+	return 0;
+}
+
+static enum platform_target_state brcmstb_target_state(void)
+{
+	switch (ctrl.pm_state) {
+	case PM_SUSPEND_STANDBY:
+		return PLATFORM_STATE_WORKING;
+	case PM_SUSPEND_MEM:
+		return PLATFORM_STATE_BRCMSTB_S3MEM;
+	default:
+		return PLATFORM_STATE_UNKNOWN;
+	}
+}
+
 static const struct platform_suspend_ops brcmstb_pm_ops = {
+	.begin		= brcmstb_pm_begin,
 	.enter		= brcmstb_pm_enter,
 	.valid		= brcmstb_pm_valid,
+	.target_state	= brcmstb_target_state,
 };
 
 static const struct of_device_id aon_ctrl_dt_ids[] = {
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 6e6cc0778816..15d21d76e0bf 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -58,6 +58,7 @@ enum platform_target_state {
 	PLATFORM_STATE_ACPI_S3,
 	PLATFORM_STATE_ACPI_S4,
 	/* Add platform specific states here */
+	PLATFORM_STATE_BRCMSTB_S3MEM,
 };
 
 struct suspend_stats {
-- 
2.9.3
