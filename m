From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Fri, 8 Feb 2008 22:13:46 +0100
Message-ID: <20080208211346.GC12923@elf.ucw.cz>
References: <20080205190600.GB11613@elf.ucw.cz> <200802072312.31430.rjw@sisk.pl> <20080207222845.GA6096@elf.ucw.cz> <200802072340.06138.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754757AbYBHVNo@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200802072340.06138.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Can you post a delta against my versoin? I do not see any changes from
> > a quick glance.
> 
> Appended (plus I removed two hunks, one in arch/x86/Makefile and one in
> drivers/acpi/sleep/main.c that were unrelated to the rest of the patch).

Thanks, applied.

> > This is probably more acceptable version of beep; but there are
> > probably even better ways to clean it...
> > 
> >         if (wakeup_header.realmode_flags & 4) {
> >                 inb(97);
> >                 outb(0, 0x80);
> >                 outb(3, 97);
> >                 outb(0, 0x80);
> >                 outb(-74, 67);
> >                 outb(0, 0x80);
> >                 outb(-119, 66);
> >                 outb(0, 0x80);
> >                 outb(15, 66);
> >         }
> > 
> > ...like the version that makes beep/pause/beep/pause, so that user can
> > count them.
> 
> Can we move it into a separate function?

I guess we want to use HPA's morse code ;-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
