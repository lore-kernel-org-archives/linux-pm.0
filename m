From: James Morse <james.morse@arm.com>
Subject: [PATCH v4 00/13] arm64: kernel: Add support for hibernate/suspend-to-disk
Date: Thu, 28 Jan 2016 10:42:33 +0000
Message-ID: <1453977766-20907-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59043 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964914AbcA1KoL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Jan 2016 05:44:11 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Marc Zyngier <marc.zyngier@arm.com>

Hi all,

This version of hibernate is rebased onto v4.5-rc1, including updated patches
shared with kexec v13 [0] (1-5, 10).

I've also tested it with Ard's KASLR series [1].
The most significant change is the use of the arch-header to store the
location of the page tables and resume code when it has been moved by KASLR.

This implicitly allows resuming with a different kernel version, (and the work
needed to do this is the same). Patch 12 restricts resume to kernels with the
same MMU configuration, (page size, number of page levels etc).
Patch 13 forbids restoring with a different kernel version altogether - do
we want to support this?

Due to the arch-header changes, I dropped Pavel's Ack on patch 12.

Parts of patch 5 were reworked from Akashi Takahiro's original version, to
avoid another round of changes to hyp-entry.S:el1_sync.

This series can be retrieved from:
git://linux-arm.org/linux-jm.git -b hibernate/v4

Changes since v3:
 * To work with kaslr:
   * hibernate now uses the arch-header to store the address of the page
     tables, and the point to re-enter the resumed kernel.
   * The el2 vectors are reloaded to point to the 'safe' page, then back to the
     resumed kernel.
   * PoC cleaning is done after the jump to the resumed kernel, as we don't
     know the restored kernel's boundaries in advance.
   * Some variables are accessed via aliases in the linear map, as the kernel
     text is not mapped during resume. restore_pblist is one example.
   * Execute the safe page from the bottom of memory, not the top, so that we
     can restore the resumed kernel's page tables directly.

 * Rebased the common patches onto v13 of kexec
 * Changed hibernate-asm.S to use the new copy_page macro.
 * Changed copy_p?d()s to use the do { } while(); pattern.
 * Added some missing barriers. (dsb after ic ialluis).

Changes from v2:
 * Rewrote restore in-place patch - we can't clean pages in copy_page(), we
   need to publish a list for the architecture to clean
 * Added missing pgprot_val() in hibernate.c, spotted by STRICT_MM_TYPECHECKS
 * Removed 'tcr_set_idmap_t0sz' from proc.S - I missed this when rebase-ing
 * Re-imported the first four patches from kexec v12
 * Rebased onto v4.4-rc2
 * Changes from Pavel Machek's comments

Changes from v1:
 * Removed for_each_process(){ for_each_vma() { } }; cache cleaning, replaced
   with icache_flush_range() call in core hibernate code
 * Rebased onto conflicting tcr_ek1.t0sz bug-fix patch


[v3] http://www.spinics.net/lists/arm-kernel/msg463590.html
[v2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376450.html
[v1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376450.html

[0] http://www.spinics.net/lists/arm-kernel/msg474889.html
[1] http://permalink.gmane.org/gmane.linux.kernel/2116531

AKASHI Takahiro (1):
  arm64: kvm: allows kvm cpu hotplug

Geoff Levand (5):
  arm64: Fold proc-macros.S into assembler.h
  arm64: Cleanup SCTLR flags
  arm64: Convert hcalls to use HVC immediate value
  arm64: Add new hcall HVC_CALL_FUNC
  arm64: Add new asm macro copy_page

James Morse (7):
  arm64: kernel: Rework finisher callback out of __cpu_suspend_enter().
  arm64: Change cpu_resume() to enable mmu early then access sleep_sp by
    va
  arm64: kernel: Include _AC definition in page.h
  arm64: Promote KERNEL_START/KERNEL_END definitions to a header file
  PM / Hibernate: Call flush_icache_range() on pages restored in-place
  arm64: kernel: Add support for hibernate/suspend-to-disk
  arm64: hibernate: Prevent resume from a different kernel version

 arch/arm/include/asm/kvm_host.h    |  10 +-
 arch/arm/include/asm/kvm_mmu.h     |   1 +
 arch/arm/kvm/arm.c                 |  98 +++++---
 arch/arm/kvm/mmu.c                 |   5 +
 arch/arm64/Kconfig                 |   7 +
 arch/arm64/include/asm/assembler.h |  89 ++++++-
 arch/arm64/include/asm/kvm_arm.h   |  11 -
 arch/arm64/include/asm/kvm_host.h  |   1 -
 arch/arm64/include/asm/kvm_mmu.h   |  19 ++
 arch/arm64/include/asm/memory.h    |   3 +
 arch/arm64/include/asm/page.h      |   2 +
 arch/arm64/include/asm/suspend.h   |  30 ++-
 arch/arm64/include/asm/sysreg.h    |  19 +-
 arch/arm64/include/asm/virt.h      |  40 ++++
 arch/arm64/kernel/Makefile         |   1 +
 arch/arm64/kernel/asm-offsets.c    |  10 +-
 arch/arm64/kernel/head.S           |   5 +-
 arch/arm64/kernel/hibernate-asm.S  | 137 +++++++++++
 arch/arm64/kernel/hibernate.c      | 472 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/hyp-stub.S       |  43 +++-
 arch/arm64/kernel/setup.c          |   1 -
 arch/arm64/kernel/sleep.S          | 145 ++++--------
 arch/arm64/kernel/suspend.c        | 108 ++++-----
 arch/arm64/kernel/vmlinux.lds.S    |  15 ++
 arch/arm64/kvm/hyp-init.S          |  47 +++-
 arch/arm64/kvm/hyp.S               |   3 +-
 arch/arm64/kvm/hyp/hyp-entry.S     |   9 +-
 arch/arm64/mm/cache.S              |   2 -
 arch/arm64/mm/proc-macros.S        |  86 -------
 arch/arm64/mm/proc.S               |  38 +--
 kernel/power/swap.c                |  18 ++
 31 files changed, 1114 insertions(+), 361 deletions(-)
 create mode 100644 arch/arm64/kernel/hibernate-asm.S
 create mode 100644 arch/arm64/kernel/hibernate.c
 delete mode 100644 arch/arm64/mm/proc-macros.S

-- 
2.6.2

