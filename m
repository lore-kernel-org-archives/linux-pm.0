From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Fri, 8 Feb 2008 00:41:03 +0100
Message-ID: <20080207234103.GC21468@elf.ucw.cz>
References: <20080205190600.GB11613@elf.ucw.cz> <200802080006.54151.rjw@sisk.pl> <20080207233509.GB21468@elf.ucw.cz> <200802080036.43746.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761802AbYBGXk6@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200802080036.43746.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > > +	header = (struct wakeup_header *)(acpi_realmode + 0x3f00);
> > > > 
> > > > ... especially not with magic constants like this.
> > > 
> > > Yeah.  Pavel, what's at 0x3f00, btw?
> > 
> > struct wakeup_header.
> > 
> > I really need the entry point to be at offset 0, so that I can get
> > pointers to my data. I could not figure out how to do it any other
> > way. And if 0 is taken, I thought I'd put header at the end.
> 
> What does the number 0x3f00 follow from?

wakeup.ld:

SECTIONS
{
	. = 0x3f00;
	.header		: { *(.header) }

Ok, if we can use defines, this is probably great candidate for one of
them.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
