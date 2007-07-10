From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 5/6] Freezer: Use freezing timeout
	more efficiently
Date: Tue, 10 Jul 2007 08:09:37 +0200
Message-ID: <200707100809.38466.rjw@sisk.pl>
References: <200707092229.08898.rjw@sisk.pl> <200707092238.19267.rjw@sisk.pl>
	<20070709233414.GI1967@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070709233414.GI1967@elf.ucw.cz>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, pm list <linux-pm@lists.linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 10 July 2007 01:34, Pavel Machek wrote:
> Hi!
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The freezer fails if there are uninterruptible tasks waiting for some frozen
> > tasks to let them continue.  Moreover, in that case try_to_freeze_tasks() loops
> > uselessly until the timeout expires which is wasteful, so in principle we should
> > make the freezer fail as soon as all the tasks that refuse to freeze are
> > uninterruptible.  However, instead of failing the freezer we can try to use the
> > time left and thaw the tasks that have already been frozen without
> > clearing the
> 
> No, we can't do that:
> 
> Imagine we have single uninterruptible task that waits for disk. It
> would exit uninterruptible state in 10msec, *but* you give up and
> unfreeze all. Now, another task goes uninterruptible waiting for
> disk and situation repeats. Livelock.

For how many times would that have to repeat before 30s of timeout expires?

Sorry, but I don't buy this argument. :-)

> Yes, this might play with races in interresting ways and help fuse,
> but we do not want the livelock in the first place.

I think that the "livelock" will never happen.

Besides, we can add another timeout for breaking the loop from a "locked up"
state.  Anyway, waiting for 20s (as without the patch) when it is _certain_
that we will fail doesn't make sense ...

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
