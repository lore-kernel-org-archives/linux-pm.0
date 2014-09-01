From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 00/13] genirq / PM: Wakeup interrupts handling rework (related to suspend-to-idle)
Date: Mon, 01 Sep 2014 16:18:47 +0200
Message-ID: <2516134.pmOxkEuOOy@vostro.rjw.lan>
References: <26580319.OZP7jvJnA9@vostro.rjw.lan> <5320472.coYotHR1d0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5320472.coYotHR1d0@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>, Aubrey Li <aubrey.li@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

This set of patches reworks the handling of system wakeup interrupts so that
suspend-to-idle is covered in the same way as full system suspend.

This time we have several new patches from Thomas and hopefully we're nailed
down that thing at last.

[01/13] Mechanism to wake up the system or abort suspend in progress
        automatically (this is different from the previous versions, because
        I eventually convinced myself that pm_abort_suspend didn't really
        require any locking).
[02/13] Move PM-related IRQ code to kernel/irq/pm.c.
[03/13] Add accounting for IRQF_NO_SUSPEND and IRQF_RESUME_EARLY.
[04/13] Use the accoundint added by [03/13].
[05/13] Make suspend_device_irqs() mask non-wakeup interruts if
        IRQCHIP_MASK_ON_SUSPEND is set.
[06/13] Synchronize IRQs in the same loop in which they are reconfigured
        in suspend_device_irqs().
[07/13] Separate irq_check_poll() checks from disabled/no action checks in
        kernel/irq/chip.c.
[08/13] Add a helper for checks made by many IRQ flow handlers in the same way.
[09/13] Mark wakeup sources as "armed" on suspend (using a new flag).
[10/13] Make suspend_device_irqs() leave wakeup interrupts enabled, but handle
        them so that the first interrupt triggers system wakeup.
[11/13] Set IRQCHIP_SKIP_SET_WAKE for x86 IOAPIC IRQ chips (same as before).
[12/13] Make PCIe PME wake up from suspend to idle (same as before).
[13/13] Document rules related to system suspend and interrupts (updated).

The series have been tested on MSI Wind, but more testing is welcome.

There is a pm-genirq branch in the linux-pm.git tree containing these patches:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-genirq

that can be pulled from.

Kind regards,
Rafael
