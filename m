From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/2] combine remote cpu msr access
Date: Fri, 11 Dec 2015 14:40:35 -0800
Message-ID: <1449873637-24300-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28346 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199AbbLKWlr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 11 Dec 2015 17:41:47 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, X86 Kernel <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

IPI calls to access MSRs on remote CPUs are expensive. So add a lib call
for read/modify/write access and use it in Intel RAPL driver.

Jacob Pan (2):
  x86/msr: add on cpu read/modify/write function
  powercap/rapl: reduce ipi calls

 arch/x86/include/asm/msr.h    | 24 +++++++++++++++
 arch/x86/lib/msr-smp.c        | 47 ++++++++++++++++++++++++++++
 drivers/powercap/intel_rapl.c | 71 ++++++++++++++++++++++---------------------
 3 files changed, 108 insertions(+), 34 deletions(-)

-- 
1.9.1

