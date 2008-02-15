From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] move wakeup code to .c
Date: Fri, 15 Feb 2008 09:55:44 +0000
Message-ID: <20080215095544.GA4667@ucw.cz>
References: <20080210222723.GA1865@elf.ucw.cz> <200802150135.07127.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932387AbYBOJ4R@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200802150135.07127.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, hpa@zytor.com, rjw@sisk.pl, sam@ravnborg.org
List-Id: linux-pm@vger.kernel.org

Hi!

> scripts/checkpatch.pl
> ERROR: do not initialise externals to 0 or NULL
> #113: FILE: arch/x86/boot/video-mode.c:29:
> +int do_restore = 0;    /* Screen contents changed during mode flip */

We were doing file move with minimal changes.

> ERROR: need a space before the open parenthesis '('
> #710: FILE: arch/x86/kernel/acpi/realmode/wakemain.c:70:
> +               while(1);

Bogus warning.

I'll fix al but this one, but could we do it as a followup patch? I'm
currently at holidays, moving .S code into .c is rather
good/important, and it should get testing ASAP.
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
