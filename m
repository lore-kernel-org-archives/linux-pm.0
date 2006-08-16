From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH] PM: Use suspend_console in swsusp and make it configureable
Date: Wed, 16 Aug 2006 12:41:43 +0200
Message-ID: <20060816104143.GC9497@elf.ucw.cz>
References: <200608151509.06087.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751099AbWHPKmH@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200608151509.06087.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> The appended patch does the following:
> 
> 1) Adds suspend_console() and resume_console() to the suspend-to-disk code
> paths so that people using netconsole are safe with swsusp.

> 2) Adds a Kconfig option allowing us to disable suspend_/resume_console()
> if need be.

Slightly ugly, but I guess that is the way to go.

> 3) Marks CONFIG_PM_TRACE as dangerous.

I do not think that is enough. "(WILL TRASH YOUR CMOS)" would be more
suitable. Dangerous is "may cause problems to you". This is "will
cause problems to you". And for this to be useful, people have to edit
sources, anyway.

								Pavel

Can we just delete the config option?
> Index: linux-2.6.18-rc4-mm1/kernel/power/Kconfig
> ===================================================================
> --- linux-2.6.18-rc4-mm1.orig/kernel/power/Kconfig
> +++ linux-2.6.18-rc4-mm1/kernel/power/Kconfig
>  config PM_TRACE
> -	bool "Suspend/resume event tracing"
> +	bool "Suspend/resume event tracing (DANGEROUS)"
>  	depends on PM && PM_DEBUG && X86_32 && EXPERIMENTAL
>  	default n
>  	---help---

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
