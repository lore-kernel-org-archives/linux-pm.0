From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] Re: [PATCH] Don't explode on swsusp failure to find swap
Date: Wed, 1 Jun 2005 22:42:07 +0200
Message-ID: <20050601204207.GA11163@elf.ucw.cz>
References: <1117523585.5826.18.camel@gaston> <1117583403.5826.72.camel@gaston> <20050601092742.GC6693@elf.ucw.cz> <200506012120.40607.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261217AbVFAUq1@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200506012120.40607.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
> > --- a/kernel/power/swsusp.c
> > +++ b/kernel/power/swsusp.c
> > @@ -975,13 +975,6 @@ extern asmlinkage int swsusp_arch_resume
> >  
> >  asmlinkage int swsusp_save(void)
> >  {
> > -	int error = 0;
> > -
> > -	if ((error = swsusp_swap_check())) {
> > -		printk(KERN_ERR "swsusp: FATAL: cannot find swap device, try "
> > -				"swapon -a!\n");
> > -		return error;
> > -	}
> >  	return suspend_prepare_image();
> >  }
> 
> I think we can move the contents of suspend_prepare_image() directly to
> swsusp_save().  It's not used anywhere else.

I thought about that, too, but bugfixes first, cleanups next.

									Pavel
