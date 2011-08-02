From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2] tools/power x86_energy_perf_policy: fix
 print of uninitialized string
Date: Tue, 02 Aug 2011 18:36:06 -0400
Message-ID: <e4c0d0e22ce5cf84b3993b5af6c2dac08d52f06b.1312324497.git.len.brown@intel.com>
References: <1312324567-4374-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1312324567-4374-1-git-send-email-lenb@kernel.org>
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

Looks like I was going to stick the brand string
in the verbose ouput, but didn't get around to it.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy.c                       |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 2618ef2..33c5c7e 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -137,7 +137,6 @@ void cmdline(int argc, char **argv)
 void validate_cpuid(void)
 {
 	unsigned int eax, ebx, ecx, edx, max_level;
-	char brand[16];
 	unsigned int fms, family, model, stepping;
 
 	eax = ebx = ecx = edx = 0;
@@ -160,8 +159,8 @@ void validate_cpuid(void)
 		model += ((fms >> 16) & 0xf) << 4;
 
 	if (verbose > 1)
-		printf("CPUID %s %d levels family:model:stepping "
-			"0x%x:%x:%x (%d:%d:%d)\n", brand, max_level,
+		printf("CPUID %d levels family:model:stepping "
+			"0x%x:%x:%x (%d:%d:%d)\n", max_level,
 			family, model, stepping, family, model, stepping);
 
 	if (!(edx & (1 << 5))) {
-- 
1.7.6.396.ge0613
