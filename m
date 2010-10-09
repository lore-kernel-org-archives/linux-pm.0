From: Len Brown <lenb@kernel.org>
Subject: [PATCH] intel_idle: enable Atom C6
Date: Fri, 08 Oct 2010 22:23:22 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010082221590.3961@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux Power Management List <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

ATM-C6 was commented out, pending public documentation.

https://bugzilla.kernel.org/show_bug.cgi?id=19762

Tested-by: Dennis Jansen <Dennis.Jansen@...>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 0906fc5..c37ef64 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -157,13 +157,13 @@ static struct cpuidle_state atom_cstates[MWAIT_MAX_NUM_CSTATES] = {
 	{ /* MWAIT C5 */ },
 	{ /* MWAIT C6 */
 		.name = "ATM-C6",
-		.desc = "MWAIT 0x40",
-		.driver_data = (void *) 0x40,
+		.desc = "MWAIT 0x52",
+		.driver_data = (void *) 0x52,
 		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
-		.exit_latency = 200,
+		.exit_latency = 140,
 		.power_usage = 150,
-		.target_residency = 800,
-		.enter = NULL },	/* disabled */
+		.target_residency = 560,
+		.enter = &intel_idle },
 };
 
 /**
-- 
1.7.3.1.104.gc752e
