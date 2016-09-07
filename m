From: Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH v2 00/12] MIPS CPC fixup and CPU Idle for MIPSr6 CPUs
Date: Wed, 7 Sep 2016 10:45:08 +0100
Message-ID: <1473241520-14917-1-git-send-email-matt.redfearn@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:59477 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbcIGJph (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Sep 2016 05:45:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, Matt Redfearn <matt.redfearn@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, Tony Wu <tung7970@gmail.com>, Nikolay Martynov <mar.kolya@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org, Qais Yousef <qsyousef@gmail.com>, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, James Hogan <james.hogan@imgtec.com>, Andrew Morton <akpm@linux-foundation.org>, Markos Chandras <markos.chandras@imgtec.com>, Adam Buchbinder <adam.buchbinder@gmail.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Paul Burton <paul.burton@imgtec.com>, Daniel Lezcano <daniel.lezcano@li>


This updated series incorporates comments from Peter Zijlstra on v1
around the barriers in pm-cps.c.

This series fixes a small issue with the CPC driver when A CM3 is
present, where a redundant lock was taken.

There are then additions to the pm-cps driver to add support for R6 CPUs
such as the I6400, and additionally the CM3 present in the I6400.

Finally we enable the cpuidle-cps driver for MIPSr6 CPUs.

Applies atop v4.8-rc4


Changes in v2:
Update comments on barriers
Add new patch to define standard MIPS barrier types
Use architecturally standard lightweight sync types rather than
selecting CPU specific ones.

Matt Redfearn (12):
  MIPS: CPC: Convert bare 'unsigned' to 'unsigned int'
  MIPS: CPC: Avoid lock when MIPS CM >= 3 is present
  MIPS: pm-cps: Change FSB workaround to CPU blacklist
  MIPS: pm-cps: Update comments on barrier instructions
  MIPS: Barrier: Add definitions of SYNC stype values
  MIPS: pm-cps: Use MIPS standard lightweight ordering barrier
  MIPS: pm-cps: Use MIPS standard completion barrier
  MIPS: pm-cps: Remove selection of sync types
  MIPS: pm-cps: Add MIPSr6 CPU support
  MIPS: pm-cps: Support CM3 changes to Coherence Enable Register
  MIPS: SMP: Wrap call to mips_cpc_lock_other in mips_cm_lock_other
  cpuidle: cpuidle-cps: Enable use with MIPSr6 CPUs.

 arch/mips/include/asm/barrier.h |  96 +++++++++++++++++++++++++++++++++
 arch/mips/include/asm/mips-cm.h |   1 +
 arch/mips/include/asm/pm-cps.h  |   6 ++-
 arch/mips/kernel/mips-cpc.c     |  17 ++++--
 arch/mips/kernel/pm-cps.c       | 115 +++++++++++++++++++---------------------
 arch/mips/kernel/smp.c          |   2 +
 drivers/cpuidle/Kconfig.mips    |   2 +-
 drivers/cpuidle/cpuidle-cps.c   |   2 +-
 8 files changed, 173 insertions(+), 68 deletions(-)

-- 
2.7.4

