From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 idle: repair large-server 50-watt idle-power regression
Date: Thu, 19 Dec 2013 10:19:22 -0800
Message-ID: <52B338AA.1020307@zytor.com>
References: <baff264285f6e585df757d58b17788feabc68918.1387403066.git.len.brown@intel.com> <20131219122257.GC11279@gmail.com> <52B316FF.50906@zytor.com> <20131219160210.GA28426@gmail.com> <52B31B21.6010901@zytor.com> <20131219162136.GM16438@laptop.programming.kicks-ass.net> <52B323BE.7090108@zytor.com> <20131219170741.GB30382@gmail.com> <52B33640.3020204@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <52B33640.3020204@zytor.com>
Sender: stable-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org

On 12/19/2013 10:09 AM, H. Peter Anvin wrote:
> On 12/19/2013 09:07 AM, Ingo Molnar wrote:
>>
>> Likewise, having a barrier before the MONITOR looks sensible as well. 
>> Having it _after_ monitor looks weird and is probably wrong. [It might 
>> have been the effects of someone seeing the spurious wakeup problems 
>> with realizing the true source, or so.]
>>
> 
> Does anyone know the history of this barrier after the monitor?  I know
> Len is looking for a minimal patchset that can go into -stable, and it
> seems prudent to not preturb the code more than necessary, but going
> forward it would be nice to know...
> 

Hmm... it *looks* like it is intended to be part of the construct:

	smp_mb();
	if (!need_resched())
		...

I found a note in the HLT variant of the function saying:

/*
 * TS_POLLING-cleared state must be visible before we
 * test NEED_RESCHED:
 */

... which presumably has been copied elsewhere.

	-hpa
