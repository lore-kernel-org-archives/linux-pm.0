From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: bogosort (was Re: Re: [RFC][PATCH -mm 5/6] Freezer:
	Use freezing timeout more efficiently)
Date: Wed, 11 Jul 2007 01:38:36 +0400
Message-ID: <20070710213836.GA200@tv-sign.ru>
References: <200707092229.08898.rjw@sisk.pl> <20070709233414.GI1967@elf.ucw.cz>
	<200707100809.38466.rjw@sisk.pl> <200707101204.42687.rjw@sisk.pl>
	<20070710211320.GC7091@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070710211320.GC7091@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On 07/10, Pavel Machek wrote:
> 
> > > > No, we can't do that:
> > > > 
> > > > Imagine we have single uninterruptible task that waits for disk. It
> > > > would exit uninterruptible state in 10msec, *but* you give up and
> > > > unfreeze all. Now, another task goes uninterruptible waiting for
> > > > disk and situation repeats. Livelock.
> > > 
> > > For how many times would that have to repeat before 30s of timeout expires?
> > > 
> > > Sorry, but I don't buy this argument. :-)
> > > 
> > > > Yes, this might play with races in interresting ways and help fuse,
> > > > but we do not want the livelock in the first place.
> > > 
> > > I think that the "livelock" will never happen.
> > > 
> > > Besides, we can add another timeout for breaking the loop from a "locked up"
> > > state.
> > 
> > Actually I like this idea. :-)
> > 
> > I have updated the patch to use the additional timeout, please have a look
> > (below).
> 
> Yes, this one could actually work... _really_ inefficiently.

Why inefficiently?

I am asking because I am curious (I never used freezer for myself): how long
does it take to freeze all tasks? I can't believe we need 20 seconds unless
something goes wrong. It looks very natural to do what Rafael suggests.

Oleg.
