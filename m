From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: [PATCH 0/7] cpuidle/powernv: Enable Fast-Sleep on PowerNV
Date: Wed, 26 Feb 2014 05:37:15 +0530
Message-ID: <20140226000310.17879.67295.stgit@preeti>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:34889 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785AbaBZALG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 25 Feb 2014 19:11:06 -0500
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Tue, 25 Feb 2014 19:11:05 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 0F9F3C90041
	for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2014 19:10:59 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s1Q0B2HE5177832
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2014 00:11:02 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s1Q0B0c9021580
	for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2014 19:11:02 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, geoff@infradead.org, fweisbec@gmail.com, daniel.lezcano@linaro.org, srivatsa.bhat@linux.vnet.ibm.com, benh@kernel.crashing.org, tglx@linutronix.de, svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Cc: paulmck@linux.vnet.ibm.com, rafael.j.wysocki@intel.com

This series is based on tip/timers/core ontop of commit
849401b66d305:tick: Fixup more fallout from hrtimer broadcast mode.

Fast sleep is one of the deep idle states on Power8 in which local timers of
CPUs stop. On PowerPC we do not have an external clock device which can
handle wakeup of such CPUs. Now that we have the support in the tick
broadcast framework for archs that do not sport such a device soon to go
upstream, add fast sleep as one of the idle states on PowerNV along with
related arch specific support.

The earlier versions of this patchset included support in the tick broadcast
framework for such idle states. Now that the support in the broadcast
framework has been pulled into tip separately, this series is posted
independently and as a new patchset altogether. This series depends in
particular on the following commits in tip/timers/core:

1.da7e6f45c3:time: Change the return type of clockevents_notify() to integer
2.ba8f20c2eb:cpuidle: Handle clockevents_notify(BROADCAST_ENTER) failure
3.5d1638acb9f62fa:tick: Introduce hrtimer based broadcast
4.f1689bb7abec8e2e6:time: Fixup fallout from recent clockevent/tick changes
5.849401b66d305f3feb75:Fixup more fallout from hrtimer broadcast mode

---

Preeti U Murthy (3):
      cpuidle/ppc: Split timer_interrupt() into timer handling and interrupt handling routines
      cpuidle/powernv: Add "Fast-Sleep" CPU idle state
      cpuidle/powernv: Parse device tree to setup idle states

Srivatsa S. Bhat (2):
      powerpc: Free up the slot of PPC_MSG_CALL_FUNC_SINGLE IPI message
      powerpc: Implement tick broadcast IPI as a fixed IPI message

Vaidyanathan Srinivasan (2):
      powernv/cpuidle: Add context management for Fast Sleep
      powermgt: Add OPAL call to resync timebase on wakeup


 arch/powerpc/Kconfig                           |    2 
 arch/powerpc/include/asm/opal.h                |    2 
 arch/powerpc/include/asm/processor.h           |    1 
 arch/powerpc/include/asm/smp.h                 |    2 
 arch/powerpc/include/asm/time.h                |    1 
 arch/powerpc/kernel/exceptions-64s.S           |   10 ++
 arch/powerpc/kernel/idle_power7.S              |   90 +++++++++++++++++----
 arch/powerpc/kernel/smp.c                      |   25 ++++--
 arch/powerpc/kernel/time.c                     |   90 +++++++++++++--------
 arch/powerpc/platforms/cell/interrupt.c        |    2 
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 
 arch/powerpc/platforms/ps3/smp.c               |    2 
 drivers/cpuidle/cpuidle-powernv.c              |  102 ++++++++++++++++++++++--
 13 files changed, 253 insertions(+), 77 deletions(-)

-- 
Signature

