From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/5] acpi : remove usage from acpi_processor_cx
	structure
Date: Thu, 12 Jul 2012 17:30:01 +0200
Message-ID: <1342107003-9811-3-git-send-email-daniel.lezcano@linaro.org>
References: <1342107003-9811-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1342107003-9811-1-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Remove the usage field as it is not used.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    5 -----
 include/acpi/processor.h      |    1 -
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 0922143..4c06939 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -759,7 +759,6 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 	dev->last_residency = (int)idle_time;
 
 	local_irq_enable();
-	cx->usage++;
 	lapic_timer_state_broadcast(pr, cx, 0);
 
 	return index;
@@ -862,8 +861,6 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	if (cx->entry_method != ACPI_CSTATE_FFH)
 		current_thread_info()->status |= TS_POLLING;
 
-	cx->usage++;
-
 	lapic_timer_state_broadcast(pr, cx, 0);
 	cx->time += idle_time;
 	return index;
@@ -983,8 +980,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	if (cx->entry_method != ACPI_CSTATE_FFH)
 		current_thread_info()->status |= TS_POLLING;
 
-	cx->usage++;
-
 	lapic_timer_state_broadcast(pr, cx, 0);
 	cx->time += idle_time;
 	return index;
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index d2016a1..6ee4c06 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -59,7 +59,6 @@ struct acpi_processor_cx {
 	u8 entry_method;
 	u32 latency;
 	u32 power;
-	u32 usage;
 	u64 time;
 	u8 bm_sts_skip;
 	char desc[ACPI_CX_DESC_LEN];
-- 
1.7.5.4
