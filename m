From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/6][resend] acpi : remove 'latency_ticks' in
	acpi_processor_cx
Date: Thu, 17 Nov 2011 11:26:37 +0100
Message-ID: <1321525600-2466-4-git-send-email-daniel.lezcano__29431.6627354876$1321526100$gmane$org@linaro.org>
References: <1321525600-2466-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1321525600-2466-1-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, rob.lee@linaro.org
List-Id: linux-pm@vger.kernel.org

The latency_ticks field is used to store a value but it is never
used. It is safe to remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    2 --
 include/acpi/processor.h      |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 24fe3af..dd87355 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -595,7 +595,6 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 	 */
 	cx->valid = 1;
 
-	cx->latency_ticks = cx->latency;
 	/*
 	 * On older chipsets, BM_RLD needs to be set
 	 * in order for Bus Master activity to wake the
@@ -628,7 +627,6 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 			if (!cx->address)
 				break;
 			cx->valid = 1; 
-			cx->latency_ticks = cx->latency; /* Normalize latency */
 			break;
 
 		case ACPI_STATE_C3:
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 610f6fb..1b6e65c 100644
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
1.7.4.1
