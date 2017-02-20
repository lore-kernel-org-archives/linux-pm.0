From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 3/6] drivers: firmware: psci: Implement shallow suspend mode
Date: Mon, 20 Feb 2017 21:33:26 +0100
Message-ID: <1487622809-25127-4-git-send-email-geert+renesas@glider.be>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Enable support for "shallow" suspend mode, also known as "Standby" or
"Power-On Suspend".

As secondary CPU cores are taken offline, "shallow" suspend mode saves
slightly more power than "s2idle", but less than "deep" suspend mode.
However, unlike "deep" suspend mode, "shallow" suspend mode can be used
regardless of the presence of support for PSCI_SYSTEM_SUSPEND, which is
an optional API in PSCI v1.0.

List the available system suspend modes:

    $ cat /sys/power/mem_sleep
    s2idle shallow [deep]

Suspend to "shallow" mode:

    $ echo shallow > /sys/power/mem_sleep
    $ echo mem > /sys/power/state

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/firmware/psci.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 493a56a4cfc4a836..13b4d50bb3577384 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -85,6 +85,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
 				PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)
 
 static u32 psci_cpu_suspend_feature;
+static bool psci_suspend_mem_supported;
 
 static inline bool psci_has_ext_power_state(void)
 {
@@ -422,13 +423,36 @@ static int psci_system_suspend(unsigned long unused)
 			      __pa_symbol(cpu_resume), 0, 0);
 }
 
+static int psci_system_suspend_valid(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		return true;
+
+	case PM_SUSPEND_MEM:
+		return psci_suspend_mem_supported;
+
+	default:
+		return false;
+	}
+}
+
 static int psci_system_suspend_enter(suspend_state_t state)
 {
-	return cpu_suspend(0, psci_system_suspend);
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		cpu_do_idle();
+		break;
+
+	case PM_SUSPEND_MEM:
+		return cpu_suspend(0, psci_system_suspend);
+	}
+
+	return 0;
 }
 
 static const struct platform_suspend_ops psci_suspend_ops = {
-	.valid          = suspend_valid_only_mem,
+	.valid          = psci_system_suspend_valid,
 	.enter          = psci_system_suspend_enter,
 };
 
@@ -442,7 +466,9 @@ static void __init psci_init_system_suspend(void)
 	ret = psci_features(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND));
 
 	if (ret != PSCI_RET_NOT_SUPPORTED)
-		suspend_set_ops(&psci_suspend_ops);
+		psci_suspend_mem_supported = true;
+
+	suspend_set_ops(&psci_suspend_ops);
 }
 
 static void __init psci_init_cpu_suspend(void)
-- 
2.7.4
