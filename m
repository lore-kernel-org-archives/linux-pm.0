From: Pavel Machek <pavel@ucw.cz>
Subject: malicious filesystems (was Re: Re: [PATCH] Remove process
	freezer from suspend to RAM pathway)
Date: Sun, 8 Jul 2007 01:33:15 +0200
Message-ID: <20070707233315.GB3820@elf.ucw.cz>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <E1I7H6v-0006pf-00@dorka.pomaz.szeredi.hu>
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

> > We can just wait for all fuse requests to be serviced before
> > proceeding further with freeze, right?
> 
> Right.  Nice way to slow down or stop the suspend with an unprivileged
> process.  Avoiding that sort of DoS is one of the design goals of
> fuse.

So you want me to handle _malicious_ filesystems now?

That should be easy... :-). You already have nasty deadlocks in FUSE,
and you solve them by "root can echo 1 > abort"... so allow me the
same possibility.

We can tell fused we are freezing, and if all the requests are not
serviced within, say, 30 seconds, we call the filesystem malicious and
do echo 1 > abort.

Not ideal, but neither is allowing malicious filesystems in the first
place...

> Look at it this way: the task of the freezer is to stop new I/O
> hitting the hardware.  But it is totally indiscriminate about what it
> stops, it tries to stop _everything_ even things which have nothing to
> do with hardware.
> 
> Not nice.

Not nice, but we don't know any better for now. "Just fix all the
drivers" basically means "just fix 90% of kernel".
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
