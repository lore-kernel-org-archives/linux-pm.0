From: Pavel Machek <pavel@ucw.cz>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Tue, 11 Jul 2006 23:28:43 +0200
Message-ID: <20060711212843.GA1836@elf.ucw.cz>
References: <200607101525.43507.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200607101525.43507.david-b@pacbell.net>
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
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

Looks good to me. Few more nits (sorry for two separate mails, I was
in a hurry).

> Call Sequence Guarantees
> --------------------------------------------

This probably needs few less '-'s.


> suspending devices
> ------------------

Capitalize?

> pm_message_t meaning
> --------------------

Capitalize 'meaning'?

> The event codes are used to nuance the goal of suspending the device,
> and mostly matter when creating or resuming suspend-to-disk snapshots:
> =

> PM_EVENT_SUSPEND -- quiesce the driver and put hardware into a low-power
>     state.  When used with system sleep states like "suspend-to-RAM" or
>     "standby", the upcoming resume() call will often be able to rely on
>     state kept in hardware, or issue system wakeup events.  When used
>     instead with suspend-to-disk, few devices support this capability;
>     most are completely powered off.

Previous paragraphs make it shound as if running DMA is allowed while
suspended. That's okay for PM_EVENT_SUSPEND...

> PM_EVENT_FREEZE -- quiesce the driver, but don't necessarily change into
>     any low power mode.  The driver's resume() will often be called soon.
>     Wakeup events are not allowed.
> =

> PM_EVENT_PRETHAW -- quiesce the driver, knowing that the upcoming resume()
>     will restore a suspend-to-disk snapshot from a different kernel image.
>     Drivers that are smart enough to look at their hardware state during
>     resume() processing need that state to be correct ... a PRETHAW could
>     be used to invalidate that state (by resetting the device).  Other
>     drivers might handle this the same way as PM_EVENT_FREEZE.

...but not for PM_EVENT_FREEZE/PRETHAW. I guess it should be stated
here...
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
