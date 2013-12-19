From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 idle: repair large-server 50-watt idle-power regression
Date: Thu, 19 Dec 2013 08:50:06 -0800
Message-ID: <52B323BE.7090108@zytor.com>
References: <baff264285f6e585df757d58b17788feabc68918.1387403066.git.len.brown@intel.com> <20131219122257.GC11279@gmail.com> <52B316FF.50906@zytor.com> <20131219160210.GA28426@gmail.com> <52B31B21.6010901@zytor.com> <20131219162136.GM16438@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20131219162136.GM16438@laptop.programming.kicks-ass.net>
Sender: stable-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org

On 12/19/2013 08:21 AM, Peter Zijlstra wrote:
> 
> What's that mb for?
> 

It already exists in mwait_idle_with_hints(); I just moved it into this
common function.  It is a bit odd, I have to admit; it seems like it
should be *before* the monitor (and possibly we should have one after
the CLFLUSH as well?)

> Also, can you please merge:
> 
>   http://marc.info/?l=linux-kernel&m=138685838420632
> 
> Thomas said he would pick up that series, but seems to have gone missing
> the past week or so.
> 

We need to get the immediate regression fixed.
