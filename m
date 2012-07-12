From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/5] acpi : remove latency_ticks from
	acpi_processor_cx structure
Date: Thu, 12 Jul 2012 17:29:59 +0200
Message-ID: <1342107003-9811-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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

Remove the latency_ticks field as it is not used.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    2 --
 include/acpi/processor.h      |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index b894627..9ef007d 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -583,7 +583,6 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 	 */
 	cx->valid = 1;
 
-	cx->latency_ticks = cx->latency;
 	/*
 	 * On older chipsets, BM_RLD needs to be set
 	 * in order for Bus Master activity to wake the
@@ -616,7 +615,6 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 			if (!cx->address)
 				break;
 			cx->valid = 1; 
-			cx->latency_ticks = cx->latency; /* Normalize latency */
 			break;
 
 		case ACPI_STATE_C3:
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index ac3bff6..19423c3 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -59,7 +59,6 @@ struct acpi_processor_cx {
 	u8 entry_method;
 	u8 index;
 	u32 latency;
-	u32 latency_ticks;
 	u32 power;
 	u32 usage;
 	u64 time;
-- 
1.7.5.4
