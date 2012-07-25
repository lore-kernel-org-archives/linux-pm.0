From: Len Brown <lenb@kernel.org>
Subject: [PATCH 27/52] intel_idle: initial IVB support
Date: Tue, 24 Jul 2012 23:41:23 -0400
Message-ID: <6edab08c24f9141d69cfa4683a0a027d86ab303e.1343187617.git.len.brown@intel.com>
References: <1343187708-19532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1343187708-19532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
References: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

>From an OS point of view, IVB looks like SNB, but quicker.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index d0f59c3..a759a4c 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -169,6 +169,38 @@ static struct cpuidle_state snb_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.enter = &intel_idle },
 };
 
+static struct cpuidle_state ivb_cstates[MWAIT_MAX_NUM_CSTATES] = {
+	{ /* MWAIT C0 */ },
+	{ /* MWAIT C1 */
+		.name = "C1-IVB",
+		.desc = "MWAIT 0x00",
+		.flags = CPUIDLE_FLAG_TIME_VALID,
+		.exit_latency = 1,
+		.target_residency = 1,
+		.enter = &intel_idle },
+	{ /* MWAIT C2 */
+		.name = "C3-IVB",
+		.desc = "MWAIT 0x10",
+		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 59,
+		.target_residency = 156,
+		.enter = &intel_idle },
+	{ /* MWAIT C3 */
+		.name = "C6-IVB",
+		.desc = "MWAIT 0x20",
+		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 80,
+		.target_residency = 300,
+		.enter = &intel_idle },
+	{ /* MWAIT C4 */
+		.name = "C7-IVB",
+		.desc = "MWAIT 0x30",
+		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 87,
+		.target_residency = 300,
+		.enter = &intel_idle },
+};
+
 static struct cpuidle_state atom_cstates[MWAIT_MAX_NUM_CSTATES] = {
 	{ /* MWAIT C0 */ },
 	{ /* MWAIT C1 */
@@ -347,6 +379,10 @@ static const struct idle_cpu idle_cpu_snb = {
 	.state_table = snb_cstates,
 };
 
+static const struct idle_cpu idle_cpu_ivb = {
+	.state_table = ivb_cstates,
+};
+
 #define ICPU(model, cpu) \
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, (unsigned long)&cpu }
 
@@ -362,6 +398,7 @@ static const struct x86_cpu_id intel_idle_ids[] = {
 	ICPU(0x2f, idle_cpu_nehalem),
 	ICPU(0x2a, idle_cpu_snb),
 	ICPU(0x2d, idle_cpu_snb),
+	ICPU(0x3a, idle_cpu_ivb),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_idle_ids);
-- 
1.7.12.rc0
