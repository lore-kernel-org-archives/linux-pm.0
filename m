From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Tue, 25 Apr 2006 22:32:57 +0200
Message-ID: <20060425203256.GD6379@elf.ucw.cz>
References: <200604242355.08111.rjw@sisk.pl> <444DF9B3.7080600@yahoo.com.au> <200604251739.13377.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932123AbWDYUdi@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200604251739.13377.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@suspend2.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> >   > -unsigned int count_data_pages(void)
> > > +/**
> > > + *	need_to_copy - determine if a page needs to be copied before saving.
> > > + *	Returns false if the page can be saved without copying.
> > > + */
> > > +
> > > +static int need_to_copy(struct page *page)
> > > +{
> > > +	if (!PageLRU(page) || PageCompound(page))
> > > +		return 1;
> > > +	if (page_mapped(page))
> > > +		return page_mapped_by_current(page);
> > > +
> > > +	return 1;
> > > +}
> > 
> > I'd much rather VM internal type stuff get moved *out* of kernel/power :(
> 
> Well, I kind of agree, but I don't know where to place it under mm/.
> 
> > It needs more comments too. Also, how important is it for the page to be
> > off the LRU?
> 
> Hm, I'm not sure if that's what you're asking about, but the pages off the LRU
> are handled in a usual way, ie. copied when snapshotting the system.  The
> pages _on_ the LRU may be included in the snapshot image without
> copying, but I require them additionally to be (a) mapped by someone and
> (b) not mapped by the current task.

Why do you _want_ them mapped by someone?

> > b) Why are you clearing PageLRU outside the spinlock?
> 
> Well, good question. ;-)  Moreover it seems I don't need to acquire the
> spinlock at all, because this is done on one CPU with IRQs disabled and the
> other tasks frozen.

Well, it is probably better to still take the spinlock. That way, if
something goes wrong we get deadlock, not anything worse.
								Pavel
-- 
Thanks for all the (sleeping) penguins.
