From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: processor_idle: delete use of NOP
	CPUIDLE_FLAGs
Date: Wed, 12 Jan 2011 02:30:31 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101120229060.19140__24451.4064550915$1294817493$gmane$org@x980>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
	<1294396190-23031-6-git-send-email-trenn@suse.de>
	<alpine.LFD.2.02.1101120159400.19140@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <alpine.LFD.2.02.1101120159400.19140@x980>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, arjan@linux.intel.com, j-pihet@ti.com
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

CPUIDLE_FLAG_SHALLOW
CPUIDLE_FLAG_BALANCED
CPUIDLE_FLAG_DEEP
CPUIDLE_FLAG_CHECK_BM

were set by acpi_processor_setup_cpuidle(),
but never used by cpuidle or by acpi_idle.
So stop setting them.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index eefd4aa..70599d2 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1023,7 +1023,6 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 		state->flags = 0;
 		switch (cx->type) {
 			case ACPI_STATE_C1:
-			state->flags |= CPUIDLE_FLAG_SHALLOW;
 			if (cx->entry_method == ACPI_CSTATE_FFH)
 				state->flags |= CPUIDLE_FLAG_TIME_VALID;
 
@@ -1032,16 +1031,13 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 			break;
 
 			case ACPI_STATE_C2:
-			state->flags |= CPUIDLE_FLAG_BALANCED;
 			state->flags |= CPUIDLE_FLAG_TIME_VALID;
 			state->enter = acpi_idle_enter_simple;
 			dev->safe_state = state;
 			break;
 
 			case ACPI_STATE_C3:
-			state->flags |= CPUIDLE_FLAG_DEEP;
 			state->flags |= CPUIDLE_FLAG_TIME_VALID;
-			state->flags |= CPUIDLE_FLAG_CHECK_BM;
 			state->enter = pr->flags.bm_check ?
 					acpi_idle_enter_bm :
 					acpi_idle_enter_simple;
-- 
1.7.4.rc1.7.g2cf08
