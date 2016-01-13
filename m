From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 0/2] Reduce IPI calls for remote msr access
Date: Tue, 12 Jan 2016 17:11:21 -0800
Message-ID: <1452647483-14244-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

IPI calls to access MSRs on remote CPUs are expensive. So add a lib call
for read/modify/write access and use it in Intel RAPL driver.

Changes since v1:
	(based on feedback from Thomas Gleixner)
	- remove duplicated !CONFIG_SMP code
	- rename variables
	- added a check for local CPU before searching for active CPU oni
	  the package

Jacob Pan (2):
  x86/msr: add on cpu read/modify/write function
  powercap/rapl: reduce ipi calls

 arch/x86/include/asm/msr.h    | 13 ++++++++
 arch/x86/lib/msr-smp.c        | 34 +++++++++++++++++++
 arch/x86/lib/msr.c            | 18 ++++++++++
 drivers/powercap/intel_rapl.c | 77 +++++++++++++++++++++++--------------------
 4 files changed, 107 insertions(+), 35 deletions(-)

-- 
1.9.1
