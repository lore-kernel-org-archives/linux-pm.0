From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 7/7] Freezer: Use freezing timeout
	more efficiently
Date: Sat, 14 Jul 2007 11:20:06 +0200
Message-ID: <200707141120.07101.rjw@sisk.pl>
References: <200707120006.50095.rjw@sisk.pl> <200707120017.23622.rjw@sisk.pl>
	<20070713234350.GE15498@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070713234350.GE15498@elf.ucw.cz>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, pm list <linux-pm@lists.linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On Saturday, 14 July 2007 01:43, Pavel Machek wrote:
> Hi!
> 
> > There is the problem with try_to_freeze_tasks() that it always loops until the
> > timeout expires, even if it is certain to fail much earlier.  Namely, if there
> > are uninterruptible tasks waiting for some frozen tasks to let them continue,
> > try_to_freeze_tasks() will certainly fail and it shouldn't waste time in that
> > cases.
> > 
> > To detect such situations, we can check if the number of tasks that haven't
> > frozen yet changes between subsequent iterations of the main loop in
> > try_to_freeze_tasks().  If this number hasn't been changing for sufficiently
> > long time (say, 250 ms), then most probably some uninterruptible tasks are
> > blocked by some frozen tasks and we should break out of this stalemate.  Thus,
> > it seems reasonable to thaw the tasks that have already been frozen without
> > clearing the freeze requests of the tasks that are refusing to freeze.  This
> > way, if these tasks are really blocked by the frozen ones, they will get extra
> > chance to freeze themselves after we have thawed the other tasks and before we
> > request those tasks to freeze again.  Next, the freezing loop can be repeated
> > and so on, until all tasks are frozen or the timeout expires.
> 
> I still don't quite like this patch... it is kind of trick we should
> not have to play. Can we at least get confirmation it helps in the
> FUSE case?

Well, anyone having problems with FUSE vs the freezer please check. :-)

I think I'll send the series to Andrew without this patch.  Would that be OK?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
