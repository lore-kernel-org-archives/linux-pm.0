From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 6/8] acpi: processor->cpuidle: Only set cpuidle
	check_bm flag if pr->flags.bm_check is set
Date: Thu,  2 Dec 2010 17:42:26 +0100
Message-ID: <1291308148-28628-7-git-send-email-trenn__3597.03278304568$1291308372$gmane$org@suse.de>
References: <1291308148-28628-1-git-send-email-trenn@suse.de>
	<1291308148-28628-2-git-send-email-trenn@suse.de>
	<1291308148-28628-3-git-send-email-trenn@suse.de>
	<1291308148-28628-4-git-send-email-trenn@suse.de>
	<1291308148-28628-5-git-send-email-trenn@suse.de>
	<1291308148-28628-6-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1291308148-28628-6-git-send-email-trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: lenb@kernel.org
CC: linux-acpi@vger.kernel.org
CC: linux-pm@lists.linux-foundation.org
CC: Arjan van de Ven <arjan@linux.intel.com>
CC: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
---
 drivers/acpi/processor_idle.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index e74f72c..d4d2c5d 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1046,7 +1046,8 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 			snprintf(state->abbr, CPUIDLE_ABBR_LEN, "C3");
 			state->flags |= CPUIDLE_FLAG_DEEP;
 			state->flags |= CPUIDLE_FLAG_TIME_VALID;
-			state->flags |= CPUIDLE_FLAG_CHECK_BM;
+			if (pr->flags.bm_check)
+				state->flags |= CPUIDLE_FLAG_CHECK_BM;
 			state->enter = pr->flags.bm_check ?
 					acpi_idle_enter_bm :
 					acpi_idle_enter_simple;
-- 
1.6.0.2
