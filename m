From: James Morse <james.morse@arm.com>
Subject: [PATCH v3 00/10] arm64: kernel: Add support for hibernate/suspend-to-disk
Date: Thu, 26 Nov 2015 17:32:38 +0000
Message-ID: <1448559168-8363-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46212 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbbKZRdr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 26 Nov 2015 12:33:47 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

Hi all,

v2's "clean cached pages on architectures that require it" is wrong.
do_copy_page() isn't used on the resume path for pages restored 'in place'.
There is nowhere we can add the call to flush_icache_range(), instead
patch 9 of this series adds a new 'pbe' list of pages restored in place.
Architectures that need to clean these before they can be executed can walk
this list. This preserves the status-quo a little better, as existing
architectures won't get flush_icache_range() called on these pages.

The first four patches are borrowed from kexec v12, and are used to return
el2 to the hyp stub, as its stack/vectors may be overwritten.

Patches 5 and 6 provide some cleanup to the cpu_suspend() API:
* allowing it to be used with a 'finisher' that needs to return success,
* and turn the MMU on early to allow sleep_save_sp to be accessed by VA.

The last patch adds hibernate support, following the x86 approach, it creates
a temporary set of page tables and copies the hibernate_exit code. The
implementation requires that exactly the same kernel is booted on the
same hardware, and that the kernel is loaded at the same physical address.

This series is based on v4.4-rc2, and can be pulled from:
git://linux-arm.org/linux-jm.git -b hibernate/v3

Changes from v2:
 * Rewrote patch 9 - we can't clean pages in copy_page(), we need to publish
   a list for the architecture to clean
 * Updated patch 10 following rewritten patch 9
 * Added missing pgprot_val() in hibernate.c, spotted by STRICT_MM_TYPECHECKS
 * Removed 'tcr_set_idmap_t0sz' from proc.S - I missed this when rebase-ing
 * Re-imported the first four patches from kexec v12
 * Rebased onto v4.4-rc2
 * Changes from Pavel Machek's comments

Changes from v1:
 * Removed for_each_process(){ for_each_vma() { } }; cache cleaning, replaced
   with icache_flush_range() call in core hibernate code
 * Rebased onto conflicting tcr_ek1.t0sz bug-fix patch

[v2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376450.html
[v1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376450.html


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
  PM / Hibernate: Publish pages restored in-place to arch code
  arm64: kernel: Add support for hibernate/suspend-to-disk.

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
 arch/arm64/include/asm/suspend.h   |  31 ++-
 arch/arm64/include/asm/virt.h      |  49 +++++
 arch/arm64/kernel/Makefile         |   1 +
 arch/arm64/kernel/asm-offsets.c    |   9 +-
 arch/arm64/kernel/head.S           |   5 +-
 arch/arm64/kernel/hibernate-asm.S  | 119 ++++++++++++
 arch/arm64/kernel/hibernate.c      | 376 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/hyp-stub.S       |  43 +++--
 arch/arm64/kernel/setup.c          |   1 -
 arch/arm64/kernel/sleep.S          | 148 +++++----------
 arch/arm64/kernel/suspend.c        | 103 ++++------
 arch/arm64/kernel/vmlinux.lds.S    |  15 ++
 arch/arm64/kvm/hyp-init.S          |  34 +++-
 arch/arm64/kvm/hyp.S               |  44 ++++-
 arch/arm64/mm/cache.S              |   2 -
 arch/arm64/mm/proc-macros.S        |  64 -------
 arch/arm64/mm/proc.S               |  31 +--
 include/linux/suspend.h            |   1 +
 kernel/power/snapshot.c            |  42 +++--
 29 files changed, 943 insertions(+), 343 deletions(-)
 create mode 100644 arch/arm64/kernel/hibernate-asm.S
 create mode 100644 arch/arm64/kernel/hibernate.c
 delete mode 100644 arch/arm64/mm/proc-macros.S

-- 
2.6.2

