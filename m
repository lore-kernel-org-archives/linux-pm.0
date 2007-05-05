From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Sat, 5 May 2007 17:42:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705051737290.27516-100000@netrider.rowland.org>
References: <200705051946.08625.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705051946.08625.rjw@sisk.pl>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Sat, 5 May 2007, Rafael J. Wysocki wrote:

> > > Yes, but that can be done in two different ways:
> > > 
> > > 1) "We have restored the hibernation image, but the BIOS state corresponds to
> > > a fresh reboot, so please initialize everything from scratch."
> > > 
> > > 2) "We have restored the hibernation image and the ACPI S4 was used for
> > > powering off (hint: you may try not to initialize everything from scratch)."
> > > 
> > > Of course, in the case 2) we are responsible for ensuring that the contents of
> > > the hibernation image are consistent with the information preserved by the
> > > BIOS.
> > 
> > Keep in mind also that before you can do either 1) or 2), the boot kernel 
> > has already communicated with the BIOS, possibly changing some of the ACPI 
> > state.
> 
> That's correct, but it follows from the ACPI spec that there is a way for the
> boot kernel to distinguish 'normal' boot from 'S4 resume' boot.  If this
> mechanism is used and the boot kernel states that it's doing a 'S4 resume',
> it will be able to leave ACPI alone and restore the hibernation image.

Okay, good.  That means part of the resume-from-hibernation handling must
be included in the standard startup code of the ACPI driver, because it 
runs in the boot kernel rather than the restored kernel.  Does it work 
that way now?  You'd think it must...

The restored kernel could do either 1) or 2), I don't see that it matters
much which.  1) might be safer, because it's possible that external power
was turned off at some point during the hibernation (and no battery power 
was available).

Alan Stern
