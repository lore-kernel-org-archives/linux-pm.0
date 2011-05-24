From: Frank Hofmann <frank.hofmann@tomtom.com>
Subject: [RFC] ARM hibernation, cpu-type-specific code
Date: Tue, 24 May 2011 14:27:05 +0100 (BST)
Message-ID: <alpine.DEB.2.00.1105241335170.10891@localhost6.localdomain6>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
	<20110520113758.GA3141@arm.com>
Reply-To: frank.hofmann@tomtom.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110520113758.GA3141@arm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net
List-Id: linux-pm@vger.kernel.org

Hi,


Regarding ARM hibernation / suspend-to-disk, now that the glue part of the 
code has "settled" it's probably time to think about the gory low-level 
things, what's been delegated to the __save/__restore_processor_state() 
hooks.


Russell King did the cpu_suspend / cpu_resume cleanup in Feb/2011,

 	http://lists.arm.linux.org.uk/lurker/message/20110211.161754.78371a42.en.html

which cleansed the mach-.../ sleep code in favour of moving these things 
into processor type support hooks in arch/arm/mm/proc-*.S instead.


The key thing here was the addition of cpu_do_suspend/cpu_do_resume hooks 
which save/restore state to/from a caller-supplied buffer, and then return 
to their callers. I.e. pure auxilliary, "no side effects" (other than, for 
resume, of course, what's desired).
The power-down / enter-low-power parts were separated from that.


>From my point of view, all platforms that use these should be able to do 
the cpu-specific parts of hibernation via a simple addition, say, to 
arch/arm/kernel/sleep.S (that's already using <asm/glue-proc.h> so 
cpu_do_... exists), of something like:


#if defined(CONFIG_HAS_ARM_GENERIC_CPU_SUSPEND_SUPPORT) && defined(CONFIG_HIBERNATION)
ENTRY(__save_processor_state)
 	b	cpu_do_suspend
ENDPROC(__save_processor_state)

ENTRY(__restore_processor_state)
 	stmfd	sp!,{r4-r11,lr}
 	bl	cpu_do_resume
 	ldmfd	sp!,{r4-r11,pc}
ENDPROC(__restore_processor_state)
#endif


and "select HAS_ARM_GENERIC_CPU_SUSPEND_SUPPORT if CONFIG_PM" for the CPU 
architectures that compile suitable mm/proc-*.S in.


That would do because the cpu_do_suspend/resume hooks perform the same CP 
reg save/restore operations as the "illustration patches" I've posted for 
OMAP3 and samsung 64xx (in fact, the latter is one of the platforms 
changed via Russell's patch series).



>From my point of view, this assumes the following:

- cpu_do_suspend() takes one argument, a virtual address of the buffer to
   save the state into. It is a "well-behaved" EABI-compliant func that
   preserves nonvolatile regs.
   It returns to LR.

- cpu_do_resume() assumes it can clobber registers; it takes one argument,
   the address (not necessarily virtual) of the buffer to restore state
   from.
   The function does not depend on the MMU being OFF (could be called with
   the MMU on, it'll "just clobber the state").
   It also returns to LR.

Do these assumptions hold ?


If so, then would it be ok to create a patch for 2.6.39 onwards (baselined 
against ARM devel-stable), along the lines just mentioned ?


How would one best test something as sweeping as that ?


The above suggestion still leaves a hole out for machine-specific 
implementations - unselect the GENERIC config and implement the hook 
yourself. Seems desireable ?


Regarding pre-2.6.38 kernels, are there any plans to backport the 
cpu_suspend changes to any -stable series ?



Thanks in advance for comments / suggestions / corrections,
FrankH.
