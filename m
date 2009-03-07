From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH][0/8] PM: Rework suspend-resume ordering to
	avoid problems with shared interrupts
Date: Sat, 7 Mar 2009 11:19:15 +0100
Message-ID: <200903071119.16651.rjw__42100.2929601402$1236422499$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902221837.49396.rjw@sisk.pl>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Arve@smtp1.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following patches modifiy the way in which we handle disabling interrupts
during suspend and enabling them during resume.  They also change the ordering
of the core suspend and hibernation code to take advantage of the new approach
to the interrupts and modify the PCI PM core to avoid a few problems.

Namely, interrupts are currently disabled on the boot CPU as soon as the
nonboot CPUs have been disabled, which doesn't allow device drivers' "late"
suspend and "early" resume callbacks to sleep.  Among other things this means
they cannot execute ACPI AML routines, which leads to problems with
suspend-resume of PCI devices, as recently discussed.

1/8 modifies the [suspend|hibernation] and resume code, as well as the other
code using the device PM framework, so that device drivers will not receive
interrupts during the "late" suspend phase, although interrupts will only be
disabled on the CPU right before calling sysdev_suspend() (and analogously
during resume).

2/8 - 4/8 modify the suspend, hibernation and kexec jump code, respectively,
so that the "late" phase of suspending devices will happen before executing the
platform "prepare" callback and disabling nonboot CPUs (and analogously during
resume).

5/8 is a patch that's already in the PCI linux-next tree and I included it in
the series, because the next patches depend on it.

6/8 makes the PCI PM core use pci_set_power_state() to put devices into
D0 during early resume, which allows the platform-specific operations to be
carried out at that time, if necessary.

7/8 uses the opportunity to move pci_restore_standard_config() to pci-driver.c,
where it belongs IMO.

8/8 makes the PCI PM core code put devices into low power states during the
"late" phase of suspend which allows us to avoid a long-standing race related
to shared interrupts and to handle devices that require some platform-specific
operations to be put into low power states appropriately at the same time.

Comments welcome.

Thanks,
Rafael
