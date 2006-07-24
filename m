From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Mon, 24 Jul 2006 10:51:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0607241040400.6638-100000@iolanthe.rowland.org>
References: <200607241146.21709.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607241146.21709.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Mon, 24 Jul 2006, Rafael J. Wysocki wrote:

> > > > 	Upon resuming from a system suspend, is it better to tell the
> > > > 	driver to "go directly to the saved state" or to turn the
> > > > 	device back fully ON and then change to the saved state (if it =

> > > > 	wasn't fully ON before the system suspend)?
> > > =

> > > I think the rule should be "go directly to the saved state", if possi=
ble.
> > =

> > Agreed, though as I described above it's not something that can be
> > detected outside of that driver without actually measuring the power
> > drain that driver imposes on the system.
> =

> And that would be difficult if not impossible.
> =

> So, it looks like the core will only need to tell the driver to "resume"
> with the implicit "go directly to the saved state" meaning and the
> driver will actually decide what to do.

And this implies that the meanings of the suspend() and resume() method
calls are different from what people might normally think.  suspend()  =

doesn't really mean "Put your device into a low-power state"; it means
"The system is going into a suspend, so remember the device's current
power state and take whatever actions are appropriate".  For example, if
the device is already in a low-power state then it might be appropriate to
do nothing at all.

Likewise, resume() doesn't mean "Change your device to fully ON"; it means
"The system is waking up from a suspend, so put your device back into
whatever power state it was in before the suspend occurred".

These meanings may not be entirely consistent with the way the PM core
works now, but to me they make more sense.  To make the core consistent
with this approach wouldn't require much of a change.  Basically we just
have to rip out all the stuff referring to dev->power.power_state, which
needs to be done anyway.

Alan Stern
