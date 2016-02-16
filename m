From: James Morse <james.morse@arm.com>
Subject: [PATCH v5 00/15] arm64: kernel: Add support for hibernate/suspend-to-disk
Date: Tue, 16 Feb 2016 15:49:12 +0000
Message-ID: <1455637767-31561-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54425 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755273AbcBPPvE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Feb 2016 10:51:04 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

Hi all,

This version of hibernate is based on v4.5-rc4, with the contents of the arm64
for-next/pgtable branch and Ard's v6sub1 "arm64: split linear and kernel
mappings" series [0]. The patches shared with kexec still come from v13 [1].

I've renumbered the labels in patch 4, per Akashi Takahiro's suggestion.
Parts of patch 5 were reworked from Akashi Takahiro's original version, to
avoid another round of changes to hyp-entry.S:el1_sync.

Resume from hibernate now uses el2_setup() to re-configure el2. This means we
don't assume the old kernel's versions are valid. (Thanks to Lorenzo for the
suggestion). Patches 11 and 12 are needed to support this.

The enable/disable fiq calls have been removed, these were blindly copied
from arch/arm, but aren't needed for arch/arm64.

The explicit call to kvm_arch_hardware_disable() is gone, as patch 5's
hyp_init_cpu_pm_notifier() call will do this for us.

The resume code gained an 'in_suspend = 0'. The hibernate core code has this
as a __no_save variable, and expects it to keep its initial value. When we
have KASLR, or resume with a different kernel version, it gets a random
value from memory instead. x86_64 sets the variable explicitly like this too.


Resuming with a different kernel version, (but one with the same page size
and va bits), does work up until patch 15, which forbids it. Given how
fragile it is if uefi allocates memory in different places, and how hard it
would be to debug, I don't think its worth it, but it would be good to hear
others opinions!

This series can be retrieved from:
git://linux-arm.org/linux-jm.git -b hibernate/v5


Changes since v4:
 * Mask in current T0SZ bits when restoring tcr_el1.
 * Use el2_setup() to reconfigure el2.
 * Remove fiq calls.
 * Removed kvm_arch_hardware_disable() call.
 * Added 'in_suspend = 0' to avoid 'if (uninitialised-memory) ...'.
 * Removed icache-flush from hibernate-asm.S, this was done in hibernate.c.
 * Commented tlbis.
 * Removed dsb after copy_page(), this behaviour is guaranteed by the
   architecture.

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

Changes since v2:
 * Rewrote restore in-place patch - we can't clean pages in copy_page(), we
   need to publish a list for the architecture to clean
 * Added missing pgprot_val() in hibernate.c, spotted by STRICT_MM_TYPECHECKS
 * Removed 'tcr_set_idmap_t0sz' from proc.S - I missed this when rebase-ing
 * Re-imported the first four patches from kexec v12
 * Rebased onto v4.4-rc2
 * Changes from Pavel Machek's comments

Changes since v1:
 * Removed for_each_process(){ for_each_vma() { } }; cache cleaning, replaced
   with icache_flush_range() call in core hibernate code
 * Rebased onto conflicting tcr_ek1.t0sz bug-fix patch


[v4] http://www.spinics.net/lists/arm-kernel/msg477769.html
[v3] http://www.spinics.net/lists/arm-kernel/msg463590.html
[v2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376450.html
[v1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376450.html

[0] http://www.spinics.net/lists/arm-kernel/msg483446.html
[1] http://www.spinics.net/lists/arm-kernel/msg474889.html

AKASHI Takahiro (1):
  arm64: kvm: allows kvm cpu hotplug

Geoff Levand (5):
  arm64: Fold proc-macros.S into assembler.h
  arm64: Cleanup SCTLR flags
  arm64: Convert hcalls to use HVC immediate value
  arm64: Add new hcall HVC_CALL_FUNC
  arm64: Add new asm macro copy_page

James Morse (9):
  arm64: kernel: Rework finisher callback out of __cpu_suspend_enter().
  arm64: Change cpu_resume() to enable mmu early then access sleep_sp by va
  arm64: kernel: Include _AC definition in page.h
  arm64: Promote KERNEL_START/KERNEL_END definitions to a header file
  arm64: head.S: Change the register el2_setup() returns its result in x0
  arm64: head.S: el2_setup() to accept sctlr_el1 as an argument
  PM / Hibernate: Call flush_icache_range() on pages restored in-place
  arm64: kernel: Add support for hibernate/suspend-to-disk
  arm64: hibernate: Prevent resume from a different kernel version

 arch/arm/include/asm/kvm_host.h    |  10 +-
 arch/arm/include/asm/kvm_mmu.h     |   1 +
 arch/arm/kvm/arm.c                 |  98 +++++---
 arch/arm/kvm/mmu.c                 |   5 +
 arch/arm64/Kconfig                 |   7 +
 arch/arm64/include/asm/assembler.h | 110 ++++++++-
 arch/arm64/include/asm/kvm_arm.h   |  11 -
 arch/arm64/include/asm/kvm_host.h  |   1 -
 arch/arm64/include/asm/kvm_mmu.h   |  20 ++
 arch/arm64/include/asm/memory.h    |   3 +
 arch/arm64/include/asm/page.h      |   2 +
 arch/arm64/include/asm/processor.h |   2 +
 arch/arm64/include/asm/suspend.h   |  35 ++-
 arch/arm64/include/asm/sysreg.h    |  19 +-
 arch/arm64/include/asm/virt.h      |  40 ++++
 arch/arm64/kernel/Makefile         |   1 +
 arch/arm64/kernel/asm-offsets.c    |  10 +-
 arch/arm64/kernel/head.S           |  42 ++--
 arch/arm64/kernel/hibernate-asm.S  | 149 ++++++++++++
 arch/arm64/kernel/hibernate.c      | 477 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/hyp-stub.S       |  49 ++--
 arch/arm64/kernel/setup.c          |   1 -
 arch/arm64/kernel/sleep.S          | 146 ++++--------
 arch/arm64/kernel/suspend.c        |  97 ++++----
 arch/arm64/kernel/vmlinux.lds.S    |  15 ++
 arch/arm64/kvm/hyp-init.S          |  47 +++-
 arch/arm64/kvm/hyp.S               |   3 +-
 arch/arm64/kvm/hyp/hyp-entry.S     |   9 +-
 arch/arm64/mm/cache.S              |   2 -
 arch/arm64/mm/proc-macros.S        |  98 --------
 arch/arm64/mm/proc.S               |  44 ++--
 kernel/power/swap.c                |  18 ++
 32 files changed, 1193 insertions(+), 379 deletions(-)
 create mode 100644 arch/arm64/kernel/hibernate-asm.S
 create mode 100644 arch/arm64/kernel/hibernate.c
 delete mode 100644 arch/arm64/mm/proc-macros.S

-- 
2.6.2

