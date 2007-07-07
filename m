From: Pavel Machek <pavel@ucw.cz>
Subject: Re: removing refrigerator does not help with s2ram vs. fuse deadlocks
	(was Re: Re: [PATCH] Remove process freezer from
	suspend to RAM pathway)
Date: Sat, 7 Jul 2007 13:50:47 +0200
Message-ID: <20070707115047.GE2789@elf.ucw.cz>
References: <18059.6726.218205.104212@cargo.ozlabs.ibm.com>
	<200707051704.48137.rjw@sisk.pl>
	<20070705150301.GB23647@srcf.ucam.org>
	<200707051727.36715.rjw@sisk.pl>
	<E1I6TJq-000164-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <E1I6TJq-000164-00@dorka.pomaz.szeredi.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > You have processes that don't react to signals, because some
> > > > other user land task is misbehaving.  I'd call that ugly at the
> > > > very least.
> > > 
> > > It already happens with, say, NFS. Don't think about it in terms of a 
> > > userland task misbehaving - think of it in terms of a resource becoming 
> > > unavailable.
> > 
> > I think there's a difference between a userland task playing the role of a
> > resource and a "real" external resource the kernel doesn't control.
> > 
> > IMO, userland tasks should not have the power to affect each other as though
> > they were parts of the kernel.
> 
> One task doing ptrace() can basically do whatever it wants with the
> task being traced.  This is not an exact analogy to what fuse does,
> but close.

Well, IMO userland tasks should not have power to grab VFS mutexes for
indefinite ammount of time. ("fused is allowed to deadlock kernel, in
a way only write to special file helps" is ugly). Unfortunately, I
don't think there's a way to work around that deadlock within fuse
design limits... (coda was able to get around it by working on whole
files granularity, AFAICT), so we'll have to live with that.

I think we have two separate problems here, and both are
solvable, without major changes to fuse or suspend framework.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
