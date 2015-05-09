From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/2] x86: speed cpu_up by quirking cpu_init_udelay
Date: Sat, 9 May 2015 09:24:00 +0200
Message-ID: <20150509072400.GB10106@gmail.com>
References: <418898b5b9a6d76e7fbbd2af7cc988de1a5a287d.1431066425.git.len.brown@intel.com>
 <170f6f6e9ac4aa4d8ec1ed5000bee95463897337.1431066425.git.len.brown@intel.com>
 <20150508083250.GB4137@pd.tnic>
 <CAJvTdKk3TM1PMUgGeWCxThzVknfBc8xMK-dJkbxJrwkWhjGzLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJvTdKk3TM1PMUgGeWCxThzVknfBc8xMK-dJkbxJrwkWhjGzLg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Jason Baron <jbaron@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-pm@vger.kernel.org


(Resending my reply with more dyn-debug folks Cc:-ed)

* Len Brown <lenb@kernel.org> wrote:

> On Fri, May 8, 2015 at 4:32 AM, Borislav Petkov <bp@alien8.de> wrote:
> 
> >> +     pr_debug("cpu_init_udelay quirk to %d, was %d", new_udelay, init_udelay);
> >
> > Can we make this printk(KERN_DEBUG please?
> >
> > I'd like to be able to slap "debug" on the command line and not 
> > recompile the kernel. And no, dyndbg="file smpboot.c +p" or 
> > whatever the syntax is, simply doesn't scale if I want to see all 
> > debug messages from early boot.

Ugh, so I see we have grown this gem some time ago:

 #if defined(CONFIG_DYNAMIC_DEBUG)
 /* dynamic_pr_debug() uses pr_fmt() internally so we don't need it here */
 #define pr_debug(fmt, ...) \
         dynamic_pr_debug(fmt, ##__VA_ARGS__)

I didn't even realize it's there and it happend 6 years ago, in a very 
unintuitively titled commit:

  346e15beb534 driver core: basic infrastructure for per-module dynamic debug messages

So in what way does that title tell us that all pr_debug() calls are 
redirected away if CONFIG_DYNAMIC_DEBUG is enabled (which distros do)?

So could we instead either add a dyndbg=all variant, or make 'debug' 
trigger all dynamic_pr_debug() messages?

Because this redirection breaks the whole pr_*() abstraction rather 
fundamentally, dyndebug stealing pr_debug() and hiding debug messages 
when the user specifically asked for them via 'debug' is pretty nasty 
IMHO ...

Thanks,

	Ingo
