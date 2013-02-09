From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/16] ACPI / idle: remove unused definition
Date: Fri,  8 Feb 2013 20:08:10 -0500
Message-ID: <41cdb0efc42ed3c10f56e0740db28eff086af62b.1360371180.git.len.brown@intel.com>
References: <1360372100-28482-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360372100-28482-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b1beab48f6148d50fee4a56d741cc3168fe1b995.1360371180.git.len.brown@intel.com>
References: <b1beab48f6148d50fee4a56d741cc3168fe1b995.1360371180.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

The different definitions are not used anywhere in the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index ed9a1cc..5cb5f24 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -64,10 +64,6 @@
 #define ACPI_PROCESSOR_CLASS            "processor"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_idle");
-#define PM_TIMER_TICK_NS		(1000000000ULL/PM_TIMER_FREQUENCY)
-#define C2_OVERHEAD			1	/* 1us */
-#define C3_OVERHEAD			1	/* 1us */
-#define PM_TIMER_TICKS_TO_US(p)		(((p) * 1000)/(PM_TIMER_FREQUENCY/1000))
 
 static unsigned int max_cstate __read_mostly = ACPI_PROCESSOR_MAX_POWER;
 module_param(max_cstate, uint, 0000);
-- 
1.8.1.3.535.ga923c31
