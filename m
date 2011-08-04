From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] idle patches for Linux 3.1
Date: Thu, 04 Aug 2011 15:57:07 -0700
Message-ID: <87bow423b0.fsf__36320.720302365$1312498714$gmane$org@ti.com>
References: <alpine.LFD.2.02.1108031627060.19398@x980>
	<CA+55aFxikiro4cEwGEOMCGUswyPsaAwyspP1cFUviJ5OUKOZJw@mail.gmail.com>
	<alpine.LFD.2.02.1108040030550.29492@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1108040030550.29492@x980> (Len Brown's message
	of "Thu, 04 Aug 2011 01:03:40 -0400 (EDT)")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Len Brown <lenb@kernel.org> writes:

> and I'm here to support them if anything goes wrong.

Here's your first opportuntity for support. :)

I see Linus has already pulled this, but it doesn't compile on ARM or
SH as I just found out, and Trinabh poined out in reply to patch 5/5.

Here's a fix.

Kevin

>From f8c825215f824b01a3f33416198def2fd685c7cf Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Thu, 4 Aug 2011 15:49:51 -0700
Subject: [PATCH] cpuidle: ARM/SH: fix use of cpuidle_idle_call()

commit a0bfa1373859e9d11dc92561a8667588803e42d8 (cpuidle: stop
depending on pm_idle) introduced a call to cpuidle_call_idle() in the
ARM and SH idle paths, but this function doesn't exist.  Use
cpuidle_idle_call()

Reported-by: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/kernel/process.c |    2 +-
 arch/sh/kernel/idle.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index d7ee0d4..1a347f4 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -197,7 +197,7 @@ void cpu_idle(void)
 				cpu_relax();
 			} else {
 				stop_critical_timings();
-				if (cpuidle_call_idle())
+				if (cpuidle_idle_call())
 					pm_idle();
 				start_critical_timings();
 				/*
diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
index 3c45de1..32114e0 100644
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -101,7 +101,7 @@ void cpu_idle(void)
 			local_irq_disable();
 			/* Don't trace irqs off for idle */
 			stop_critical_timings();
-			if (cpuidle_call_idle())
+			if (cpuidle_idle_call())
 				pm_idle();
 			/*
 			 * Sanity check to ensure that pm_idle() returns
-- 
1.7.6
