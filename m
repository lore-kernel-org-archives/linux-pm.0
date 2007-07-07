From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Sat, 7 Jul 2007 14:17:29 +0200
Message-ID: <20070707121729.GC3111@elf.ucw.cz>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44L0.0707041045150.25704-100000@netrider.rowland.org>
	<18060.14856.824473.325660@cargo.ozlabs.ibm.com>
	<200707050858.03638.oliver@neukum.org>
	<E1I6MWb-0008Tq-00@dorka.pomaz.szeredi.hu>
	<20070705091801.GB3084@elf.ucw.cz>
	<E1I6NgZ-0000F6-00@dorka.pomaz.szeredi.hu>
	<20070705115400.GF3984@ucw.cz>
	<E1I6Q73-0000Xi-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <E1I6Q73-0000Xi-00@dorka.pomaz.szeredi.hu>
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

> > > Actually fuse allows SIGKILL, because it's always fatal, and the
> > > syscall may not be restarted.
> > 
> > I think you want to stick try_to_freeze() at the same places where you
> > do SIGKILL handling. That should solve the 'syslogd is unfreezeable'
> > problem.
> 
> I could, but it would not solve the general problem.  Namely, that the
> presence of fuse imposes a certain ordering in which userspace tasks
> have to be frozen.  And it is not possible to know this ordering.

We can just wait for all fuse requests to be serviced before
proceeding further with freeze, right?

> And even if the ordering were solved, the freezer would still not work
> if the filesystem is not responding due to external events, such as a
> lost network (this affects NFS, CIFS, whatever just the same as
> fuse).

That's ok, you can't suspend if your hdd is dead, and in the same way
you can't suspend if your NFS server is dead. I agree it is ugly, but
we seem to live ok with that.

We could (and should?) handle that, probably by realizing that NFS is
not a disk and using interruptible sleep, but...

> > Plus, it would be nice to find out where suspend/hibernation is
> > triggering fuse activity. We can then decide where to fix it -- in
> > fuse or in suspend parts. You said sys_sync is not implemented... so
> > where is the problem?
> 
> I cannot say without having a sysrq-t of the situation.

Yes please. Can someone affected please produce sysrq-t?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
