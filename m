From: Pavel Machek <pavel@ucw.cz>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Wed, 12 Jul 2006 14:25:31 +0200
Message-ID: <20060712122531.GA2094@elf.ucw.cz>
References: <200607101525.43507.david-b@pacbell.net>
	<20060710225631.f520bca5.akpm@osdl.org>
	<200607111457.44161.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200607111457.44161.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

Not sure if I'm commenting on latest version...

>     PM_EVENT_FREEZE -- quiesce the driver, but don't necessarily change i=
nto
> 	any low power mode.  The driver's resume() will often be called soon.
> 	Neither wakeup events nor DMA are allowed.
> =

>     PM_EVENT_PRETHAW -- quiesce the driver, knowing that the upcoming res=
ume()
> 	will restore a suspend-to-disk snapshot from a different kernel image.
> 	Drivers that are smart enough to look at their hardware state during
> 	resume() processing need that state to be correct ... a PRETHAW could
> 	be used to invalidate that state (by resetting the device).  Other
> 	drivers might handle this the same way as PM_EVENT_FREEZE.

"Neither wakeup events nor DMA are allowed." should be added here,
too.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
