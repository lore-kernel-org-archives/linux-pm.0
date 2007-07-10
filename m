From: Pavel Machek <pavel@ucw.cz>
Subject: Re: bogosort (was Re: Re: [RFC][PATCH -mm 5/6] Freezer:
	Use freezing timeout more efficiently)
Date: Wed, 11 Jul 2007 00:21:42 +0200
Message-ID: <20070710222142.GA7113@elf.ucw.cz>
References: <200707092229.08898.rjw@sisk.pl> <200707102339.18192.rjw@sisk.pl>
	<20070710213935.GE7091@elf.ucw.cz> <200707110007.35449.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707110007.35449.rjw@sisk.pl>
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

> > > > Task here is to sort the tasks, and freeze them in such order that
> > > > freezing works, right? Yep, we do not know the dependencies
> > > > explicitely... but what you invented is bogosort.
> > > 
> > > Define, please?
> > 
> > Uff, sorry. http://en.wikipedia.org/wiki/Bogosort .
> 
> So this thing is not bogosort, because it makes the tasks that haven't frozen
> appear on the bottom.  IOW, the first (failing) freezing attempt is used as
> a sieve, so the process is not completely random.
> 
> This actually is important, because the things like FUSE should be taken
> care of within a couple of iterations.

Aha, ok, I misunderstood the code. So you try to freeze the things
that could not be frozen, first? Hmm, something like that could
work...

> > Hmm, if someone wants to retry... perhaps we should just return
> > specific error and let the _userland_ do the retries? It can do it as
> > efficiently as outer loop in freezer...
> 
> No, because _that_ would be bogosort, as defined in Wikipedia. :-)

So it is me who invented bogosort, heh ;-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
