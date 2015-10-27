From: James Morse <james.morse@arm.com>
Subject: [PATCH v2 00/11] arm64: kernel: Add support for hibernate/suspend-to-disk
Date: Tue, 27 Oct 2015 17:29:09 +0000
Message-ID: <1445966960-31724-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57832 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754441AbbJ0RaG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 27 Oct 2015 13:30:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

Hi all,

This version of the series follows Lorenzo's option one, described at [0],
when cleaning executable code that may be held in data caches after
hibernate/resume. Patch ten adds the necessary hook to kernel/power/snapshot.c.

This allows the architecture's hibernate assembly code to clean all the
pages that it copies, meaning the for_each_process(); for_each_vma(); version
of this can be removed.

The other changes were fixes so that this code works both before and after
Ard Biesheuvel's 'relax Image placement rules' series [1] that moves the
kernel text out of the linear map.

Finally the series has picked up Lorenzo's t0sz fix [2], as it refactors
all of those changes out, and the first four patches of kexec v10, [3].

(Version one here: [4])


James

[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/380153.html
[1] http://www.spinics.net/lists/arm-kernel/msg446929.html
[2] http://www.spinics.net/lists/arm-kernel/msg454862.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/379268.html
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376450.html

AKASHI Takahiro (1):
  arm64: kvm: allows kvm cpu hotplug

Geoff Levand (3):
  arm64: Fold proc-macros.S into assembler.h
  arm64: Convert hcalls to use HVC immediate value
  arm64: Add new hcall HVC_CALL_FUNC

James Morse (6):
  arm64: kernel: Rework finisher callback out of __cpu_suspend_enter().
  arm64: Change cpu_resume() to enable mmu early then access sleep_sp by
    va
  arm64: kernel: Include _AC definition in page.h
  arm64: Promote KERNEL_START/KERNEL_END definitions to a header file
  PM / Hibernate: clean cached pages on architectures that require it
  arm64: kernel: Add support for hibernate/suspend-to-disk.

Lorenzo Pieralisi (1):
  arm64: kernel: fix tcr_el1.t0sz restore on systems with extended idmap

 arch/arm/include/asm/kvm_host.h    |  10 +-
 arch/arm/include/asm/kvm_mmu.h     |   1 +
 arch/arm/kvm/arm.c                 |  79 ++++----
 arch/arm/kvm/mmu.c                 |   5 +
 arch/arm64/Kconfig                 |   3 +
 arch/arm64/include/asm/assembler.h |  48 ++++-
 arch/arm64/include/asm/kvm_host.h  |  16 +-
 arch/arm64/include/asm/kvm_mmu.h   |   1 +
 arch/arm64/include/asm/memory.h    |   3 +
 arch/arm64/include/asm/page.h      |   2 +
 arch/arm64/include/asm/suspend.h   |  31 +++-
 arch/arm64/include/asm/virt.h      |  49 +++++
 arch/arm64/kernel/Makefile         |   1 +
 arch/arm64/kernel/asm-offsets.c    |   9 +-
 arch/arm64/kernel/head.S           |   6 +-
 arch/arm64/kernel/hibernate-asm.S  | 118 ++++++++++++
 arch/arm64/kernel/hibernate.c      | 359 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/hyp-stub.S       |  43 +++--
 arch/arm64/kernel/setup.c          |   1 -
 arch/arm64/kernel/sleep.S          | 148 ++++++---------
 arch/arm64/kernel/suspend.c        |  99 ++++------
 arch/arm64/kernel/vmlinux.lds.S    |  15 ++
 arch/arm64/kvm/hyp-init.S          |  34 +++-
 arch/arm64/kvm/hyp.S               |  44 ++++-
 arch/arm64/mm/cache.S              |   2 -
 arch/arm64/mm/proc-macros.S        |  64 -------
 arch/arm64/mm/proc.S               |  30 +---
 kernel/power/snapshot.c            |   4 +
 28 files changed, 900 insertions(+), 325 deletions(-)
 create mode 100644 arch/arm64/kernel/hibernate-asm.S
 create mode 100644 arch/arm64/kernel/hibernate.c
 delete mode 100644 arch/arm64/mm/proc-macros.S

-- 
2.1.4

