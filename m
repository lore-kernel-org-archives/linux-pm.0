From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: malicious filesystems (was Re: Re: [PATCH] Remove
	process freezer from suspend to RAM pathway)
Date: Sun, 08 Jul 2007 09:21:52 +0200
Message-ID: <E1I7R5c-0007q3-00@dorka.pomaz.szeredi.hu>
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

What I'd like, is a suspend, that works reliably, regardless of the
state of any userspace filesystem, network servers and such.

> That should be easy... :-). You already have nasty deadlocks in FUSE,
> and you solve them by "root can echo 1 > abort"... so allow me the
> same possibility.
> 
> We can tell fused we are freezing, and if all the requests are not
> serviced within, say, 30 seconds, we call the filesystem malicious and
> do echo 1 > abort.

Arbitrary time limits, nice.  Not.

This freezer is like an old house that's close to collapsing, and you
are basically just thinking of where to prop it up further.  To
continute this brilliant analogy, Rafael's patch at least demolishes
the worst part of the house, where bricks are already falling on our
head ;)

> Not ideal, but neither is allowing malicious filesystems in the first
> place...

Malicious programs are not something specific to fuse.  A lot of the
multiuser/multitasking OS design is about isolating things, so such a
program is limited in the damage it can do.

> > Look at it this way: the task of the freezer is to stop new I/O
> > hitting the hardware.  But it is totally indiscriminate about what it
> > stops, it tries to stop _everything_ even things which have nothing to
> > do with hardware.
> > 
> > Not nice.
> 
> Not nice, but we don't know any better for now. "Just fix all the
> drivers" basically means "just fix 90% of kernel".

And how much of that 90% currently has any power management?

Miklos
