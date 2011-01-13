From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/12] intel_idle: update Sandy Bridge core
 C-state residency targets
Date: Wed, 12 Jan 2011 22:39:51 -0500
Message-ID: <ddbd550d503c9cdefcd6674a0ef168d57d3f0917.1294889887.git.len.brown@intel.com>
References: <1294890002-6274-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1294890002-6274-1-git-send-email-lenb@kernel.org>
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
 drivers/idle/intel_idle.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index c131d58..94a6526 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -122,7 +122,7 @@ static struct cpuidle_state snb_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.driver_data = (void *) 0x00,
 		.flags = CPUIDLE_FLAG_TIME_VALID,
 		.exit_latency = 1,
-		.target_residency = 4,
+		.target_residency = 1,
 		.enter = &intel_idle },
 	{ /* MWAIT C2 */
 		.name = "SNB-C3",
@@ -130,7 +130,7 @@ static struct cpuidle_state snb_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.driver_data = (void *) 0x10,
 		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 80,
-		.target_residency = 160,
+		.target_residency = 211,
 		.enter = &intel_idle },
 	{ /* MWAIT C3 */
 		.name = "SNB-C6",
@@ -138,7 +138,7 @@ static struct cpuidle_state snb_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.driver_data = (void *) 0x20,
 		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 104,
-		.target_residency = 208,
+		.target_residency = 345,
 		.enter = &intel_idle },
 	{ /* MWAIT C4 */
 		.name = "SNB-C7",
@@ -146,7 +146,7 @@ static struct cpuidle_state snb_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.driver_data = (void *) 0x30,
 		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 109,
-		.target_residency = 300,
+		.target_residency = 345,
 		.enter = &intel_idle },
 };
 
-- 
1.7.4.rc1.14.g7fad99
