From: Len Brown <lenb@kernel.org>
Subject: [PATCH 8/8] x86 idle: deprecate mwait_idle() and
 "idle=mwait" cmdline param
Date: Sun, 29 May 2011 05:41:50 -0400
Message-ID: <5d4c47e0195b989f284907358bd5c268a44b91c7.1306662035.git.len.brown@intel.com>
References: <1306662110-29954-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1306662110-29954-1-git-send-email-lenb@kernel.org>
In-reply-to: <7467571f4480b273007517b26297c07154c73924.1306662035.git.len.brown@intel.com>
References: <7467571f4480b273007517b26297c07154c73924.1306662035.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, x86@kernel.org, stable@kernel.org.#.39.x
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

mwait_idle() is a C1-only idle loop intended to be more efficient
than HLT on SMP hardware that supports it.

But mwait_idle() has been replaced by the more general
mwait_idle_with_hints(), which handles both C1 and deeper C-states.
ACPI uses only mwait_idle_with_hints(), and never uses mwait_idle().

Deprecate mwait_idle() and the "idle=mwait" cmdline param
to simplify the x86 idle code.

After this change, kernels configured with
(!CONFIG_ACPI=n && !CONFIG_INTEL_IDLE=n) when run on hardware
that support MWAIT will simply use HLT.  If MWAIT is desired
on those systems, cpuidle and the cpuidle drivers above
can be used.

cc: x86@kernel.org
cc: stable@kernel.org # .39.x
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/feature-removal-schedule.txt |    7 +++++++
 arch/x86/kernel/process.c                  |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index f1b0eb0..13f0bb3 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -35,6 +35,13 @@ Who:	Len Brown <len.brown@intel.com>
 
 ----------------------------
 
+What:	x86 "idle=mwait" cmdline param
+When:	2012
+Why:	simplify x86 idle code
+Who:	Len Brown <len.brown@intel.com>
+
+----------------------------
+
 What:	PRISM54
 When:	2.6.34
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 84f3cda..8fb1829 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -645,6 +645,7 @@ static int __init idle_setup(char *str)
 		boot_option_idle_override = IDLE_POLL;
 	} else if (!strcmp(str, "mwait")) {
 		boot_option_idle_override = IDLE_FORCE_MWAIT;
+		WARN_ONCE(1, "\idle=mwait\" will be removed in 2012\"\n");
 	} else if (!strcmp(str, "halt")) {
 		/*
 		 * When the boot option of idle=halt is added, halt is
-- 
1.7.5.3.367.ga9930.dirty
