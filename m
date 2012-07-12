From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 5/5] acpi : remove time from acpi_processor_cx
	structure
Date: Thu, 12 Jul 2012 17:30:03 +0200
Message-ID: <1342107003-9811-5-git-send-email-daniel.lezcano@linaro.org>
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

Remove the time field as it is not used.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    2 --
 include/acpi/processor.h      |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 9845739..16c6ebb 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -860,7 +860,6 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 		current_thread_info()->status |= TS_POLLING;
 
 	lapic_timer_state_broadcast(pr, cx, 0);
-	cx->time += idle_time;
 	return index;
 }
 
@@ -979,7 +978,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 		current_thread_info()->status |= TS_POLLING;
 
 	lapic_timer_state_broadcast(pr, cx, 0);
-	cx->time += idle_time;
 	return index;
 }
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 3a675f4..abc89b0 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -58,7 +58,6 @@ struct acpi_processor_cx {
 	u32 address;
 	u8 entry_method;
 	u32 latency;
-	u64 time;
 	u8 bm_sts_skip;
 	char desc[ACPI_CX_DESC_LEN];
 };
-- 
1.7.5.4
