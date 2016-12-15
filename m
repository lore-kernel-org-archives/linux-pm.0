From: Mason <slash.tmp@free.fr>
Subject: Linux fails to start secondary cores when system resumes from
 Suspend-to-RAM
Date: Thu, 15 Dec 2016 16:18:35 +0100
Message-ID: <d4db03ce-80fc-2968-c5c2-84f79272ce8d@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:19837 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755576AbcLOPTL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Dec 2016 10:19:11 -0500
Content-Language: 
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Sebastian Frias <sf84@laposte.net>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Thomas Gambier <thomas_gambier@sigmadesigns.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hello,

I'm playing with suspend-to-RAM on the tango platform:

  http://lxr.free-electrons.com/source/arch/arm/mach-tango/platsmp.c

When the system is suspended, the CPU is completely powered down
(receives no power whatsoever). When the system receives a wake-up
event, the CPU is powered up, and starts up exactly the same way
as for a cold boot (I think).

However, while Linux successfully starts the secondary cores when
the system first boots, it fails when the system resumes from "S3".

I added printascii() calls inside secondary_start_kernel() and I can
see that the following instruction are "properly" run:

	cpu_switch_mm(mm->pgd, mm);
	local_flush_bp_all();
	enter_lazy_tlb(mm, current);

but it seems local_flush_tlb_all(); never returns... :-(

  http://lxr.free-electrons.com/source/arch/arm/include/asm/tlbflush.h#L332


Looking more closely at that function, it seems to be failing in:

	tlb_op(TLB_V7_UIS_FULL, "c8, c7, 0", zero);

(meaning: I get a log before, but not after)

On my system, tlb_op(TLB_V7_UIS_FULL, "c8, c7, 0", zero);
resolves to:

c010ce18:       e3170602        tst     r7, #2097152    ; 0x200000
c010ce1c:       1e086f17        mcrne   15, 0, r6, cr8, cr7, {0}

What could be happening?
Can a core "hang" on this instruction?
Can a core "crash" on this instruction (meaning, an exception
is raised, and the core loops inside the exception code without
Linux noticing... that seems unlikely)

I'm stumped. Could someone throw me a clue?

Mark Rutland offered a guess about IPIs not working correctly.
Could this explain the behavior I'm seeing?

Regards.
