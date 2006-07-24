From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Mon, 24 Jul 2006 11:42:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0607241128460.6638-100000@iolanthe.rowland.org>
References: <200607240815.05332.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607240815.05332.david-b@pacbell.net>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Mon, 24 Jul 2006, David Brownell wrote:

> On Monday 24 July 2006 7:51 am, Alan Stern wrote:
> > On Mon, 24 Jul 2006, Rafael J. Wysocki wrote:
> =

> > > So, it looks like the core will only need to tell the driver to "resu=
me"
> > > with the implicit "go directly to the saved state" meaning and the
> > > driver will actually decide what to do.
> > =

> > And this implies that the meanings of the suspend() and resume() method
> > calls are different from what people might normally think.
> =

> No ...
> =

> > suspend()   =

> > doesn't really mean "Put your device into a low-power state"; it means
> > "The system is going into a suspend, so remember the device's current
> > power state and take whatever actions are appropriate".
> =

> Which is exactly what it means today.

What I wrote wasn't necessarily intended to be different from what the
methods mean today.  But it _is_ different from what people tend to think.

It's very natural for someone to imagine that suspend() means "Suspend
your device" (i.e., put it in a low-power state) and resume() means
"Resume your device" (i.e., change it to full-power).  But the real
emphasis is different; people need to know that suspend() actually means
"The _system_ is going to suspend" and resume() means "The _system_ is
resuming".

> > Likewise, resume() doesn't mean "Change your device to fully ON"; it me=
ans
> > "The system is waking up from a suspend, so put your device back into
> > whatever power state it was in before the suspend occurred".
> =

> It means "put it back in a fully operational state".
> =

> And whether that state is "full on", or one of the "runtime suspend" stat=
es,
> or whether it goes into "full on" and then automagically into a "runtime =
suspend",
> doesn't matter externally.  And can't even be noticed without test setups
> measuring differential power usage between different configurations...

Yes.  But there's a natural tendency to think that resume() means "Turn it =

to full power", just as there's a natural tendency to think that suspend() =

means "Turn it to minimum power".  The documentation should emphasize that =

this is not what those calls really mean.

> > These meanings may not be entirely consistent with the way the PM core
> > works now,
> =

> I don't believe any semantic change is being discussed here.

There is.  Right now suspend_device() won't call the bus's suspend method
if dev->power.power_state.event is non-zero.  But since the purpose of the
call is to inform the driver that the _system_ is going to suspend, the
call should be made regardless of the _device's_ state (which the core
shouldn't be concerned with anyway).

> Considering how few drivers use dev->power.power_state, it's easier to
> say the problem is in the ones that use it  ... rather than the ones that
> ignore it and act as I've described above! :)

I don't know to what extent there are problems in the drivers.  Not much, =

hopefully.  The real problem lies in the core.

Alan Stern
