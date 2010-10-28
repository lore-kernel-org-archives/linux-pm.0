From: Thomas Renninger <trenn@suse.de>
Subject: [RFC] PERF: fix power:cpu_idle double end events and
	missing acpi_idle events - make cpu_idle power events cpuidle
	sysfs conform
Date: Thu, 28 Oct 2010 02:46:38 +0200
Message-ID: <201010280246.40134.trenn__47329.8405916013$1288226880$gmane$org@suse.de>
References: <1288136605-10526-1-git-send-email-trenn@suse.de>
	<1288136605-10526-5-git-send-email-trenn@suse.de>
	<201010271742.04545.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010271742.04545.trenn@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: arjan@linux.intel.com
Cc: linux-acpi@vger.kernel.org, jean.pihet@newoldbits.com, Robert Schoene <robert.schoene@tu-dresden.de>, linux-trace-users@vger.kernel.org, mingo@elte.hu, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 27 October 2010 05:42:04 pm Thomas Renninger wrote:
> On Wednesday 27 October 2010 01:43:25 Thomas Renninger wrote:
> > cpu_idle events (transition into sleep state and exiting) are
> > both fired in pm_idle().
> > 
> > Entering sleep state and exiting should always get fired inside
> > pm_idle() already.
> > 
> > This is a revert of commit c882e0feb937af4e5b991cbd1c
..
> Argh, I tried to come up with patches, but run out of
> time. I will send something soon.

Below patch should fix and clean up current cpu_idle (former power_start/end)
event throwing policy.

But it introduces a change which state number is thrown in acpi_idle
mwait case. This should be done anyway, but needs further adjustings
in userspace.

If a cpuidle driver is registered, now the event throws the state which
maps to the registered cpuidle state.
This is an important fix, so that the whole cpu_idle event (state) 
interface gets architecture independent.
For the intel_idle driver it currently does not matter because the cpuidle
and mwait C1/2/3 states by luck exactly match.

But on my machine with acpi_idle I only get 2 states: C1/C3.
ls /sys/devices/system/cpu/cpu0/cpuidle/state
state0/     state1/ state2/
(poll idle)   (C1)    (C3)
So with this change it would throw state=2, but it is C3, which has to be
grabbed from:
/sys/devices/system/cpu/cpu0/cpuidle/state2/name

