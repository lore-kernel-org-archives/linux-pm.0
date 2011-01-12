From: Len Brown <lenb@kernel.org>
Subject: [PATCH] SH,
	cpuidle: delete use of NOP CPUIDLE_FLAGS_SHALLOW
Date: Wed, 12 Jan 2011 03:00:46 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101120258550.19140__35021.2738303982$1294819331$gmane$org@x980>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
	<1294396190-23031-6-git-send-email-trenn@suse.de>
	<alpine.LFD.2.02.1101120159400.19140@x980>
	<alpine.LFD.2.02.1101120229060.19140@x980>
	<alpine.LFD.2.02.1101120235390.19140@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <alpine.LFD.2.02.1101120235390.19140@x980>
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

set but not checked.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/sh/kernel/cpu/shmobile/cpuidle.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
index 83972aa..c19e2a9 100644
--- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
+++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
@@ -81,7 +81,6 @@ void sh_mobile_setup_cpuidle(void)
 	state->target_residency = 1 * 2;
 	state->power_usage = 3;
 	state->flags = 0;
-	state->flags |= CPUIDLE_FLAG_SHALLOW;
 	state->flags |= CPUIDLE_FLAG_TIME_VALID;
 	state->enter = cpuidle_sleep_enter;
 
-- 
1.7.4.rc1.7.g2cf08
