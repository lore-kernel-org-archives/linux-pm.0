From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC] Possible suspend/resume problems with ACPI
Date: Fri, 5 Feb 2010 00:02:30 +0100
Message-ID: <201002050002.30647.rjw__1897.70129877633$1265325746$gmane$org@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi,

After I'd noticed the race between EC transactions and the suspend thread that
the patch at http://patchwork.kernel.org/patch/76871/ is supposed to fix, I
started to think about what ACPI does in the platform suspend/resume callbacks
and I found a few potential issues.

First off, there's the issue addressed by http://patchwork.kernel.org/patch/76871/.
I must admit I was afraid that CPU hotunplug might cause an EC transaction to
happen on some systems, but I don't think that's the case any more.  At least,
I didn't find any reason for that in the code, so I think the patch is correct.
If you know of anything related to the CPU hotunplug that might result in
triggering an EC transaction, please let me know.

Second, in the resume code path we execute _WAK after enabling the nonboot
CPUs (we can't do that earlier, because the CPU hotplug uses _INI on some
platforms and that crashes systems if executed after _WAK).  However, before
executing _WAK we enable runtime GPEs, apparently because they might be needed
to handle things possibly triggered by _WAK.  At lease there's a comment in
acpi_leave_sleep_state() suggesting that.  The problem is, though, that at the
point we execute _WAK the SCI is effectively inactive due to
disable_device_irqs() called during suspend.

Now, that wouldn't be a problem if the interrupt was disabled at the hardware
level, but it's not.  It only is marked as disabled, so if it triggers, we lose
it.  Thus, although we enable the GPEs before executing _WAK, we won't get
any notification from them because the SCI is not functional at this point.
This seems to be wrong and IMO it should be addressed somehow.

One possible solution may be to move the enabling of runtime GPEs and the
execution of _WAK to the point where interrupts have been enabled by
resume_device_irqs().  In that case, however, the powering off of PCI devices
and the restoration of their standard config registers would happen before
executing _WAK.  That doesn't seem to break my test boxes, but I'm not sure if
it's going to work universally.

Similarly, it looks like during suspend we should disable runtime GPEs before
suspend_device_irqs() is called, because it doesn't really make sense to keep
them enabled after that point.  This, of course, would mean putting PCI devices
into low power states with runtime GPEs disabled, but I don't think it would
be a problem.  Still, though, I'm not sure if it makes sense to execute _PTS
while runtime GPEs are disabled, so perhaps we'd also need to execute _PTS
before suspend_device_irqs().

Please tell me what you think.

Rafael
