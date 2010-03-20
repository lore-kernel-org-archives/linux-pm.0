From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Regression,
	post-2.6.34-rc1][PATCH] x86 / perf: Fix suspend to RAM on HP nx6325
Date: Sat, 20 Mar 2010 15:07:15 +0100
Message-ID: <201003201507.15358.rjw__37032.5865842917$1269094032$gmane$org@sisk.pl>
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
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Peter,

Your commit 3f6da3905398826d85731247e7fbcf53400c18bd
(perf: Rework and fix the arch CPU-hotplug hooks) unfortunately broke suspend
to RAM (probably hibernation too, but I haven't checked) on my HP nx6325.
I also expect more (if not all) AMD-based boxes to be broken by it.

The machine simply hangs solid while trying to disable CPU1 during suspend.

The patch below fixes it, although I'm not exactly sure why calling
amd_pmu_cpu_offline() during suspend causes the hang to happen.  If there's a
better way to fix this, please let me know.

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: x86 / perf: Fix suspend to RAM on HP nx6325

Commit 3f6da3905398826d85731247e7fbcf53400c18bd
(perf: Rework and fix the arch CPU-hotplug hooks) broke suspend to
RAM on my HP nx6325 (and most likely on other AMD-based boxes too)
by allowing amd_pmu_cpu_offline() to be executed for CPUs that are
going offline as part of the suspend process.  Fix this by modifying
x86_pmu_notifier() so that x86_pmu.cpu_dead(cpu) is only called if
the CPU_TASK_FROZEN bit is unset.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/cpu/perf_event.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/x86/kernel/cpu/perf_event.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/cpu/perf_event.c
+++ linux-2.6/arch/x86/kernel/cpu/perf_event.c
@@ -1334,18 +1334,21 @@ x86_pmu_notifier(struct notifier_block *
 {
 	unsigned int cpu = (long)hcpu;
 
-	switch (action & ~CPU_TASKS_FROZEN) {
+	switch (action) {
 	case CPU_UP_PREPARE:
+	case CPU_UP_PREPARE_FROZEN:
 		if (x86_pmu.cpu_prepare)
 			x86_pmu.cpu_prepare(cpu);
 		break;
 
 	case CPU_STARTING:
+	case CPU_STARTING_FROZEN:
 		if (x86_pmu.cpu_starting)
 			x86_pmu.cpu_starting(cpu);
 		break;
 
 	case CPU_DYING:
+	case CPU_DYING_FROZEN:
 		if (x86_pmu.cpu_dying)
 			x86_pmu.cpu_dying(cpu);
 		break;
