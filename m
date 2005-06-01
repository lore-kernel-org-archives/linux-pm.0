From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Re: [PATCH] Don't explode on swsusp failure to find swap
Date: Wed, 1 Jun 2005 21:20:40 +0200
Message-ID: <200506012120.40607.rjw@sisk.pl>
References: <1117523585.5826.18.camel@gaston> <1117583403.5826.72.camel@gaston> <20050601092742.GC6693@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261245AbVFAT1o@vger.kernel.org>
In-Reply-To: <20050601092742.GC6693@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.osdl.org
Cc: Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday, 1 of June 2005 11:27, Pavel Machek wrote:
> Hi!
> 
> > > > > If we specify a swap device for swsusp using resume= kernel argument and
> > > > > that device doesn't exist in the swap list, we end up calling
> > > > > swsusp_free() before we have allocated pagedir_save. That causes us to
> > > > > explode when trying to free it.
> > > > > 
> > > > > Pavel, does that look right ?
> > > > 
> > > > It looks like a workaround. We should not call swsusp_free in case
> > > > device does not exists. Quick look did not reveal where the bug comes
> > > > from, can you try to trace it?
> > > > 								Pavel
> > > 
> > > Well, the bug comes from arch code calling swsusp_save() which fails,
> > > then we call swsusp_free()
> > 
> > More specifically, arch suspend calls swsusp_save().
> > 
> > It fails and returns the error to the arch asm code, which itself
> > returns it to it's caller swsusp_suspend(), which does that:
> > 
> >  	if ((error = swsusp_arch_suspend()))
> > 		swsusp_free();
> 
> Ugh, swsusp_free should be totally unneccessary at this point; only
> error returns are from the time before anything is allocated.

Oops, it looks like I have introduced these swsusp_free()s, so I'm sorry ...

> Does something like this help?
> 
> diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
> --- a/kernel/power/swsusp.c
> +++ b/kernel/power/swsusp.c
> @@ -975,13 +975,6 @@ extern asmlinkage int swsusp_arch_resume
>  
>  asmlinkage int swsusp_save(void)
>  {
> -	int error = 0;
> -
> -	if ((error = swsusp_swap_check())) {
> -		printk(KERN_ERR "swsusp: FATAL: cannot find swap device, try "
> -				"swapon -a!\n");
> -		return error;
> -	}
>  	return suspend_prepare_image();
>  }

I think we can move the contents of suspend_prepare_image() directly to
swsusp_save().  It's not used anywhere else.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
