From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 23 Jun 2006 08:30:39 +1000
Message-ID: <1151015439.4046.30.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606221205220.8121-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606221205220.8121-100000@iolanthe.rowland.org>
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
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


> It's not so simple as just freezing khubd.  Devices can be created and
> destroyed in responsing to requests from userspace (e.g., writing to
> /sys/.../bConfigurationValue).  It's not at all clear to me how we could
> reliably prevent or delay such requests.  Right now we rely on userspace
> and khubd _both_ being frozen.

You can easily deal with userspace by either error'ing out when in
suspend or by blocking in the write to sysfs until resume.

> Perhaps the best answer is to require callers to lock the parent device
> when creating or removing a child (USB does this already).  Under the
> assumption that you'll never want to create or remove a child of an
> already-suspended parent, things should be okay.  The PM core _should_ be
> able to handle a device being added or removed while some parts of
> the system are suspended or frozen, just so long as the actual parent is
> still awake.  Uevents can safely be queued until userspace is unfrozen or =

> otherwise able to process them.

But that means that you'll end up with potentially a new device inserted
that will be awake, the driver will not have had prepare() nor suspend()
called and the machine will go to sleep...

Then there is the problem of those hotplug events that can't be handled
during the suspend process

etc..

I think it's sane to just forbid/block insertion of new devices during
suspend. Will make life easier for everybody.

> I'm concerned about remote wakeup events arriving at inconvenient times
> during STR or STD.  Sometimes you might want them to abort the suspend,
> sometimes you might want to just drop them, and sometimes you might want
> them to wake the system up right after it goes to sleep.  It would be nice
> to get this straightened out.

It's not even clear to me that there is not a race in HW with wakeup
events in that case. I'd put that problem far beyond just getting a
stable suspend/resume process though right now on the priority list.

Ben.
