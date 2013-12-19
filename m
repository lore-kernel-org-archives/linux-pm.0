From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86 idle: repair large-server 50-watt idle-power
 regression
Date: Thu, 19 Dec 2013 19:43:39 +0100
Message-ID: <20131219184339.GA32669@gmail.com>
References: <52B316FF.50906@zytor.com>
 <20131219160210.GA28426@gmail.com>
 <52B31B21.6010901@zytor.com>
 <20131219162136.GM16438@laptop.programming.kicks-ass.net>
 <52B323BE.7090108@zytor.com>
 <20131219170741.GB30382@gmail.com>
 <52B33640.3020204@zytor.com>
 <52B338AA.1020307@zytor.com>
 <20131219182314.GE32508@gmail.com>
 <CA+55aFzGxcML7j8CEvQPYzh0W81uVoAAVmGctMOUZ7CZ1yYd2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36403 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab3LSSnn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2013 13:43:43 -0500
Content-Disposition: inline
In-Reply-To: <CA+55aFzGxcML7j8CEvQPYzh0W81uVoAAVmGctMOUZ7CZ1yYd2A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Mike Galbraith <efault@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The x86 memory rules are that two loads always execute in order (ie=20
> rmb is a no-op).
>=20
> So I see no reason for a memory barrier after the monitor. [...]

Yes, I'm leaning towards that interpretation as well, but the reason=20
I'm a bit catious is the somewhat curious (to me!) wording of the=20
MONITOR instruction:

  Sets up a linear address range to be monitored by hardware and=20
  activates the monitor.

  ...

  The MONITOR instruction is ordered as a load operation with respect=20
  to other memory trans=ADactions. The instruction can be used at all=20
  privilege levels and is subject to all permission checking and=20
  faults associated with a byte load. Like a load, the MONITOR=20
  instruction sets the A-bit but not the D-bit in page tables.

Where apparently the 'range' means 'full cache line surrounding the=20
memory address in question'.

We have no other load instructions that operate on such a large=20
'range' of addresses, and I wanted to make sure it's a true (single=20
byte) load for that specific address. The documentation does not=20
appear to explicitly state that it's a load for that address - only=20
that it's ordered as a load.

The reason I'm asking is because 'flags' itself might not be at the=20
beginning of the cache line, as it's in the middle of thread_info:

 struct thread_info {
        struct task_struct      *task;          /* main task structure =
*/
        struct exec_domain      *exec_domain;   /* execution domain */
        __u32                   flags;          /* low level flags */

while 'MONITOR' appears to work on the cache line. So are all=20
addresses within that cache line ordered? Only the specific address=20
given to the instruction itself? Only the first word of the cacheline=20
itself?

The documentation is a bit vague, at least in my reading, and=20
depending on which actual word the instruction reads (if it reads any=20
word at all ... it's probably just setting up an address for MWAIT)=20
from that cacheline, its ordering properties might be surprising.

> [...] But both sides of clflush sounds sane, and as mentioned the=20
> "go to sleep" side isn't as critical as the "wake up" side if the=20
> monitor.

Yeah.

> Please let's just make that pre-monitor hack be a static key, and do=20
> mfence explicitly around the clflush inside that conditional=20
> section.

Agreed.

Thanks,

	Ingo
