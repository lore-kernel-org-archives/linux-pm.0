From: Pavel Machek <pavel@ucw.cz>
Subject: Re: wakeup code translated to .c
Date: Sun, 3 Feb 2008 23:24:07 +0100
Message-ID: <20080203222407.GC2799@elf.ucw.cz>
References: <20080130120111.GB22820@elf.ucw.cz> <200802031857.02422.rjw@sisk.pl> <20080203181648.GA1629@elf.ucw.cz> <20080203184931.GA2648@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754276AbYBCWYB@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080203184931.GA2648@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

On Sun 2008-02-03 19:49:31, Sam Ravnborg wrote:
> On Sun, Feb 03, 2008 at 07:16:48PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > This version works on 32-bit, and builds on 64-bit (but I'm pretty
> > > > sure it does not work. 32-bit code probably needs to go into rm/....)
> > > > 
> > > 
> > > Do you have an updated version or is this the latest one?
> > 
> > I'm glad you ask ;-). Here's reasonably-recent version (I have
> > slightly cleaner one, but it got obscured by 2.6.24-git merge), I
> > eventually got it to work on 64-bit, by reusing trampoline.S code.
> > 
> > 								Pavel
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> Hi PAvel.
> 
> Before you submit this for real we need me to take a deper
> look into your Makefiles.

Ok, lets get this right.

> We do not want this duplication between boot and acpi.
> And the way you deal with code sharing from boot/ is not
> OK either.

Well, current version has one copy in .c, then two duplicate .S
version, based on older code.... so few duplicate Makefiles do not
seem like huge deal.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
