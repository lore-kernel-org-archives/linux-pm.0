From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm] Freezer: Handle uninterruptible
	tasks
Date: Sat, 7 Jul 2007 09:50:18 +0200
Message-ID: <20070707075018.GB2638@elf.ucw.cz>
References: <200707061012.48998.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707061012.48998.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Hi!

> The main limitation of the freezer is that it cannot handle uninterruptible
> tasks.  Namely, if there are uninterruptible tasks in the system, the freezer
> returns an error, which makes it impossible to suspend the system.
...
> Unfortunately, this mechanism also leads to severe limitations, such as that it
> makes the freezer unable to handle systems using FUSE in a reliable way.
> 
> This patch makes the freezer skip uninterruptible user space tasks (ie. such
> that have an mm of their own) when counting the tasks to be frozen.  As a
> result, these tasks have the TIF_FREEZE and TIF_SIGPENDING flags set, but the
> freezer doesn't wait for them to enter the refrigerator.  Nevertheless, they
> will enter the refrigerator as soon as they change their state.

I don't think we can do that. I suspect rename looks like:

	write directory entry in source
A)	(uninterruptible wait for write)
	write directory entry in destination
	(uninterruptible wait for write)
	write something else

If we freeze some task in place "A)", we'll write to the disk when the
directory write is finished :-(.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
