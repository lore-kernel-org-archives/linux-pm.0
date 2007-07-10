From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: bogosort (was Re: Re: [RFC][PATCH -mm 5/6] Freezer:
	Use freezing timeout more efficiently)
Date: Tue, 10 Jul 2007 23:39:17 +0200
Message-ID: <200707102339.18192.rjw@sisk.pl>
References: <200707092229.08898.rjw@sisk.pl> <200707101204.42687.rjw@sisk.pl>
	<20070710211320.GC7091@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070710211320.GC7091@elf.ucw.cz>
Content-Disposition: inline
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, Oleg Nesterov <oleg@tv-sign.ru>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday, 10 July 2007 23:13, Pavel Machek wrote:
> Hi!
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

Not _that_ inefficiently ...

> Task here is to sort the tasks, and freeze them in such order that
> freezing works, right? Yep, we do not know the dependencies
> explicitely... but what you invented is bogosort.

Define, please?

> Yes, it does increase chance that freezing succeeds, but I do not
> think increase of chance is worth having bogosort in tree :-).

Well.  Do you think it's better to uselessly wait for 20s?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
