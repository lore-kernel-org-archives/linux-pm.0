From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH] intel_idle: add missing __percpu markup
Date: Sun,  8 Aug 2010 03:10:03 +0900
Message-ID: <1281204603-13406-1-git-send-email-namhyung__31172.2078397453$1281387064$gmane$org@gmail.com>
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
To: Len Brown <lenb@kernel.org>, linux-pm@lists.linux-foundation.org
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

intel_idle_cpuidle_devices is a percpu pointer but was missing __percpu markup.
Add it.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 drivers/idle/intel_idle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 54f0fb4..d86ce30 100755
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -85,7 +85,7 @@ static int (*choose_substate)(int);
 /* Reliable LAPIC Timer States, bit 1 for C1 etc.  */
 static unsigned int lapic_timer_reliable_states;
 
-static struct cpuidle_device *intel_idle_cpuidle_devices;
+static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 static int intel_idle(struct cpuidle_device *dev, struct cpuidle_state *state);
 
 static struct cpuidle_state *cpuidle_state_table;
-- 
1.7.0.4
