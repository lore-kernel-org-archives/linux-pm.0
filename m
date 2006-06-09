From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Information in PM messages
Date: Fri, 9 Jun 2006 00:10:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606082332150.28243-100000@netrider.rowland.org>
References: <200606081257.17421.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606081257.17421.david-b@pacbell.net>
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

On Thu, 8 Jun 2006, David Brownell wrote:

> On Wednesday 07 June 2006 2:53 pm, Alan Stern wrote:
> > Right now the pm_message structure contains only one member: event.  It =

> > tells, in rather generic form, the action a driver is supposed to take =

> > upon receiving the message.
> =

> I look at it a bit differently.  Drivers have internal state machines,
> and the event code is one of the things they use to distinguish which
> of the potential "next" states to enter.

That's pretty much the same as what I said.  Granted, the message sent by =

the PM core is subject to interpretation by the driver.  It has to be, =

given that it is generic.

> > It seems to me that when runtime PM is fully supported, drivers will al=
so
> > want to know the source of a message.
> =

> I don't like this model.  It's like that old programming language joke
> idiom "comefrom", which was paired with "goto" in an effort to make
> BASIC (or pre-f77 FORTRAN?) code even more cryptic, and highlight the
> apple-pie-goodness of Structured Code.

I don't think your analogy is valid.  There are many situations where =

requests are accompanied by priority codes; this is not very different.  =

System-sleep transitions are high-priority requests; runtime-PM requests =

are lower priority.


> > So there will have to be two pieces =

> > of information:
> > =

> > 	The source, or the reason for the message;
> > =

> > 	The target, or the desired state or power-level change.
> =

> I don't agree that the source should matter.  The target of the
> pm_message_t is clearly the device.  But it's the driver which will
> take all the facts in hand and deduce the next state ... and like
> the available device states, that logic is not knowable outside of
> that driver.

Parts of that logic _should_ be knowable outside of the driver.  For
instance, all drivers should obey this rule: "When a device has been
suspended as part of a system-sleep transition, its driver should not
resume the device before the system starts to wake up."


> > For messages produced by userspace writing to a sysfs attribute file, t=
he =

> > source is "the user".
> =

> But why should that make a difference?  If it matters, I'd contend
> that the reason isn't specifically source, but some other issue.

Perhaps you'd prefer to call it the priority?

In particular, here is an important difference: Autoresume _is not_
allowed when a device has been suspended for a system-sleep transition.  =

It _is_ allowed when a device has been suspended because of a runtime-PM
request from userspace.  Drivers cannot obey this rule unless they can
tell apart system-sleep suspend requests from runtime-PM suspend requests.


> (And for that matter, I'm fairly sure that userspace should not be
> able to bypass/invalidate the agreements such drivers have made with
> each other.

I never said it should.

>  I still have truckloads of doubts about this notion that
> any userspace power management should think about drivers, rather than
> the functionality they expose.)

I haven't said anything about userspace PM tools thinking about drivers.  =

All I said was that the information exported/imported through sysfs should
be defined by the individual bus and device drivers.  How can you disagree
with that?


> > When drivers start supporting autosuspend and autoresume, they will wan=
t =

> > to create PM messages whose source is "the driver".
> =

> I don't see why they would...

For internal use.  At some point in the code, most or all of the resume =

pathways in a driver will converge.  Beyond that point, the driver might =

still want to know whether a particular resume request is part of a system =

wake-up transition as opposed to an autoresume.  Packaging that =

information within the PM message itself is a very convenient way of =

presenting it.


> > When more start doing so, we might want to make explicit the following =

> > policy:
> > =

> > 	A message whose source is USER or DRIVER should not be
> > 	allowed to resume a device that was suspended by a message
> > 	whose source was SYSTEM.  In other words, runtime PM and
> > 	autoresume should not interfere with a system sleep transition.
> =

> Why wouldn't that be entirely the driver's responsibility, and
> something they don't need API changes to achieve?
> =

> A device is in an autosuspend state, ok ... basically, this is
> invisible to all code outside the driver.  Then it's told to
> suspend(), entering some _different_ state than that autosuspend
> state.  A state where autoresume is invalid.  QED, no interference,
> just because the driver is written correctly.

It sounds like you did not understand what I wrote.  You talk about a
situation where a device in autosuspend is told to enter system-sleep.  =

But I was talking about the situation where a device in system-sleep is
told to autoresume.  No driver should allow such an autoresume to succeed.  =

On the other hand, when a device in runtime suspend is told to autoresume
the request _should_ succeed.  How is the driver supposed to know whether
a suspended device is in system sleep vs. runtime suspend?

Or suppose a suspended device receives a runtime-PM resume request.  =

Should the request succeed?  Yes if the device was suspended via =

runtime PM, no if the device was suspended via system sleep.  How does the =

driver know which?


> > Individual drivers might have requirements of their own, such as this o=
ne:
> > =

> > 	A DRIVER suspend message should fail if the device's remote
> > 	wakeup facility is not enabled.
> > =

> > (Obviously some devices, such as USB hubs, shouldn't autosuspend if the=
y =

> > are unable or not permitted to autoresume.  For other devices, such as =

> > printers, this wouldn't matter.)
> =

> Again, all this can be part of the driver-internal state machine;
> you've not shown why it would need to be visible at the pm-core
> level (which includes pm_message_t event codes).

All right, I admit that drivers can tell on their own which requests are =

auto-generated and which come from outside.  This doesn't alter the fact =

that drivers do need to be able to distinguish system-level =

state-transition requests from runtime-PM user requests.  Currently they =

can't.

Once you agree that this distinction is necessary, there's no reason not =

to allow also the ability to distinguish auto-generated requests.

Alan Stern
