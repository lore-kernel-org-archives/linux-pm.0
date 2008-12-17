From: Mark Lord <lkml@rtr.ca>
Subject: SMP poweroff hangs: it's baaaack! But on x86_64 this
	time.
Date: Wed, 17 Dec 2008 10:48:02 -0500
Message-ID: <49491F32.1040400__39683.6819047623$1229529065$gmane$org@rtr.ca>
References: <20071213053020.E28AB1454450@imap.suse.de>
	<4761601B.3030408@rtr.ca> <20071213164545.GA10593@suse.de>
	<47616C15.7030604@rtr.ca> <47616F8C.9030803@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47616F8C.9030803@rtr.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, tglx@linutronix.de, davej@redhat.com, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> Subject: Fix SMP poweroff hangs
> From: Mark Lord <lkml@rtr.ca>
> 
> We need to disable all CPUs other than the boot CPU (usually 0) before
> attempting to power-off modern SMP machines.  This fixes the
> hang-on-poweroff issue on my MythTV SMP box, and also on Thomas Gleixner's
> new toybox.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  kernel/sys.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff -puN kernel/sys.c~fix-smp-poweroff-hangs kernel/sys.c
> --- a/kernel/sys.c~fix-smp-poweroff-hangs
> +++ a/kernel/sys.c
> @@ -32,6 +32,7 @@
>  #include <linux/getcpu.h>
>  #include <linux/task_io_accounting_ops.h>
>  #include <linux/seccomp.h>
> +#include <linux/cpu.h>
>  
>  #include <linux/compat.h>
>  #include <linux/syscalls.h>
> @@ -878,6 +879,7 @@ void kernel_power_off(void)
>  	kernel_shutdown_prepare(SYSTEM_POWER_OFF);
>  	if (pm_power_off_prepare)
>  		pm_power_off_prepare();
> +	disable_nonboot_cpus();
>  	sysdev_shutdown();
>  	printk(KERN_EMERG "Power down.\n");
>  	machine_power_off();
..

This bug has returned here now, but on x86_86 this time around.
Same machine as before, just upgraded toa 64-bit kernel/user (2.6.27.9)
from the original 32-bit kernel/user that was originally fixed (above).

One hang at poweroff over the past 10 days.  Not much, but enough
to destroy confidence in "unattended" operation.

I lack opportunity to dig further into the code for now,
but just wanted to flag the problem, in case similar reports
from others might already be out there.

In the meanwhile, I'm experimenting with this simple patch,
garnered from the 32-bit investigations last time around.
We should know in a few weeks whether it has any effect or not.

--- old/kernel/sys.c	2008-10-18 13:57:22.000000000 -0400
+++ linux-2.6.27.9/kernel/sys.c	2008-12-17 09:42:17.000000000 -0500
@@ -303,6 +303,8 @@
 
 static void kernel_shutdown_prepare(enum system_states state)
 {
+	set_cpus_allowed(current, cpumask_of_cpu(first_cpu(cpu_online_map)));
+	disable_nonboot_cpus();
 	blocking_notifier_call_chain(&reboot_notifier_list,
 		(state == SYSTEM_HALT)?SYS_HALT:SYS_POWER_OFF, NULL);
 	system_state = state;
@@ -333,7 +335,6 @@
 	kernel_shutdown_prepare(SYSTEM_POWER_OFF);
 	if (pm_power_off_prepare)
 		pm_power_off_prepare();
-	disable_nonboot_cpus();
 	sysdev_shutdown();
 	printk(KERN_EMERG "Power down.\n");
 	machine_power_off();
