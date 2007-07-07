From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm] Freezer: Handle uninterruptible
	tasks
Date: Sat, 7 Jul 2007 13:31:18 +0200
Message-ID: <20070707113118.GA2789@elf.ucw.cz>
References: <200707061012.48998.rjw@sisk.pl> <20070707075018.GB2638@elf.ucw.cz>
	<200707071913.43482.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707071913.43482.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nigel@suspend2.net
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Hi!

> > I don't think we can do that. I suspect rename looks like:
> > 
> > 	write directory entry in source
> > A)	(uninterruptible wait for write)
> > 	write directory entry in destination
> > 	(uninterruptible wait for write)
> > 	write something else
> > 
> > If we freeze some task in place "A)", we'll write to the disk when the
> > directory write is finished :-(.
> 
> Renaming is a single syscall, so won't the process get frozen when the syscall 
> finishes? 

It would be frozen when syscall finishes. But if we freeze it at A)
point, we have a problem.

> Perhaps you've just found more logic for keeping the sys_sync there?

No, I don't think so.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
