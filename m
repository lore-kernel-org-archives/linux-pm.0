From: David Brownell <david-b@pacbell.net>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Mon, 24 Jul 2006 08:15:04 -0700
Message-ID: <200607240815.05332.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0607241040400.6638-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0607241040400.6638-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Monday 24 July 2006 7:51 am, Alan Stern wrote:
> On Mon, 24 Jul 2006, Rafael J. Wysocki wrote:

> > So, it looks like the core will only need to tell the driver to "resume"
> > with the implicit "go directly to the saved state" meaning and the
> > driver will actually decide what to do.
> =

> And this implies that the meanings of the suspend() and resume() method
> calls are different from what people might normally think.

No ...

> suspend()   =

> doesn't really mean "Put your device into a low-power state"; it means
> "The system is going into a suspend, so remember the device's current
> power state and take whatever actions are appropriate".

Which is exactly what it means today.


> For example, if =

> the device is already in a low-power state then it might be appropriate to
> do nothing at all.

Ditto.


> Likewise, resume() doesn't mean "Change your device to fully ON"; it means
> "The system is waking up from a suspend, so put your device back into
> whatever power state it was in before the suspend occurred".

It means "put it back in a fully operational state".

And whether that state is "full on", or one of the "runtime suspend" states,
or whether it goes into "full on" and then automagically into a "runtime su=
spend",
doesn't matter externally.  And can't even be noticed without test setups
measuring differential power usage between different configurations...


> These meanings may not be entirely consistent with the way the PM core
> works now,

I don't believe any semantic change is being discussed here.


> but to me they make more sense.  To make the core consistent =

> with this approach wouldn't require much of a change.  Basically we just
> have to rip out all the stuff referring to dev->power.power_state, which
> needs to be done anyway.

Considering how few drivers use dev->power.power_state, it's easier to
say the problem is in the ones that use it  ... rather than the ones that
ignore it and act as I've described above! :)

- Dave



> Alan Stern
> =
