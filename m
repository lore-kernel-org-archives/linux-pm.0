From: Pavel Machek <pavel@ucw.cz>
Subject: bogosort (was Re: Re: [RFC][PATCH -mm 5/6] Freezer: Use
	freezing timeout more efficiently)
Date: Tue, 10 Jul 2007 23:13:20 +0200
Message-ID: <20070710211320.GC7091@elf.ucw.cz>
References: <200707092229.08898.rjw@sisk.pl> <20070709233414.GI1967@elf.ucw.cz>
	<200707100809.38466.rjw@sisk.pl> <200707101204.42687.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707101204.42687.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, Oleg Nesterov <oleg@tv-sign.ru>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > No, we can't do that:
> > > 
> > > Imagine we have single uninterruptible task that waits for disk. It
> > > would exit uninterruptible state in 10msec, *but* you give up and
> > > unfreeze all. Now, another task goes uninterruptible waiting for
> > > disk and situation repeats. Livelock.
> > 
> > For how many times would that have to repeat before 30s of timeout expires?
> > 
> > Sorry, but I don't buy this argument. :-)
> > 
> > > Yes, this might play with races in interresting ways and help fuse,
> > > but we do not want the livelock in the first place.
> > 
> > I think that the "livelock" will never happen.
> > 
> > Besides, we can add another timeout for breaking the loop from a "locked up"
> > state.
> 
> Actually I like this idea. :-)
> 
> I have updated the patch to use the additional timeout, please have a look
> (below).

Yes, this one could actually work... _really_ inefficiently.

Task here is to sort the tasks, and freeze them in such order that
freezing works, right? Yep, we do not know the dependencies
explicitely... but what you invented is bogosort.

Yes, it does increase chance that freezing succeeds, but I do not
think increase of chance is worth having bogosort in tree :-).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
