From: Pavel Machek <pavel@ucw.cz>
Subject: Re: wakeup code translated to .c
Date: Mon, 4 Feb 2008 00:56:09 +0100
Message-ID: <20080203235608.GH2799@elf.ucw.cz>
References: <20080130120111.GB22820@elf.ucw.cz> <20080203181648.GA1629@elf.ucw.cz> <200802032333.02821.rjw@sisk.pl> <200802040020.14836.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754654AbYBCX4E@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200802040020.14836.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> Below is the arch/x86/kernel/acpi/sleep.c part without the warnings (untested).
> 
> It still contains some hardcoded magic numbers and extern declarations, so
> I guess the #include list is not complete or another header is necessary.
> 
> BTW:
> 1) why exactly is acpi_wakeup_address not (void *)?
> 2) header->level3_ident_pgt and header->level3_ident_pgt could be (char *) IMO

I applied it, and renamed acpi/rm to acpi/realmode... yep, rm was a
bad name.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
