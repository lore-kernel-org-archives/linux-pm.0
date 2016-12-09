From: "Gautham R. Shenoy" <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 1/4] powernv:idle: Add IDLE_STATE_ENTER_SEQ_NORET macro
Date: Fri,  9 Dec 2016 19:02:00 +0530
Message-ID: <0947ced2f87c68a0a10ede8e1aaf39838a6f8d52.1481288905.git.ego@linux.vnet.ibm.com>
References: <cover.1481288905.git.ego@linux.vnet.ibm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1481288905.git.ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
In-Reply-To: <cover.1481288905.git.ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
References: <cover.1481288905.git.ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Neuling <mikey-/owAOxkjmzZAfugRpC6u6w@public.gmane.org>, Vaidyanathan Srinivasan <svaidy-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "Shreyas B. Prabhu" <shreyasbp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shilpasri G Bhat <shilpa.bhat-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Stewart Smith <stewart-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oliver O'Halloran <oohall-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Gautham R. Shenoy" <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: "Gautham R. Shenoy" <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>

Currently all the low-power idle states are expected to wake up
at reset vector 0x100. Which is why the macro IDLE_STATE_ENTER_SEQ
that puts the CPU to an idle state and never returns.

On ISA_300, when the ESL and EC bits in the PSSCR are zero, the
CPU is expected to wake up at the next instruction of the idle
instruction.

This patch adds a new macro named IDLE_STATE_ENTER_SEQ_NORET for the
no-return variant and reuses the name IDLE_STATE_ENTER_SEQ
for a variant that allows resuming operation at the instruction next
to the idle-instruction.

Signed-off-by: Gautham R. Shenoy <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
---
 arch/powerpc/include/asm/cpuidle.h   |  5 ++++-
 arch/powerpc/kernel/exceptions-64s.S |  6 +++---
 arch/powerpc/kernel/idle_book3s.S    | 10 +++++-----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 3919332..0a3255b 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -21,7 +21,7 @@
 
 /* Idle state entry routines */
 #ifdef	CONFIG_PPC_P7_NAP
-#define	IDLE_STATE_ENTER_SEQ(IDLE_INST)				\
+#define IDLE_STATE_ENTER_SEQ(IDLE_INST)                         \
 	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
 	std	r0,0(r1);					\
 	ptesync;						\
@@ -29,6 +29,9 @@
 1:	cmpd	cr0,r0,r0;					\
 	bne	1b;						\
 	IDLE_INST;						\
+
+#define	IDLE_STATE_ENTER_SEQ_NORET(IDLE_INST)			\
+	IDLE_STATE_ENTER_SEQ(IDLE_INST)                         \
 	b	.
 #endif /* CONFIG_PPC_P7_NAP */
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 1ba82ea..7aa8afc 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -381,12 +381,12 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
 	lbz	r3,PACA_THREAD_IDLE_STATE(r13)
 	cmpwi	r3,PNV_THREAD_NAP
 	bgt	10f
-	IDLE_STATE_ENTER_SEQ(PPC_NAP)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_NAP)
 	/* No return */
 10:
 	cmpwi	r3,PNV_THREAD_SLEEP
 	bgt	2f
-	IDLE_STATE_ENTER_SEQ(PPC_SLEEP)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_SLEEP)
 	/* No return */
 
 2:
@@ -400,7 +400,7 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
 	 */
 	ori	r13,r13,1
 	SET_PACA(r13)
-	IDLE_STATE_ENTER_SEQ(PPC_WINKLE)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_WINKLE)
 	/* No return */
 4:
 #endif
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 72dac0b..be90e2f 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -205,7 +205,7 @@ pnv_enter_arch207_idle_mode:
 	stb	r3,PACA_THREAD_IDLE_STATE(r13)
 	cmpwi	cr3,r3,PNV_THREAD_SLEEP
 	bge	cr3,2f
-	IDLE_STATE_ENTER_SEQ(PPC_NAP)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_NAP)
 	/* No return */
 2:
 	/* Sleep or winkle */
@@ -239,7 +239,7 @@ pnv_fastsleep_workaround_at_entry:
 
 common_enter: /* common code for all the threads entering sleep or winkle */
 	bgt	cr3,enter_winkle
-	IDLE_STATE_ENTER_SEQ(PPC_SLEEP)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_SLEEP)
 
 fastsleep_workaround_at_entry:
 	ori	r15,r15,PNV_CORE_IDLE_LOCK_BIT
@@ -261,7 +261,7 @@ fastsleep_workaround_at_entry:
 enter_winkle:
 	bl	save_sprs_to_stack
 
-	IDLE_STATE_ENTER_SEQ(PPC_WINKLE)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_WINKLE)
 
 /*
  * r3 - requested stop state
@@ -280,7 +280,7 @@ power_enter_stop:
 	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
 	cmpd	r3,r4
 	bge	2f
-	IDLE_STATE_ENTER_SEQ(PPC_STOP)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_STOP)
 2:
 /*
  * Entering deep idle state.
@@ -302,7 +302,7 @@ lwarx_loop_stop:
 
 	bl	save_sprs_to_stack
 
-	IDLE_STATE_ENTER_SEQ(PPC_STOP)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_STOP)
 
 _GLOBAL(power7_idle)
 	/* Now check if user or arch enabled NAP mode */
-- 
1.9.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
