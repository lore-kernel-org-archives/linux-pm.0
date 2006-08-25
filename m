From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : Re : Re : [HELP] Power management for embedded system
Date: Fri, 25 Aug 2006 13:39:25 +0000 (GMT)
Message-ID: <20060825133925.47842.qmail@web25810.mail.ukl.yahoo.com>
References: <20060824215650.GB21439@flint.arm.linux.org.uk>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750798AbWHYNj1@vger.kernel.org>
In-Reply-To: <20060824215650.GB21439@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Russell King wrote:
> We have some folk who want a method to trigger emergency suspends when
> batteries got low, or if you move the battery cover, etc.  These are
> events which require fast reactions from the system, and coding up some
> additional interface to pass such events to userland, have some daemon
> running to monitor for those events, and issue a PM event is completely
> overkill and, actually, unreliable.
> 

I'm not sure to understand why a daemon is needed. Could you explain ?

>> Could you point out where it is handled ?
> 
> It's both machine class and CPU specific.  I couldn't point you at
> anything specific, except to say that different machines and ARM CPUs
> handle it differently.
> 
> Some CPUs have "wait for interrupt" instructions, some don't.  Some
> need special cache handling around this instruction, some don't.  Some
> machines have a CPU capable of "wait for interrupt" but must not use it.
> 
> It's all handled by the CPU abstraction, and the machine class abstraction.
> 
> See arch_idle in include/asm-arm/arch-*/system.h as the starting point
> for the "default" (== always used) idle implementations.
> 

thanks for that.

Francis
