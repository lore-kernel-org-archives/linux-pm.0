From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 3/5] swsusp: Fix handling of highmem
Date: Wed, 9 Aug 2006 15:35:45 +0200
Message-ID: <20060809133545.GB3932@elf.ucw.cz>
References: <200608091152.49094.rjw@sisk.pl> <200608091209.03695.rjw@sisk.pl> <20060809115145.GT3308@elf.ucw.cz> <200608091407.19845.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750775AbWHINgD@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200608091407.19845.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > >  include/linux/suspend.h |    6 
> > >  kernel/power/power.h    |    2 
> > >  kernel/power/snapshot.c |  822 ++++++++++++++++++++++++++++++++++++------------
> > >  kernel/power/swap.c     |    2 
> > >  kernel/power/swsusp.c   |   53 +--
> > >  kernel/power/user.c     |    2 
> > >  mm/vmscan.c             |    3 
> > >  7 files changed, 658 insertions(+), 232 deletions(-)
> > 
> > +400 lines for highmem... I hope highmem dies, dies, dies. Anyway, I'd
> > hate to debug this at the same time as the bitmap code. Can we get the
> > bitmaps in, wait for a while, and only then change highmem handling?
> 
> Sure, why not.  I'll prepare a series without the highmem patch for now.

Thanks.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
