From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: [PATCH v8 0/2] hibernation support on ARM
Date: Tue, 11 Mar 2014 11:40:12 -0700
Message-ID: <1394563214-26007-1-git-send-email-sebastian.capella@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


Patches adding support for hibernation on ARM
 - ARM hibernation / suspend-to-disk
 - Change soft_restart to use non-tracing raw_local_irq_disable

Patches based on v3.14-rc5 tag, verified hibernation on beaglebone black on a
branch based on 3.13 merged with initial omap support from Russ Dill which
can be found here (includes v1 patchset):
http://git.linaro.org/git-ro/people/sebastian.capella/linux.git hibernation_3.13_russMerge

[PATCH v8 1/2] ARM: avoid tracers in soft_restart
 arch/arm/kernel/process.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

 Use raw_local_irq_disable in place of local_irq_disable to avoid
 infinite abort recursion while tracing. (unchanged since v3)

[PATCH v8 2/2] ARM hibernation / suspend-to-disk
 arch/arm/kernel/Makefile    |    1 +
 arch/arm/kernel/hibernate.c |  107 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig         |    5 ++
 include/linux/suspend.h     |    2 +
 4 files changed, 115 insertions(+)

 Adds support for ARM based hibernation


Additional notes:
-----------------

There are two checkpatch warnings added by this patch.  These follow
behavior in existing hibernation implementations on other platforms.


    WARNING: externs should be avoided in .c files
    #108: FILE: arch/arm/kernel/hibernate.c:25:
    +extern const void __nosave_begin, __nosave_end;

  This extern is picking up the linker nosave region definitions, only
  used in hibernate.  Follows same extern line used mips, powerpc, s390,
  sh, sparc, x86 & unicore32

    WARNING: externs should be avoided in .c files
    #186: FILE: arch/arm/kernel/hibernate.c:103:
    +   extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);

  This extern is used in the arch/arm/ in hibernate, process and bL_switcher


Changes in v8:
--------------
* remove definition and use of __pa_symbol

Changes in v7:
--------------
* remove use of RELOC_HIDE macro
* remove unused #includes
* fixup comment for arch_restore_image
* ensure alignment of resume stack on 8 byte boundary

Changes in v6:
--------------
* Simplify static variable names

Changes in v5:
--------------
* Fixed checkpatch warning on trailing whitespace

Changes in v4:
--------------
* updated comment for soft_restart with review feedback
* dropped freeze_processes patch which was queued separately
  to 3.14 by Rafael Wysocki:
  https://lkml.org/lkml/2014/2/25/683

Changes in v3:
--------------
* added comment to use of soft_restart
* drop irq disable soft_restart patch
* add patch to avoid tracers in soft_restart by using raw_local_irq_*

Changes in v2:
--------------
* Removed unneeded flush_thread, use of __naked and cpu_init.
* dropped Cyril Chemparathy <cyril@ti.com> from Cc: list as
  emails are bouncing.

Thanks,

Sebastian Capella
