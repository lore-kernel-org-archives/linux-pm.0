From: Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH 00/10] MIPS CPC fixup and CPU Idle for MIPSr6 CPUs
Date: Wed, 31 Aug 2016 11:44:29 +0100
Message-ID: <1472640279-26593-1-git-send-email-matt.redfearn@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, Matt Redfearn <matt.redfearn@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, Tony Wu <tung7970@gmail.com>, Nikolay Martynov <mar.kolya@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org, Qais Yousef <qsyousef@gmail.com>, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, James Hogan <james.hogan@imgtec.com>, Andrew Morton <akpm@linux-foundation.org>, Markos Chandras <markos.chandras@imgtec.com>, Adam Buchbinder <adam.buchbinder@gmail.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Paul Burton <paul.burton@imgtec.com>, Daniel Lezcano <daniel.lezcano@li>
List-Id: linux-pm@vger.kernel.org


This series fixes a small issue with the CPC driver when A CM3 is
present, where a redundant lock was taken.

There are then additions to the pm-cps driver to add support for R6 CPUs
such as the I6400, and additionally the CM3 present in the I6400.

Finally we enable the cpuidle-cps driver for MIPSr6 CPUs.

Applies atop v4.8-rc4



Matt Redfearn (10):
  MIPS: CPC: Convert bare 'unsigned' to 'unsigned int'
  MIPS: CPC: Avoid lock when MIPS CM >= 3 is present
  MIPS: pm-cps: Change FSB workaround to CPU blacklist
  MIPS: pm-cps: Remove I6400 sync types
  MIPS: pm-cps: Add P6600 implementation lightweight sync types
  MIPS: pm-cps: Use MIPS standard lightweight ordering barrier
  MIPS: pm-cps: Add MIPSr6 CPU support
  MIPS: pm-cps: Support CM3 changes to Coherence Enable Register
  MIPS: SMP: Wrap call to mips_cpc_lock_other in mips_cm_lock_other
  cpuidle: cpuidle-cps: Enable use with MIPSr6 CPUs.

 arch/mips/include/asm/barrier.h | 10 ++++++
 arch/mips/include/asm/mips-cm.h |  1 +
 arch/mips/include/asm/pm-cps.h  |  6 ++--
 arch/mips/kernel/mips-cpc.c     | 17 +++++++++--
 arch/mips/kernel/pm-cps.c       | 67 ++++++++++++++++++++++++-----------------
 arch/mips/kernel/smp.c          |  2 ++
 drivers/cpuidle/Kconfig.mips    |  2 +-
 drivers/cpuidle/cpuidle-cps.c   |  2 +-
 8 files changed, 73 insertions(+), 34 deletions(-)

-- 
2.7.4
