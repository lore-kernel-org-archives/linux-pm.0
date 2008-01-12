From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/4] PM: Do not destroy/create devices while
 suspended (rev. 2)
Date: Fri, 11 Jan 2008 16:46:13 -0800
Message-ID: <20080111164613.7791bb94.akpm__14030.8138252751$1200098874$gmane$org@linux-foundation.org>
References: <200801020032.45529.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801020032.45529.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>, gregkh@suse.de, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, linux-acpi@vger.kernel.org, pavel@suse.cz, linux-pm@lists.linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Wed, 2 Jan 2008 00:32:44 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Some device drivers register CPU hotplug notifiers and use them to destroy
> device objects when removing the corresponding CPUs and to create these objects
> when adding the CPUs back.
> 
> Unfortunately, this is not the right thing to do during suspend/hibernation,
> since in that cases the CPU hotplug notifiers are called after suspending
> devices and before resuming them, so the operations in question are carried
> out on the objects representing suspended devices which shouldn't be
> unregistered behing the PM core's back. __Although right now it usually doesn't
> lead to any practical complications, it will predictably deadlock if
> gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch is applied.
> 
> The solution is to prevent drivers from removing/adding devices from within
> CPU hotplug notifiers during suspend/hibernation using the FROZEN bit
> in the notifier's action argument.  However, this has to be done with care,
> since the devices objects related to the nonboot CPUs that failed to go online
> during resume should not be present in the system.  For this reason, it seems
> reasonable to introduce a mechanism allowing drivers to ask the PM core to
> remove device objects corresponding to suspended devices on their behalf.
> 
> The first patch in the series introduces such a mechanism.  The remaining three
> patches modify the MSR, x86-64 MCE and cpuid drivers in accordance with the
> above approach.

These patches are a preresuisite to
gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch and its
later fixed-up versions.

So what I have now is

revert-gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch
pm-introduce-destroy_suspended_device.patch
pm-do-not-destroy-create-devices-while-suspended-in-msrc-rev-2.patch
pm-do-not-destroy-create-devices-while-suspended-in-mce_64c.patch
pm-do-not-destroy-create-devices-while-suspended-in-cpuidc.patch
pm-acquire-device-locks-on-suspend-rev-3.patch
pm-acquire-device-locks-on-suspend-rev-3-checkpatch-fixes.patch
pm-acquire-device-locks-on-suspend-rev-3-checkpatch-fixes-2.patch

So what needs to happen in Greg's tree is

a) drop the old gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch

b) apply these four patches

c) apply the new pm-acquire-device-locks-on-suspend-rev-3.patch (and its fixups)
