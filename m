From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2] x86: speed cpu_up by quirking cpu_init_udelay
Date: Sat, 9 May 2015 10:04:35 +0200
Message-ID: <20150509080435.GA4452@pd.tnic>
References: <418898b5b9a6d76e7fbbd2af7cc988de1a5a287d.1431066425.git.len.brown@intel.com>
 <170f6f6e9ac4aa4d8ec1ed5000bee95463897337.1431066425.git.len.brown@intel.com>
 <20150508083250.GB4137@pd.tnic>
 <CAJvTdKk3TM1PMUgGeWCxThzVknfBc8xMK-dJkbxJrwkWhjGzLg@mail.gmail.com>
 <20150509072400.GB10106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56433 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbbEIIEl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 9 May 2015 04:04:41 -0400
Content-Disposition: inline
In-Reply-To: <20150509072400.GB10106@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Len Brown <lenb@kernel.org>, X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Jason Baron <jbaron@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Steven Rostedt <rostedt@goodmis.org>

On Sat, May 09, 2015 at 09:22:38AM +0200, Ingo Molnar wrote:
> 
> * Len Brown <lenb@kernel.org> wrote:
> 
> > On Fri, May 8, 2015 at 4:32 AM, Borislav Petkov <bp@alien8.de> wrote:
> > 
> > >> +     pr_debug("cpu_init_udelay quirk to %d, was %d", new_udelay, init_udelay);
> > >
> > > Can we make this printk(KERN_DEBUG please?
> > >
> > > I'd like to be able to slap "debug" on the command line and not 
> > > recompile the kernel. And no, dyndbg="file smpboot.c +p" or 
> > > whatever the syntax is, simply doesn't scale if I want to see all 
> > > debug messages from early boot.
> 
> Ugh, so I see we have grown this gem some time ago:
> 
>  #if defined(CONFIG_DYNAMIC_DEBUG)
>  /* dynamic_pr_debug() uses pr_fmt() internally so we don't need it here */
>  #define pr_debug(fmt, ...) \
>          dynamic_pr_debug(fmt, ##__VA_ARGS__)
> 
> I didn't even realize it's there and it happend 6 years ago, in a very 
> unintuitively titled commit:
> 
>   346e15beb534 driver core: basic infrastructure for per-module dynamic debug messages
> 
> So in what way does that title tell us that all pr_debug() calls are 
> redirected away if CONFIG_DYNAMIC_DEBUG is enabled

Yeah, this thing made pr_debug() completely unusable.

> (which distros do)?

/me checks.

SUSE does, at least.

> So could we instead either add a dyndbg=all variant, or make 'debug' 
> trigger all dynamic_pr_debug() messages?

Not only that:

#elif defined(DEBUG)
#define pr_debug(fmt, ...) \
        printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)

now, AFAIU, this means if CONFIG_DYNAMIC_DEBUG=n, I still have to have
DEBUG defined in order to see debug output.

Because debug= sets only console loglevel to CONSOLE_LOGLEVEL_DEBUG
(debug_kernel() in main.c).

So lemme do some experiments:

$ make arch/x86/kernel/smpboot.i

I'm looking at the first function in there -
smpboot_setup_warm_reset_vector() - which has some pr_debug statements:

---
static inline __attribute__((always_inline)) __attribute__((no_instrument_function)) void smpboot_setup_warm_reset_vector(unsigned long start_eip)
{
 unsigned long flags;

 do { do { ({ unsigned long __dummy; typeof(flags) __dummy2; (void)(&__dummy == &__dummy2); 1; }); flags = _raw_spin_lock_irqsave(spinlock_check(&rtc_lock)); } while (0); } while (0);
 rtc_cmos_write(0xa, 0xf);
 spin_unlock_irqrestore(&rtc_lock, flags);
 __native_flush_tlb();
 no_printk("\001" "7" "smpboot" ": " "1.\n");
 ^^^^^^^^
---

Yeah, so that's not issuing anything.

Now, if I do

#define DEBUG

BUT! I have to remember to put it *before* all include statements in
that file so that printk.h can see it defined, then I see the printk()
call.

---
static inline __attribute__((always_inline)) __attribute__((no_instrument_function)) void smpboot_setup_warm_reset_vector(unsigned long start_eip)
{
 unsigned long flags;

 do { do { ({ unsigned long __dummy; typeof(flags) __dummy2; (void)(&__dummy == &__dummy2); 1; }); flags = _raw_spin_lock_irqsave(spinlock_check(&rtc_lock)); } while (0); } while (0);
 rtc_cmos_write(0xa, 0xf);
 spin_unlock_irqrestore(&rtc_lock, flags);
 __native_flush_tlb();
 printk("\001" "7" "smpboot" ": " "1.\n");
 ^^^^^^
---

So great, I have a printk there but I have to rebuild the kernel. I can
then just as well add my own debug statements, even use trace_printk for
that matter...

So even a dyndbg=all won't work if you haven't defined
CONFIG_DYNAMIC_DEBUG in your config.

So pr_debug() gets optimized away in the normal case but if we want to
always build in important debug statements and turn them on without
building the kernel, the easiest thing to do is to switch to good ole

printk(KERN_DEBUG

Hell, we can even do an x86-specific define: x86_debug() or so, which
would also denote that this is a debug statement which should stay
built-in and it gives important information. All the early SMP bootstrap
code for example would use that.

And so on and so on...

> Because this redirection breaks the whole pr_*() abstraction rather
> fundamentally, dyndebug stealing pr_debug() and hiding debug messages
> when the user specifically asked for them via 'debug' is pretty nasty
> IMHO ...

Yeah, I think we should do our own which doesn't interfere with pr_*

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
