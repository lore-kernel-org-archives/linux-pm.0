From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/12] cpuidle: Rename X86 specific idle poll
 state[0] from C0 to POLL
Date: Wed, 12 Jan 2011 22:39:54 -0500
Message-ID: <720f1c3010db6a411358b962a2007969117840bc.1294889887.git.len.brown@intel.com>
References: <1294890002-6274-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1294890002-6274-1-git-send-email-lenb@kernel.org>
In-reply-to: <ddbd550d503c9cdefcd6674a0ef168d57d3f0917.1294889887.git.len.brown@intel.com>
References: <ddbd550d503c9cdefcd6674a0ef168d57d3f0917.1294889887.git.len.brown@intel.com>
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

From: Thomas Renninger <trenn@suse.de>

C0 means and is well know as "not idle".
All documentation out there uses this term as "running"/"not idle"
state. Also Linux userspace tools (e.g. cpufreq-aperf and turbostat)
show C0 residency which there is correct, but means something totally
else than cpuidle "POLL" state.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpuidle/cpuidle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 97df791..37e4460 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -181,7 +181,7 @@ static void poll_idle_init(struct cpuidle_device *dev)
 
 	cpuidle_set_statedata(state, NULL);
 
-	snprintf(state->name, CPUIDLE_NAME_LEN, "C0");
+	snprintf(state->name, CPUIDLE_NAME_LEN, "POLL");
 	snprintf(state->desc, CPUIDLE_DESC_LEN, "CPUIDLE CORE POLL IDLE");
 	state->exit_latency = 0;
 	state->target_residency = 0;
-- 
1.7.4.rc1.14.g7fad99
