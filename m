From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Fri, 8 Feb 2008 07:04:19 +0000
Message-ID: <20080208070419.GA4544@ucw.cz>
References: <20080205190600.GB11613@elf.ucw.cz> <200802072312.31430.rjw@sisk.pl> <47AB887E.7010000@zytor.com> <200802080006.54151.rjw@sisk.pl> <20080207233509.GB21468@elf.ucw.cz> <47AB975C.1010902@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932935AbYBHHEq@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47AB975C.1010902@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> >I really need the entry point to be at offset 0, so 
> >that I can get
> >pointers to my data. I could not figure out how to do 
> >it any other
> >way. And if 0 is taken, I thought I'd put header at the 
> >end.
> >
> 
> Why not just put the structure at 0, and put pointers in 
> the structure to everything else you need?

segments:offsets rear its ugly head here. I need %ds to point to my
data, and the way to do it is copy it from %cs; that needs start to be
at 0.

If you can find a solution that does not need this (some
segment/offset arithmetics at beggining of wakeup?) we could use it,
but I was lost between relocations.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
