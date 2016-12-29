From: Mason <slash.tmp@free.fr>
Subject: Re: Linux fails to start secondary cores when system resumes from
 Suspend-to-RAM
Date: Thu, 29 Dec 2016 13:10:27 +0100
Message-ID: <9134f2dd-73f6-73d5-30a0-3129d5440d0a@free.fr>
References: <d4db03ce-80fc-2968-c5c2-84f79272ce8d@free.fr>
 <CADjb_WQ8ZTtcXYQ_3iobLCW7+rnG8FqyFQ1E47AZVGxP0JyB0w@mail.gmail.com>
 <8c3c6592-1e9a-10d3-2a89-c22a2a23cf4b@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:26648 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752563AbcL2MLR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Dec 2016 07:11:17 -0500
In-Reply-To: <8c3c6592-1e9a-10d3-2a89-c22a2a23cf4b@free.fr>
Content-Language: 
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm <linux-pm@vger.kernel.org>
Cc: Yu Chen <yu.chen.surf@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Sebastian Frias <sf84@laposte.net>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Thomas Gambier <thomas_gambier@sigmadesigns.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kevin Hilman <khilman@kernel.org>, Mark Brown <broonie@kernel.org>

On 16/12/2016 08:25, Mason wrote:

> On 16/12/2016 06:14, Yu Chen wrote:
> 
>> On Thu, Dec 15, 2016 at 11:18 PM, Mason wrote:
>>
>>> I'm playing with suspend-to-RAM on the tango platform:
>>>
>>>   http://lxr.free-electrons.com/source/arch/arm/mach-tango/platsmp.c
>>>
>>> When the system is suspended, the CPU is completely powered down
>>> (receives no power whatsoever). When the system receives a wake-up
>>> event, the CPU is powered up, and starts up exactly the same way
>>> as for a cold boot (I think).
>>>
>>> However, while Linux successfully starts the secondary cores when
>>> the system first boots, it fails when the system resumes from "S3".
>>>
>>> I added printascii() calls inside secondary_start_kernel() and I can
>>> see that the following instruction are "properly" run:
>>>
>>>         cpu_switch_mm(mm->pgd, mm);
>>>         local_flush_bp_all();
>>>         enter_lazy_tlb(mm, current);
>>>
>>> but it seems local_flush_tlb_all(); never returns... :-(
>>>
>>>   http://lxr.free-electrons.com/source/arch/arm/include/asm/tlbflush.h#L332
>>>
>>>
>>> Looking more closely at that function, it seems to be failing in:
>>>
>>>         tlb_op(TLB_V7_UIS_FULL, "c8, c7, 0", zero);
>>>
>>> (meaning: I get a log before, but not after)
>>>
>>> On my system, tlb_op(TLB_V7_UIS_FULL, "c8, c7, 0", zero);
>>> resolves to:
>>>
>>> c010ce18:       e3170602        tst     r7, #2097152    ; 0x200000
>>> c010ce1c:       1e086f17        mcrne   15, 0, r6, cr8, cr7, {0}
>>>
>>> What could be happening?
>>> Can a core "hang" on this instruction?
>>> Can a core "crash" on this instruction (meaning, an exception
>>> is raised, and the core loops inside the exception code without
>>> Linux noticing... that seems unlikely)
>>
>> try online/offline the nonboot CPUs via
>> /sys/devices/system/cpu/cpuX/online
> 
> offline + online secondary core works.
> 
> Note: all cores are in the same power domain, so even if all
> secondary cores are offline, the CPU block remains powered up
> (secondary cores are just held in reset, or spinning in WFI,
> depending on the firmware version).
> 
> When the system is suspended, the CPU block (as well as 99%
> of the system) is powered down. Thus, upon resume, all cores
> will run the boot sequence (again).
> 
> I'm guessing that something goes wrong during this second
> boot sequence. Could there be a race condition between the
> primary core and one of the secondary cores?
> 
> What is different in the Linux boot sequence between cold
> boot and resume? I'm thinking that the state stored in RAM
> is in fact incompatible with what Linux expects when it resumes...

I've taken a closer look at the MCR instruction.

    tlb_op(TLB_V7_UIS_FULL, "c8, c7, 0", zero);

#define tlb_op(f, regs, arg)	__tlb_op(f, "p15, 0, %0, " regs, arg)

#define __tlb_op(f, insnarg, arg)					\
	do {								\
		if (always_tlb_flags & (f))				\
			asm("mcr " insnarg				\
			    : : "r" (arg) : "cc");			\
		else if (possible_tlb_flags & (f))			\
			asm("tst %1, %2\n\t"				\
			    "mcrne " insnarg				\
			    : : "r" (arg), "r" (__tlb_flag), "Ir" (f)	\
			    : "cc");					\
	} while (0)


c010dd64:       e3130c12        tst     r3, #4608       ; 0x1200
c010dd68:       1e081f17        mcrne   15, 0, r1, cr8, cr7, {0}
c010dd6c:       e3120602        tst     r2, #2097152    ; 0x200000
c010dd70:       1e081f17        mcrne   15, 0, r1, cr8, cr7, {0}
c010dd74:       f57ff047        dsb     un
c010dd78:       f57ff06f        isb     sy

A8.6.92 MCR, MCR2

Move to Coprocessor from ARM core register passes the value of an ARM core register to a coprocessor.
If no coprocessor can execute the instruction, an Undefined Instruction exception is generated.

This is a generic coprocessor instruction. Some of the fields have no functionality defined by the architecture
and are free for use by the coprocessor instruction set designer. These fields are the opc1, opc2, CRn, and
CRm fields.

Operation

if ConditionPassed() then
	EncodingSpecificOperations();
	if !Coproc_Accepted(cp, ThisInstr()) then
		GenerateCoprocessorException();
	else
		Coproc_SendOneWord(R[t], cp, ThisInstr());


I.7.5 Coproc_Accepted()

This function determines, for a coprocessor and one of its coprocessor instructions:
- Whether access to the coprocessor is permitted by the CPACR and, if the Security Extensions are
implemented, the NSACR.
- If access is permitted, whether the instruction is accepted by the coprocessor. The coprocessor
architecture definition specifies which instructions it accepts and in what circumstances.
It returns TRUE if access is permitted and the coprocessor accepts the instruction, and FALSE otherwise.

boolean Coproc_Accepted(integer cp_num, bits(32) instr)


I.7.17 GenerateCoprocessorException()

This procedure generates the appropriate exception for a rejected coprocessor instruction.
In all architecture variants and profiles described in this manual, GenerateCoprocessorException() generates
an Undefined Instruction exception.


Assuming I'm hitting this, I would expect the kernel to print something
if the secondary cores trigger an exception. Am I mistaken?


mov     r1, #0
mcrne   15, 0, r1, cr8, cr7, {0}

B3.12.34 CP15 c8, TLB maintenance operations
On ARMv7-A implementations, CP15 c8 operations are used for TLB maintenance functions. Figure B3-20
shows the CP15 c8 encodings.

TLBIALL*, invalidate unified TLB
* See text for more information about these mnemonics
Invalidate entire unified TLB
(When separate instruction and data TLBs are implemented,
these operations are performed on both TLBs.)
Rt data = Ignore

Invalidate entire TLB
The Invalidate entire TLB operations invalidate all unlocked entries in the TLB. The value in the register Rt
specified by the MCR instruction used to perform the operation is ignored. You do not have to write a value
to the register before issuing the MCR instruction.


Maybe this is a red herring... I don't see why the TLBIALL would
raise an exception when the system resumes... I first suspected
TrustZone shenanigans, but it looks like TLBIALL just flushes
what it can, so TrustZone seems to be a non-issue.

I'm stumped... Still looking for a clue :-(

Maybe I should instrument the exception handler...
if I only knew where it was.

Regards.