But in intel_idle case the state names are bit long to be displayed nicely
in perf timechart:
        { /* MWAIT C1 */
                .name = "NHM-C1",
                .desc = "MWAIT 0x00",
        { /* MWAIT C3 */
                .name = "NHM-C6",
                .desc = "MWAIT 0x20",

Therefore I suggest to:
Shorten .name (also by cutting the char array down) to 2 characters
1) Either introduce convention that first word in .desc is the longer name,
   arbitrary flags (as strings) follow, like:
        { /* MWAIT C3 */
                .name = "C3",
                .desc = "NHM-C6 MWAIT 0x20",
2) Or introduce another sysfs file, however it's named:
        { /* MWAIT C3 */
                .name = "NHM-C6",
                .desc = "MWAIT 0x20",
                .abbr = "C3"
The latter is fully userspace (sysfs) compatible, I'd go for that.

If nobody objects, I may have time to implement this (will take more than a week) which includes:
 - place cpu_idle events correctly, so that they always get thrown when idle
   and no double end marker events can happen
 - Make above cpuidle name/sysfs changes
 - Let perf timechart grab the correct idle state name from sysfs.
   -> Mapping between the cpu_idle event and the sysfs cpuidle state.

Thanks,

    Thomas

--------
PERF: fix power:cpu_idle double end events - always throw events with acpi_idle

Convention should be:
Fire cpu_idle events inside the current pm_idle function (not somewhere
down the the callee tree) to keep things easy.

This is not always possible, only exception is:
c1e_idle -> calls default_idle which throws events -> easy and obvious.
Current possible pm_idle functions in X86:
c1e_idle, poll_idle, cpuidle_idle_call, mwait_idle, default_idle

-> this is really easy is now (if I haven't overseen something).

This also introduces another cleanup which may affect userspace:
The type field of the cpu_idle power event can now direclty get
mapped to:
/sys/devices/system/cpu/cpuX/cpuidle/stateX/{name,desc,usage,time,...}
instead of throwing very CPU/mwait specific numbers.
Fortunately this change is not visible for the intel_idle driver.
For the acpi_idle driver it should only be visible if the vendor
misses out C-states in his BIOS.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Robert Schoene <robert.schoene@tu-dresden.de>
CC: Arjan van de Ven <arjan@linux.intel.com>
CC: Ingo Molnar <mingo@elte.hu>
CC: linux-trace-users@vger.kernel.org
CC: linux-pm@lists.linux-foundation.org
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 155d975..b618548 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -387,6 +387,8 @@ void default_idle(void)
 		else
 			local_irq_enable();
 		current_thread_info()->status |= TS_POLLING;
+		trace_power_end(smp_processor_id());
+		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 	} else {
 		local_irq_enable();
 		/* loop is done by the caller */
@@ -444,8 +446,6 @@ EXPORT_SYMBOL_GPL(cpu_idle_wait);
  */
 void mwait_idle_with_hints(unsigned long ax, unsigned long cx)
 {
-	trace_power_start(POWER_CSTATE, (ax>>4)+1, smp_processor_id());
-	trace_cpu_idle((ax>>4)+1, smp_processor_id());
 	if (!need_resched()) {
 		if (cpu_has(&current_cpu_data, X86_FEATURE_CLFLUSH_MONITOR))
 			clflush((void *)&current_thread_info()->flags);
@@ -472,6 +472,8 @@ static void mwait_idle(void)
 			__sti_mwait(0, 0);
 		else
 			local_irq_enable();
+		trace_power_end(smp_processor_id());
+		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 	} else
 		local_irq_enable();
 }
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 4b9befa..8d12878 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -57,8 +57,6 @@
 #include <asm/syscalls.h>
 #include <asm/debugreg.h>
 
-#include <trace/events/power.h>
-
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
 /*
@@ -113,8 +111,6 @@ void cpu_idle(void)
 			stop_critical_timings();
 			pm_idle();
 			start_critical_timings();
-			trace_power_end(smp_processor_id());
-			trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 		}
 		tick_nohz_restart_sched_tick();
 		preempt_enable_no_resched();
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 28153a9..d7b3e95 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -51,8 +51,6 @@
 #include <asm/syscalls.h>
 #include <asm/debugreg.h>
 
-#include <trace/events/power.h>
-
 asmlinkage extern void ret_from_fork(void);
 
 DEFINE_PER_CPU(unsigned long, old_rsp);
@@ -141,10 +139,6 @@ void cpu_idle(void)
 			pm_idle();
 			start_critical_timings();
 
-			trace_power_end(smp_processor_id());
-			trace_cpu_idle(PWR_EVENT_EXIT,
-				       smp_processor_id());
-
 			/* In many cases the interrupt that ended idle
 			   has already called exit_idle. But some idle
 			   loops can be woken up without interrupt. */
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 08d5f05..491a4af 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -96,7 +96,15 @@ static void cpuidle_idle_call(void)
 
 	/* enter the state and update stats */
 	dev->last_state = target_state;
+
+	trace_power_start(POWER_CSTATE, next_state, dev->cpu);
+	trace_cpu_idle(next_state, dev->cpu);
+
 	dev->last_residency = target_state->enter(dev, target_state);
+
+	trace_power_end(dev->cpu);
+	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
+
 	if (dev->last_state)
 		target_state = dev->last_state;
 
@@ -106,8 +114,6 @@ static void cpuidle_idle_call(void)
 	/* give the governor an opportunity to reflect on the outcome */
 	if (cpuidle_curr_governor->reflect)
 		cpuidle_curr_governor->reflect(dev);
-	trace_power_end(smp_processor_id());
-	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 }
 
 /**
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index d3701bf..5539cff 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -201,8 +201,6 @@ static int intel_idle(struct cpuidle_device *dev, struct cpuidle_state *state)
 	kt_before = ktime_get_real();
 
 	stop_critical_timings();
-	trace_power_start(POWER_CSTATE, (eax >> 4) + 1, cpu);
-	trace_cpu_idle((eax >> 4) + 1, cpu);
 	if (!need_resched()) {
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
