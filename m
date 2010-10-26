From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/5] intel_idle: add initial Sandy Bridge support
Date: Tue, 26 Oct 2010 17:07:33 -0400
Message-ID: <d13780d439d08a57c87c1a07b6e76ddde61da1aa.1288127069.git.len.brown@intel.com>
References: <1288127254-3306-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1288127254-3306-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8381cc3d8a9cc6c80f65bf60863c776651f245c.1288127069.git.len.brown@intel.com>
References: <c8381cc3d8a9cc6c80f65bf60863c776651f245c.1288127069.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 54f0fb4..84476be 100755
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -83,7 +83,7 @@ static unsigned int substates;
 static int (*choose_substate)(int);
 
 /* Reliable LAPIC Timer States, bit 1 for C1 etc.  */
-static unsigned int lapic_timer_reliable_states;
+static unsigned int lapic_timer_reliable_states = (1 << 1);	 /* Default to only C1 */
 
 static struct cpuidle_device *intel_idle_cpuidle_devices;
 static int intel_idle(struct cpuidle_device *dev, struct cpuidle_state *state);
@@ -126,6 +126,42 @@ static struct cpuidle_state nehalem_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.enter = &intel_idle },
 };
 
+static struct cpuidle_state snb_cstates[MWAIT_MAX_NUM_CSTATES] = {
+	{ /* MWAIT C0 */ },
+	{ /* MWAIT C1 */
+		.name = "SNB-C1",
+		.desc = "MWAIT 0x00",
+		.driver_data = (void *) 0x00,
+		.flags = CPUIDLE_FLAG_TIME_VALID,
+		.exit_latency = 1,
+		.target_residency = 4,
+		.enter = &intel_idle },
+	{ /* MWAIT C2 */
+		.name = "SNB-C3",
+		.desc = "MWAIT 0x10",
+		.driver_data = (void *) 0x10,
+		.flags = CPUIDLE_FLAG_TIME_VALID,
+		.exit_latency = 80,
+		.target_residency = 160,
+		.enter = &intel_idle },
+	{ /* MWAIT C3 */
+		.name = "SNB-C6",
+		.desc = "MWAIT 0x20",
+		.driver_data = (void *) 0x20,
+		.flags = CPUIDLE_FLAG_TIME_VALID,
+		.exit_latency = 104,
+		.target_residency = 208,
+		.enter = &intel_idle },
+	{ /* MWAIT C4 */
+		.name = "SNB-C7",
+		.desc = "MWAIT 0x30",
+		.driver_data = (void *) 0x30,
+		.flags = CPUIDLE_FLAG_TIME_VALID,
+		.exit_latency = 109,
+		.target_residency = 300,
+		.enter = &intel_idle },
+};
+
 static struct cpuidle_state atom_cstates[MWAIT_MAX_NUM_CSTATES] = {
 	{ /* MWAIT C0 */ },
 	{ /* MWAIT C1 */
@@ -312,6 +348,12 @@ static int intel_idle_probe(void)
 		cpuidle_state_table = atom_cstates;
 		choose_substate = choose_zero_substate;
 		break;
+
+	case 0x2A:	/* SNB */
+	case 0x2D:	/* SNB Xeon */
+		cpuidle_state_table = snb_cstates;
+		choose_substate = choose_zero_substate;
+		break;
 #ifdef FUTURE_USE
 	case 0x17:	/* 23 - Core 2 Duo */
 		lapic_timer_reliable_states = (1 << 2) | (1 << 1); /* C2, C1 */
-- 
1.7.3.2.90.gd4c43
