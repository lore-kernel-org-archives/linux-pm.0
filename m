From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 22 Jun 2006 16:31:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606221621230.5772-100000@iolanthe.rowland.org>
References: <200606221127.08327.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606221127.08327.david-b@pacbell.net>
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
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, 22 Jun 2006, David Brownell wrote:

> > 	 The PM core _should_ be
> > able to handle a device being added or removed while some parts of
> > the system are suspended or frozen, just so long as the actual parent is
> > still awake.  Uevents can safely be queued until userspace is unfrozen =
or =

> > otherwise able to process them.
> =

> Fixing that involves updating pm core locking, ISTR.  I've thought that
> the root cause of the issue is that the list of devices to be suspended
> is created at the wrong time ... very early and globally scoped, not
> on-demand and privately scoped.

I believe this has been fixed for quite a while.  The list of devices to
be suspended is persistent and is maintained over the lifetime of the
system (devices are added during device_add and removed during
device_del).  That way the ordering is automatically correct; suspend
works from the end of the list to the start and resume goes from the start
to the end.  Thus devices are suspended in the opposite order of discovery =

and resumed in the order of discovery.

The difficulty you remember was the mutual exclusion between the
list-walking in suspend/resume vs. actually modifying the list.  That now
works okay, so long as nobody tries to add a child to a suspended parent.


> > I'm concerned about remote wakeup events arriving at inconvenient times
> > during STR or STD.  Sometimes you might want them to abort the suspend,
> > sometimes you might want to just drop them, and sometimes you might want
> > them to wake the system up right after it goes to sleep.  It would be n=
ice
> > to get this straightened out.
> =

> Well, wakeup events in general, not just USB ones.  They can be the same
> as regular IRQs ... which seems to suggest that driver-specific coding may
> be needed.

Maybe.  Also to be considered is the fact that much of wakeup handling has =

to take place in a process context, so once everything is frozen it can't =

happen.  (Depending on which kernel threads remain unfrozen, of course.  I =

don't know whether keventd in particular should be frozen, or even whether =

it gets frozen currently.)

Alan Stern
