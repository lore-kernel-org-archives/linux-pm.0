From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Fri, 8 Feb 2008 22:00:04 +0100
Message-ID: <20080208210004.GA12923@elf.ucw.cz>
References: <20080205190600.GB11613@elf.ucw.cz> <47AB975C.1010902@zytor.com> <20080208070419.GA4544@ucw.cz> <200802081723.16354.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756834AbYBHVAL@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200802081723.16354.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2008-02-08 17:23:15, Rafael J. Wysocki wrote:
> On Friday, 8 of February 2008, Pavel Machek wrote:
> > Hi!
> 
> Hi,
> 
> > > >I really need the entry point to be at offset 0, so 
> > > >that I can get
> > > >pointers to my data. I could not figure out how to do 
> > > >it any other
> > > >way. And if 0 is taken, I thought I'd put header at the 
> > > >end.
> > > >
> > > 
> > > Why not just put the structure at 0, and put pointers in 
> > > the structure to everything else you need?
> > 
> > segments:offsets rear its ugly head here. I need %ds to point to my
> > data, and the way to do it is copy it from %cs; that needs start to be
> > at 0.
> 
> Hm, why exactly is that necessay?

It is not _neccessary_. Try to come up with another method that gets
relocations right. I could not :-(.

(Actually, putting table at the offset 0 and short jump at beggining
of the table would probably do the trick. But that still keeps code at
offset 0 :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
