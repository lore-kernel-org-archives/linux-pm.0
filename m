From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 22 Jun 2006 11:27:07 -0700
Message-ID: <200606221127.08327.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606221205220.8121-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606221205220.8121-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday 22 June 2006 9:17 am, Alan Stern wrote:
> > > =

> > > In the USB case, you're basically saying that prepare() should freeze
> > > khubd.  I think you've implied elsewhere that not all kernel tasks
> > > should be frozen at that time, though.
> > =

> > Yes, but I'm saying that it will just make life easier to everybody if
> > we define that we don't get new devices in while we are in the
> > suspend/resume process. Don't you agree ?
> =

> It's not so simple as just freezing khubd.  Devices can be created and
> destroyed in responsing to requests from userspace (e.g., writing to
> /sys/.../bConfigurationValue).  It's not at all clear to me how we could
> reliably prevent or delay such requests.  Right now we rely on userspace
> and khubd _both_ being frozen.

Good point.


> 	 The PM core _should_ be
> able to handle a device being added or removed while some parts of
> the system are suspended or frozen, just so long as the actual parent is
> still awake.  Uevents can safely be queued until userspace is unfrozen or =

> otherwise able to process them.

Fixing that involves updating pm core locking, ISTR.  I've thought that
the root cause of the issue is that the list of devices to be suspended
is created at the wrong time ... very early and globally scoped, not
on-demand and privately scoped.  That interacts with runtime device suspend
too as you'll recall ... pmcore can't do the tree suspend stuff except
during system suspend, since that's the only time a global list could
be correct.


> I'm concerned about remote wakeup events arriving at inconvenient times
> during STR or STD.  Sometimes you might want them to abort the suspend,
> sometimes you might want to just drop them, and sometimes you might want
> them to wake the system up right after it goes to sleep.  It would be nice
> to get this straightened out.

Well, wakeup events in general, not just USB ones.  They can be the same
as regular IRQs ... which seems to suggest that driver-specific coding may
be needed.

- Dave
