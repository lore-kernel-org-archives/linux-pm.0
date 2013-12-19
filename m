From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86 idle: repair large-server 50-watt idle-power
 regression
Date: Thu, 19 Dec 2013 17:21:36 +0100
Message-ID: <20131219162136.GM16438@laptop.programming.kicks-ass.net>
References: <baff264285f6e585df757d58b17788feabc68918.1387403066.git.len.brown@intel.com>
 <20131219122257.GC11279@gmail.com>
 <52B316FF.50906@zytor.com>
 <20131219160210.GA28426@gmail.com>
 <52B31B21.6010901@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52B31B21.6010901@zytor.com>
Sender: stable-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>, Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 19, 2013 at 08:13:21AM -0800, H. Peter Anvin wrote:
> How does this look?  Completely untested, of course.
> 
> I do wonder if we need more memory barriers, though.
> 
> An alternative would be to move everything into mwait_idle_with_hints().
> 
> 	-hpa
> 

> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 7b034a4057f9..6dce588f94b4 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -723,6 +723,23 @@ static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
>  		     :: "a" (eax), "c" (ecx));
>  }
>  
> +/*
> + * Issue a clflush in preparation for a monitor instruction if the CPU
> + * needs it.  We force the address into the ax register to get a fixed
> + * length for the instruction, however, this is what the monitor instruction
> + * is going to need anyway, so it shouldn't add any additional code.
> + */
> +static inline void clflush_monitor(const void *addr, unsigned long ecx,
> +				   unsigned long edx)
> +{
> +	alternative_input(ASM_NOP3,
> +			  "clflush (%0)",
> +			  X86_FEATURE_CLFLUSH_MONITOR,
> +			  "a" (addr));
> +	__monitor(addr, eax, edx);
> +	smp_mb();
> +}

What's that mb for?

Also, can you please merge:

  http://marc.info/?l=linux-kernel&m=138685838420632

Thomas said he would pick up that series, but seems to have gone missing
the past week or so.
