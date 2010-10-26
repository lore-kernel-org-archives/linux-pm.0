From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/5] intel_idle: delete bogus data from
 cpuidle_state.power_usage
Date: Tue, 26 Oct 2010 17:07:31 -0400
Message-ID: <dea44c6b7df7f8bb67cb059b4c14b24288c4cd04.1288127069.git.len.brown@intel.com>
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

The mW data in this field is a total fabrication
and serves no purpose other than to mislead
those who might see it in sysfs.  Delete it.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ad0fb01..8e35c89 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -101,7 +101,6 @@ static struct cpuidle_state nehalem_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.driver_data = (void *) 0x00,
 		.flags = CPUIDLE_FLAG_TIME_VALID,
 		.exit_latency = 3,
-		.power_usage = 1000,
 		.target_residency = 6,
 		.enter = &intel_idle },
 	{ /* MWAIT C2 */
@@ -110,7 +109,6 @@ static struct cpuidle_state nehalem_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.driver_data = (void *) 0x10,
 		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 20,
-		.power_usage = 500,
 		.target_residency = 80,
 		.enter = &intel_idle },
 	{ /* MWAIT C3 */
@@ -119,7 +117,6 @@ static struct cpuidle_state nehalem_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.driver_data = (void *) 0x20,
 		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 200,
-		.power_usage = 350,
 		.target_residency = 800,
 		.enter = &intel_idle },
 };
@@ -132,7 +129,6 @@ static struct cpuidle_state atom_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.driver_data = (void *) 0x00,
 		.flags = CPUIDLE_FLAG_TIME_VALID,
 		.exit_latency = 1,
-		.power_usage = 1000,
 		.target_residency = 4,
 		.enter = &intel_idle },
 	{ /* MWAIT C2 */
@@ -141,7 +137,6 @@ static struct cpuidle_state atom_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.driver_data = (void *) 0x10,
 		.flags = CPUIDLE_FLAG_TIME_VALID,
 		.exit_latency = 20,
-		.power_usage = 500,
 		.target_residency = 80,
 		.enter = &intel_idle },
 	{ /* MWAIT C3 */ },
@@ -151,7 +146,6 @@ static struct cpuidle_state atom_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.driver_data = (void *) 0x30,
 		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 100,
-		.power_usage = 250,
 		.target_residency = 400,
 		.enter = &intel_idle },
 	{ /* MWAIT C5 */ },
@@ -161,7 +155,6 @@ static struct cpuidle_state atom_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.driver_data = (void *) 0x52,
 		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 140,
-		.power_usage = 150,
 		.target_residency = 560,
 		.enter = &intel_idle },
 };
-- 
1.7.3.2.90.gd4c43
