From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: bogosort (was Re: Re: [RFC][PATCH -mm 5/6] Freezer:
	Use freezing timeout more efficiently)
Date: Wed, 11 Jul 2007 00:07:34 +0200
Message-ID: <200707110007.35449.rjw@sisk.pl>
References: <200707092229.08898.rjw@sisk.pl> <200707102339.18192.rjw@sisk.pl>
	<20070710213935.GE7091@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070710213935.GE7091@elf.ucw.cz>
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

On Tuesday, 10 July 2007 23:39, Pavel Machek wrote:
> Hi!
> 
> > > Task here is to sort the tasks, and freeze them in such order that
> > > freezing works, right? Yep, we do not know the dependencies
> > > explicitely... but what you invented is bogosort.
> > 
> > Define, please?
> 
> Uff, sorry. http://en.wikipedia.org/wiki/Bogosort .

So this thing is not bogosort, because it makes the tasks that haven't frozen
appear on the bottom.  IOW, the first (failing) freezing attempt is used as
a sieve, so the process is not completely random.

This actually is important, because the things like FUSE should be taken
care of within a couple of iterations.

> > > Yes, it does increase chance that freezing succeeds, but I do not
> > > think increase of chance is worth having bogosort in tree :-).
> > 
> > Well.  Do you think it's better to uselessly wait for 20s?
> 
> I'd prefer not to add more randomness in the process. If we have
> freezing failure in 10% cases now, 2 retries will make it 1%... that
> will be ugly to debug...

No more ugly then it's now, I'd say ...

> Hmm, if someone wants to retry... perhaps we should just return
> specific error and let the _userland_ do the retries? It can do it as
> efficiently as outer loop in freezer...

No, because _that_ would be bogosort, as defined in Wikipedia. :-)

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
