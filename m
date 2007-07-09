From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 5/6] Freezer: Use freezing timeout
	more efficiently
Date: Tue, 10 Jul 2007 01:34:14 +0200
Message-ID: <20070709233414.GI1967@elf.ucw.cz>
References: <200707092229.08898.rjw@sisk.pl> <200707092238.19267.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707092238.19267.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, pm list <linux-pm@lists.linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The freezer fails if there are uninterruptible tasks waiting for some frozen
> tasks to let them continue.  Moreover, in that case try_to_freeze_tasks() loops
> uselessly until the timeout expires which is wasteful, so in principle we should
> make the freezer fail as soon as all the tasks that refuse to freeze are
> uninterruptible.  However, instead of failing the freezer we can try to use the
> time left and thaw the tasks that have already been frozen without
> clearing the

No, we can't do that:

Imagine we have single uninterruptible task that waits for disk. It
would exit uninterruptible state in 10msec, *but* you give up and
unfreeze all. Now, another task goes uninterruptible waiting for
disk and situation repeats. Livelock.

Yes, this might play with races in interresting ways and help fuse,
but we do not want the livelock in the first place.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
