From: James Morse <james.morse@arm.com>
Subject: [PATCH v6 00/14] arm64: kernel: Add support for hibernate/suspend-to-disk
Date: Mon, 29 Feb 2016 17:20:09 +0000
Message-ID: <1456766423-1554-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46115 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbcB2RVw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 29 Feb 2016 12:21:52 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, James Morse <james.morse@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

Hi all,

for-next/core has changed quite a bit with the staged inclusion of kaslr.
This series is a rebase onto the most recent commit "arm64: lse: deal with
clobbered IP registers after branch via PLT", and then tested with some
nasty hacks in the efi stub to provide a psuedo-random address layout on Juno.

After Lorenzo's suggestion, el2_setup() now gets called from the assembly code,
meaning we have to store its physical and virtual addresses in the arch header.
This means patch 11 from v5 is no longer needed.

The last patch that prevents resume with a different kernel version has been
changed to use UTS_VERSION, meaning it has to be the same build of the kernel.


This series can be retrieved from:
git://linux-arm.org/linux-jm.git -b hibernate/v6


Changes since v5:
 * Call el2_setup() from hibernate's assembly code
 * Use UTS_VERSION to catch hibernate/resume with different builds

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

[v5] http://www.spinics.net/lists/arm-kernel/msg483595.html
[v4] http://www.spinics.net/lists/arm-kernel/msg477769.html
[v3] http://www.spinics.net/lists/arm-kernel/msg463590.html
[v2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376450.html
[v1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376450.html


AKASHI Takahiro (1):
  arm64: kvm: allows kvm cpu hotplug

Geoff Levand (5):
  arm64: Fold proc-macros.S into assembler.h
  arm64: Cleanup SCTLR flags
  arm64: Convert hcalls to use HVC immediate value
  arm64: Add new hcall HVC_CALL_FUNC
  arm64: Add new asm macro copy_page

James Morse (8):
  arm64: kernel: Rework finisher callback out of __cpu_suspend_enter().
  arm64: Change cpu_resume() to enable mmu early then access sleep_sp by
    va
  arm64: kernel: Include _AC definition in page.h
  arm64: Promote KERNEL_START/KERNEL_END definitions to a header file
  arm64: head.S: el2_setup() to accept sctlr_el1 as an argument
  PM / Hibernate: Call flush_icache_range() on pages restored in-place
  arm64: kernel: Add support for hibernate/suspend-to-disk
  arm64: hibernate: Prevent resume from a different kernel version

 arch/arm/include/asm/kvm_host.h    |  10 +-
 arch/arm/include/asm/kvm_mmu.h     |   1 +
 arch/arm/kvm/arm.c                 |  98 +++++---
 arch/arm/kvm/mmu.c                 |   5 +
 arch/arm64/Kconfig                 |   7 +
 arch/arm64/include/asm/assembler.h | 111 ++++++++-
 arch/arm64/include/asm/kvm_arm.h   |  11 -
 arch/arm64/include/asm/kvm_host.h  |   1 -
 arch/arm64/include/asm/kvm_mmu.h   |  20 ++
 arch/arm64/include/asm/memory.h    |   3 +
 arch/arm64/include/asm/page.h      |   2 +
 arch/arm64/include/asm/suspend.h   |  32 ++-
 arch/arm64/include/asm/sysreg.h    |  19 +-
 arch/arm64/include/asm/virt.h      |  40 ++++
 arch/arm64/kernel/Makefile         |   1 +
 arch/arm64/kernel/asm-offsets.c    |  10 +-
 arch/arm64/kernel/head.S           |  24 +-
 arch/arm64/kernel/hibernate-asm.S  | 166 +++++++++++++
 arch/arm64/kernel/hibernate.c      | 478 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/hyp-stub.S       |  49 ++--
 arch/arm64/kernel/setup.c          |   1 -
 arch/arm64/kernel/sleep.S          | 146 ++++-------
 arch/arm64/kernel/suspend.c        |  96 ++++----
 arch/arm64/kernel/vmlinux.lds.S    |  15 ++
 arch/arm64/kvm/hyp-init.S          |  47 +++-
 arch/arm64/kvm/hyp.S               |   3 +-
 arch/arm64/kvm/hyp/hyp-entry.S     |   9 +-
 arch/arm64/mm/cache.S              |   2 -
 arch/arm64/mm/proc-macros.S        |  98 --------
 arch/arm64/mm/proc.S               |  56 ++---
 kernel/power/swap.c                |  18 ++
 31 files changed, 1203 insertions(+), 376 deletions(-)
 create mode 100644 arch/arm64/kernel/hibernate-asm.S
 create mode 100644 arch/arm64/kernel/hibernate.c
 delete mode 100644 arch/arm64/mm/proc-macros.S

-- 
2.7.0

