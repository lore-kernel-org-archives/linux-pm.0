From: Milton Miller <miltonm@bga.com>
Subject: Re: [stable] [patch 09/12] Fix SMP poweroff hangs
Date: Wed, 10 Oct 2007 05:06:05 -0500 (CDT)
Message-ID: <200710101006.l9AA657g083900__43945.3434119516$1192037680$gmane$org@sullivan.realtime.net>
References: <20071008180406.052382073@mini.kroah.org>,
	<20071008180633.GJ7627@kroah.com>,
	<20071009151702.GA19209@lixom.net>,
	<20071009222003.GA21228@kroah.com>,
	<alpine.LFD.0.9999.0710100120340.7766@localhost.localdomain>,
	<alpine.LFD.0.999.0710091625520.3838@woody.linux%foundation.org>,
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
To: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Mark Lord <lkml@rtr.ca>
Cc: Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


On Tue, Oct 9 2007 Thomas Gleixner wrote:
>On Tue, 9 Oct 2007, Linus Torvalds wrote:
>>On Wed, 10 Oct 2007, Thomas Gleixner wrote:
>>>
>>> Wrapping it into a #ifdef CONFIG_X86 would be sufficient.
>>
>> Well, the ppc oops seems to be a ppc bug regardless.
>>
>> If CPU_HOTPLUG isn't defined, the thing does nothing. And if it is
>> defined, I don't see why/how ppc can validly oops. So I think the first
>> thing to do is to try to figure out why it oopses, not to disable it for
>> ppc.
>
>Fair enough. OTOH for the affected PPC users it's a regression and that's
>what I'm concerned of.
>
>tglx

I agree this exposes a ppc arch bug (and the reason has been diagnosed),
but might not other archs have similar problems?  The patch ties
power-off code to suspend and hibernate cpu hotplug code.

Why not put this ACPI requirement in the ACPI code?   There is already
a hook called at the same place this function was called that is only
used for power off.

Also, the code is compiled for CONFIG_PM_SLEEP_SMP, which is not
CONFIG_HOTPLUG_CPU, it requires the selection of either CONFIG_HIBERNATION
or CONFIG_SUSPEND.  I confirmed that both of these can be disabled
on i386 without disabling acpi.  In such a kernel the existing patch
is insufficient.


 drivers/acpi/sleep/main.c |    2 ++
 kernel/sys.c              |    1 -
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 2cbb9aa..79589bd 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -15,6 +15,7 @@
 #include <linux/dmi.h>
 #include <linux/device.h>
 #include <linux/suspend.h>
+#include <linux/cpu.h>
 
 #include <asm/io.h>
 
@@ -382,6 +383,7 @@ static void acpi_power_off_prepare(void)
 {
 	/* Prepare to power off the system */
 	acpi_sleep_prepare(ACPI_STATE_S5);
+	disable_nonboot_cpus();
 }
 
 static void acpi_power_off(void)
diff --git a/kernel/sys.c b/kernel/sys.c
index 8ae2e63..138f5c8 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -879,7 +879,6 @@ void kernel_power_off(void)
 	kernel_shutdown_prepare(SYSTEM_POWER_OFF);
 	if (pm_power_off_prepare)
 		pm_power_off_prepare();
-	disable_nonboot_cpus();
 	sysdev_shutdown();
 	printk(KERN_EMERG "Power down.\n");
 	machine_power_off();
