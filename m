From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/3] cpuidle, ACPI: remove unused CPUIDLE_FLAG_TIME_INVALID
Date: Tue, 16 Dec 2014 01:52:08 -0500
Message-ID: <2d1595ea66f8eadeb1e337354b311c4f5282e2a1.1418712225.git.len.brown@intel.com>
References: <1418712728-2193-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52]:34623 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbaLPGwS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Dec 2014 01:52:18 -0500
In-Reply-To: <1418712728-2193-1-git-send-email-lenb@kernel.org>
In-Reply-To: <c55877aa13886c660da484118a96117f939553e3.1418712225.git.len.brown@intel.com>
References: <c55877aa13886c660da484118a96117f939553e3.1418712225.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>

From: Len Brown <len.brown@intel.com>

CPUIDLE_FLAG_TIME_INVALID is no longer checked
by menu or ladder cpuidle governors, so don't
bother setting or defining it.

It was originally invented to account for the fact that
acpi_safe_halt() enables interrupts to invoke HLT.
That would allow interrupt service routines to be included
in the last_idle duration measurements made in cpuidle_enter_state(),
potentially returning a duration much larger than reality.

But menu and ladder can gracefully handle erroneously large duration
intervals without checking for CPUIDLE_FLAG_TIME_INVALID.
Further, if they don't check CPUIDLE_FLAG_TIME_INVALID, they
can also benefit from the instances when the duration interval
is not erroneously large.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c | 2 --
 include/linux/cpuidle.h       | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 4995365..87b704e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -985,8 +985,6 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 		state->flags = 0;
 		switch (cx->type) {
 			case ACPI_STATE_C1:
-			if (cx->entry_method != ACPI_CSTATE_FFH)
-				state->flags |= CPUIDLE_FLAG_TIME_INVALID;
 
 			state->enter = acpi_idle_enter_c1;
 			state->enter_dead = acpi_idle_play_dead;
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index a07e087..ab70f3b 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -53,7 +53,6 @@ struct cpuidle_state {
 };
 
 /* Idle State Flags */
-#define CPUIDLE_FLAG_TIME_INVALID	(0x01) /* is residency time measurable? */
 #define CPUIDLE_FLAG_COUPLED	(0x02) /* state applies to multiple cpus */
 #define CPUIDLE_FLAG_TIMER_STOP (0x04)  /* timer is stopped on this state */
 
@@ -89,8 +88,6 @@ DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
 /**
  * cpuidle_get_last_residency - retrieves the last state's residency time
  * @dev: the target CPU
- *
- * NOTE: this value is invalid if CPUIDLE_FLAG_TIME_INVALID is set
  */
 static inline int cpuidle_get_last_residency(struct cpuidle_device *dev)
 {
-- 
2.1.2.451.g98349e5

