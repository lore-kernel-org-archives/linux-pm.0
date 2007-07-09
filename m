From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: malicious filesystems (was Re: Re: [PATCH] Remove
	process freezer from suspend to RAM pathway)
Date: Mon, 09 Jul 2007 18:19:02 +0200
Message-ID: <E1I7vx0-0002Fn-00@dorka.pomaz.szeredi.hu>
References: <Pine.LNX.4.44L0.0707041045150.25704-100000@netrider.rowland.org>
	<18060.14856.824473.325660@cargo.ozlabs.ibm.com>
	<200707050858.03638.oliver@neukum.org>
	<E1I6MWb-0008Tq-00@dorka.pomaz.szeredi.hu>
	<20070705091801.GB3084@elf.ucw.cz>
	<E1I6NgZ-0000F6-00@dorka.pomaz.szeredi.hu>
	<20070705115400.GF3984@ucw.cz>
	<E1I6Q73-0000Xi-00@dorka.pomaz.szeredi.hu>
	<20070707121729.GC3111@elf.ucw.cz>
	<E1I7H6v-0006pf-00@dorka.pomaz.szeredi.hu>
	<20070707233315.GB3820@elf.ucw.cz>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20070707233315.GB3820@elf.ucw.cz> (message from Pavel Machek on
	Sun, 8 Jul 2007 01:33:15 +0200)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pavel@ucw.cz
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > > We can just wait for all fuse requests to be serviced before
> > > proceeding further with freeze, right?
> > 
> > Right.  Nice way to slow down or stop the suspend with an unprivileged
> > process.  Avoiding that sort of DoS is one of the design goals of
> > fuse.
> 
> So you want me to handle _malicious_ filesystems now?
> 
> That should be easy... :-). You already have nasty deadlocks in FUSE,
> and you solve them by "root can echo 1 > abort"... so allow me the
> same possibility.
> 
> We can tell fused we are freezing, and if all the requests are not
> serviced within, say, 30 seconds, we call the filesystem malicious and
> do echo 1 > abort.
> 
> Not ideal, but neither is allowing malicious filesystems in the first
> place...

Actually there's also a non-malicious case in which waiting for
requests to finish won't work: when one fuse filesystem is accessing
another.

Since we are blocking new fuse requests, that might block a fuse
daemon, which in turn makes it impossible to finish the pending
request.

And this is not at all theoretical, I know that encfs is used over
various other fuse filesystems like sshfs or ntfs-3g.

Yeah, stacking userspace filesystems could be done entirely in
userspace, and I'm actually working on that (with fuse-2.7.0 already
supporting some basic stacking).

But the point is, that the "wait for fuse to quiescence" hack would
not work in todays environment.

Miklos
