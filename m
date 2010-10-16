From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/3] intel_idle: simplify test for leave_mm()
Date: Fri, 15 Oct 2010 21:45:43 -0400
Message-ID: <c8381cc3d8a9cc6c80f65bf60863c776651f245c.1287193487.git.len.brown@intel.com>
References: <1287193545-11655-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1287193545-11655-1-git-send-email-lenb@kernel.org>
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

A run-time test to invoke leave_mm() for the deepest
supported C-state is redundant, since the appropriate
C-states already have flags with CPUIDLE_FLAG_TLB_FLUSHED set.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index c37ef64..ad0fb01 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -186,13 +186,10 @@ static int intel_idle(struct cpuidle_device *dev, struct cpuidle_state *state)
 	local_irq_disable();
 
 	/*
-	 * If the state flag indicates that the TLB will be flushed or if this
-	 * is the deepest c-state supported, do a voluntary leave mm to avoid
-	 * costly and mostly unnecessary wakeups for flushing the user TLB's
-	 * associated with the active mm.
+	 * leave_mm() to avoid costly and often unnecessary wakeups
+	 * for flushing the user TLB's associated with the active mm.
 	 */
-	if (state->flags & CPUIDLE_FLAG_TLB_FLUSHED ||
-	    (&dev->states[dev->state_count - 1] == state))
+	if (state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
 		leave_mm(cpu);
 
 	if (!(lapic_timer_reliable_states & (1 << (cstate))))
-- 
1.7.3.1.120.g38a18
