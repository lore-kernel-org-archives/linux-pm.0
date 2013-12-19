From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 idle: repair large-server 50-watt idle-power regression
Date: Thu, 19 Dec 2013 08:09:29 -0800
Message-ID: <52B31A39.5030700@zytor.com>
References: <baff264285f6e585df757d58b17788feabc68918.1387403066.git.len.brown@intel.com> <20131219122257.GC11279@gmail.com> <52B316FF.50906@zytor.com> <20131219160210.GA28426@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131219160210.GA28426@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Mike Galbraith <efault@gmx.de>, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org

On 12/19/2013 08:02 AM, Ingo Molnar wrote:
>>
>> __monitor() currently doesn't, which is idiotic.
> 
> Hm, __monitor() seems to take a void *:
> 
>  arch/x86/include/asm/processor.h:static inline void __monitor(const void *eax, unsigned long ecx,
> 
> So writing:
> 
> 		if (this_cpu_has(X86_FEATURE_CLFLUSH_MONITOR))
> 			clflush(&current_thread_info()->flags);
> 
>   		__monitor(&current_thread_info()->flags, 0, 0);
> 

Yes, brain failure on my part.

	-hpa
