From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/5] intel_idle: add missing __percpu markup
Date: Tue, 28 Sep 2010 23:53:06 -0400
Message-ID: <3265eba0bed7645cacd5e2cb3614d504b5ac29e6.1285732130.git.len.brown@intel.com>
References: <1285732387-18629-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1285732387-18629-1-git-send-email-lenb@kernel.org>
In-reply-to: <4731fdcf6f7bdab3e369a3f844d4ea4d4017284d.1285732130.git.len.brown@intel.com>
References: <4731fdcf6f7bdab3e369a3f844d4ea4d4017284d.1285732130.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, Namhyung Kim <namhyung@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Namhyung Kim <namhyung@gmail.com>

intel_idle_cpuidle_devices is a percpu pointer
but was missing __percpu markup.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index a10152b..96bf380 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -83,7 +83,7 @@ static unsigned int mwait_substates;
 /* Reliable LAPIC Timer States, bit 1 for C1 etc.  */
 static unsigned int lapic_timer_reliable_states;
 
-static struct cpuidle_device *intel_idle_cpuidle_devices;
+static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 static int intel_idle(struct cpuidle_device *dev, struct cpuidle_state *state);
 
 static struct cpuidle_state *cpuidle_state_table;
-- 
1.7.3.2.g9027fa
