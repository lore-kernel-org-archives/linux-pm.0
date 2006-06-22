From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 22 Jun 2006 12:17:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606221205220.8121-100000@iolanthe.rowland.org>
References: <1150946591.947.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150946591.947.56.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, 22 Jun 2006, Benjamin Herrenschmidt wrote:

> On Wed, 2006-06-21 at 19:21 -0700, David Brownell wrote:
> > On Wednesday 21 June 2006 5:15 pm, Benjamin Herrenschmidt wrote:
> > >		Additionally, as I explained earlier, it
> > > will make everybody's life MUCH easier (especially USB) if we define
> > > that between prepare() and finish(), no hotplug activity takes place
> > > (the bus drivers just basically ignore devices being plugged in during
> > > that phase, or if they can't completely ignore them, at least just le=
ave
> > > a bit somewhere "need to come back on resume look what's going on
> > > here").
> > =

> > In the USB case, you're basically saying that prepare() should freeze
> > khubd.  I think you've implied elsewhere that not all kernel tasks
> > should be frozen at that time, though.
> =

> Yes, but I'm saying that it will just make life easier to everybody if
> we define that we don't get new devices in while we are in the
> suspend/resume process. Don't you agree ?

It's not so simple as just freezing khubd.  Devices can be created and
destroyed in responsing to requests from userspace (e.g., writing to
/sys/.../bConfigurationValue).  It's not at all clear to me how we could
reliably prevent or delay such requests.  Right now we rely on userspace
and khubd _both_ being frozen.

Perhaps the best answer is to require callers to lock the parent device
when creating or removing a child (USB does this already).  Under the
assumption that you'll never want to create or remove a child of an
already-suspended parent, things should be okay.  The PM core _should_ be
able to handle a device being added or removed while some parts of
the system are suspended or frozen, just so long as the actual parent is
still awake.  Uevents can safely be queued until userspace is unfrozen or =

otherwise able to process them.

I'm concerned about remote wakeup events arriving at inconvenient times
during STR or STD.  Sometimes you might want them to abort the suspend,
sometimes you might want to just drop them, and sometimes you might want
them to wake the system up right after it goes to sleep.  It would be nice
to get this straightened out.

Alan Stern
