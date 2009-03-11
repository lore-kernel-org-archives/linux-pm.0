From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/10] PM: Rework suspend-resume ordering to avoid
	problems with shared interrupts (updated)
Date: Wed, 11 Mar 2009 10:30:37 +0100
Message-ID: <200903111030.39371.rjw__30171.7698378072$1236765661$gmane$org@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Arve@smtp1.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Hi,

The last iteration of this series of patches didn't draw comments except for
the discussion about the "wake-up" interrupts, so here's an update that I'd
like to consider as more-or-less final.  I would also like to use a separate
'suspend' git tree for merging these patches, if you don't mind.

The following patches modifiy the way in which we handle disabling interrupts
during suspend and enabling them during resume.  They also change the ordering
of the core suspend and hibernation code to take advantage of the new approach
to the interrupts and modify the PCI PM core to avoid a few problems.

Namely, interrupts are currently disabled on the boot CPU as soon as the
nonboot CPUs have been disabled, which doesn't allow device drivers' "late"
suspend and "early" resume callbacks to sleep.  Among other things this means
they cannot execute ACPI AML routines, which leads to problems with
suspend-resume of PCI devices, as recently discussed.

1/10 modifies the [suspend|hibernation] and resume code, as well as the other
code using the device PM framework, so that device drivers will not receive
interrupts during the "late" suspend phase, although interrupts will only be
disabled on the CPU right before calling sysdev_suspend() (and analogously
during resume).

2/10 - 4/10 modify the suspend, hibernation and kexec jump code, respectively,
so that the "late" phase of suspending devices will happen before executing the
platform "prepare" callback and disabling nonboot CPUs (and analogously during
resume).

5/10 is a patch that's already in the PCI linux-next tree and I included it in
the series, because the next patches depend on it.

6/10 makes the PCI PM core use pci_set_power_state() to put devices into
D0 during early resume, which allows the platform-specific operations to be
carried out at that time, if necessary.

7/10 uses the opportunity to move pci_restore_standard_config() to pci-driver.c,
where it belongs IMO.

8/10 makes the PCI PM core code put devices into low power states during the
"late" phase of suspend which allows us to avoid a long-standing race related
to shared interrupts and to handle devices that require some platform-specific
operations to be put into low power states appropriately at the same time.
[The second rev of the patch retains the current behavior during the
"power-off" phase of hibernation, which is that the devices without drivers or
without PM support in the drivers are not power managed by the core.]

9/10 fixes pci_set_power_state() so that it doesn't return error code when
attempting to put a PCI device without PM support (either native or through the
platform) into D0 (such devices are always in D0).

10/10 makes the PCI PM core save and restore the configuration spaces of
devices that have no drivers or no PM support in the drivers during suspend and
resume, respectively.

Thanks,
Rafael
