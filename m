From: Frank Hofmann <frank.hofmann@tomtom.com>
Subject: [RFC PATCH v5] ARM hibernation / suspend-to-disk
Date: Mon, 13 Jun 2011 12:59:42 +0100 (BST)
Message-ID: <alpine.DEB.2.00.1106131151550.25153__13744.038649793$1307966546$gmane$org@localhost6.localdomain6>
Reply-To: frank.hofmann@tomtom.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.or
List-Id: linux-pm@vger.kernel.org

Hi,

to make one thing clear to start with:

This is not a proposal to integrate the hibernation feature into mainline.

It's not ripe for that because it's unclear what exactly the differences 
are between what the hibernation / S2RAM codepaths have to do, and/or how 
much code sharing between these codepaths is advisable.


Therefore, I'm merely putting this out as-is as a reference / base for 
those who want to do their own experiments with the feature.

Prerequisites:

* The patch requires a working cpu_reset(); for v6/v7, that's in Will
   Deacon's patch series from last week.

* It also requires being able to take the address of cpu_reset and
   on MULTI_CPU configs therefore, again see Will Deacon's patch series.

* It uses on cpu_suspend() / cpu_resume(), therefore a recent-enough
   kernel (or a port of those to whatever you're using) is required.


Important / Limitations:

A) For platforms that currently use cpu_suspend/cpu_resume in their s2ram
   codepaths AND DO NOTHING ELSE BEFORE AND NOTHING ELSE AFTER THAT BUT TO
   "ENTER LOW POWER", the way the hibernation state snapshot for the CPU
   core is done by this patch is sufficient.

   To make it clear: IF AND ONLY IF your suspend(-to-ram) func looks like:

 	ENTRY(acmeSoC_cpu_suspend)
 		stmfd	sp!, {r4-r12,lr}
 		ldr	r3, resume_mmu_done
 		bl	cpu_suspend
 	resume_mmu_done:
 		ldmfd	sp!, {r3-r12,pc}
 	ENDPROC(acmeSoC_cpu_suspend)

   then this patch is ok to provide hibernation support for your CPU core.

   In all other cases, item B).

   IN ALL CASES, read item C) below; there's more than the core to the SoC.

B) If there's any cpu-specific / SoC-specific state that needs (re)init
   over a suspend-to-disk/resume-from-disk cycle, this patch is incomplete
   because it provides no hooks/code for that.

   This is the case e.g. for "secure" SoCs that have different sets of
   control registers and/or different CR reg access patterns.

   It's also the case e.g. for SoCs with L2 caches as the activation
   sequence there is SoC-dependent; a full off-on cycle for L2 is not done
   by the hibernation support code.

   It's also the case if the SoC requires steps on wakeup _before_ the
   "generic" parts done by cpu_suspend / cpu_resume can work correctly.

   (OMAP is an example of such a SoC; the patch "works" on OMAP in the
   sense that it gets you a non-secure OMAP back from hibernation but as
   mentioned, your mileage may vary; I for example don't know what the
   consequences  of not disabling / reenabling the L2 cache over cpu_reset
   are)

C) The current low-power handling may perform SoC-specific tasks such
   as GPIO state handling, which is currently also not addressed by this
   patch; the assumption is rather that device suspend/resume deals with
   this. That is not guaranteed to be complete / sufficient - if your SoC
   and/or your device drivers have particular needs in this area, you can
   put hooks performing these actions into save_/restore_processor_state().

D) If you wish to extend this to a SoC for which the generic CPU core
   hooks (i.e. what cpu_suspend/resume provide) are either insufficient
   or unavailable, hook your own state snapshot mechanism into the places
   where this code currently calls cpu_suspend and cpu_resume. The main
   assumption by the assembly code within swusp_arch_resume() is that
   __swsusp_arch_restore_image() returns to its caller with the stack
   restored - how you achieve that is up to you, the patch as-is does it
   by cpu_reset(cpu_resume) but your mileage may vary.


I will, at this point, not send further iterations of this patch.

I'll answer questions about it though, if there are any.


Thanks for all the comments during the previous threads - learned a lot !


Best regards,
FrankH.
