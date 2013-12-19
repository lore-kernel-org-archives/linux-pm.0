From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 idle: repair large-server 50-watt idle-power regression
Date: Thu, 19 Dec 2013 11:22:01 -0800
Message-ID: <52B34759.3010009@zytor.com>
References: <baff264285f6e585df757d58b17788feabc68918.1387403066.git.len.brown@intel.com> <20131219122257.GC11279@gmail.com> <52B316FF.50906@zytor.com> <20131219160210.GA28426@gmail.com> <52B31B21.6010901@zytor.com> <20131219162136.GM16438@laptop.programming.kicks-ass.net> <52B323BE.7090108@zytor.com> <20131219170741.GB30382@gmail.com> <52B33640.3020204@zytor.com> <20131219181948.GD32508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131219181948.GD32508@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org

On 12/19/2013 10:19 AM, Ingo Molnar wrote:
> 
> ( It would also be nice to know whether MONITOR loads that cacheline 
>   into the CPUs cache, and in what state it loads it. )
> 

I would assume that is implementation-dependent.  However, one plausible
implementation is to load the cache line into the cache in shared state
and monitor for evictions.

	-hpa
