From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sun, 25 Jun 2006 00:39:50 +0200
Message-ID: <20060624223950.GF2777@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<Pine.LNX.4.64.0606232029200.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606232029200.6483@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

(I'm sorry, I'm quite out-of-time now).

> > Let me reboot my current kernel to test my current five-phase thing, an=
d =

> > I'll do the subsystem thing too.
> =

> Ok, here.
> =

> This simple patch is nothing but cleanups, cleanups, cleanups.
> =

> And in the process, _I_ think it helps the suspend infrastructure a lot.
> =

> I don't know how many people have ever actually _looked_ closely at how =

> horrible the ->suspend() sequence was, but let's just say that it was har=
d =

> to make sense of how dpm_active->dpm_off worked, and what dpm_off_irq =

> actually did. More importantly, it was basically impossible for devices t=
o =

> sanely use the whole dpm_off_irq logic (I doubt anybody ever did - you =

> would return -EAGAIN to move you into the dpm_off_irq queue, but the =

> recovery was pretty damn undefined - you'd then get "resumed" even =

> though you never successfully suspended etc).

I was vaguely aware of this hack... and I'm glad you are deleting
it. It would be nice to find -EAGAIN users and convert them to new
API... just to verify that API is viable.

> Btw, if anybody had ever actually used the "dpm_off_irq" thing, they
> should have seen a huge warning about the semaphore sleeping with
> interrupts off, so I'm pretty sure nobody ever really used it.  Since I
> think it was unusable, I'm not surprised. =


I'm pretty sure someone did use it, and just ignored the warning...

> The sane version has a very simple sequence:
> =

>  - devices start on "dpm_active". =

> =

>  - "suspend_prepare()" is called for every device (with the semaphore =

>    held, you are _not_ allowed to try to unlink yourself in the prepare =

>    function)

Why not just do notifier list here? Very few drivers will actually use
this one, and prepare is not really ordered as userspace is running.

> And that's it.
> =

> The nice part here is the error management (which, quite frankly, was
> insane with the old "dpm_off_irq" scheme).  In the new scheme, the
> lists

Yep, fixing error management is nice, and -EAGAIN was too ugly to
live.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
