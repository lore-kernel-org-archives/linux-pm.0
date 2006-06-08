From: David Brownell <david-b@pacbell.net>
Subject: Re: Information in PM messages
Date: Thu, 8 Jun 2006 12:57:16 -0700
Message-ID: <200606081257.17421.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606071722200.32731-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606071722200.32731-100000@netrider.rowland.org>
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 07 June 2006 2:53 pm, Alan Stern wrote:
> Right now the pm_message structure contains only one member: event.  It =

> tells, in rather generic form, the action a driver is supposed to take =

> upon receiving the message.

I look at it a bit differently.  Drivers have internal state machines,
and the event code is one of the things they use to distinguish which
of the potential "next" states to enter.

(Other factors include which system clocks will be available, what
voltage domains will be active and the specific parameters available
in those domains, what other drivers will be active, state like "is
this network interface marked UP", is this devices allowed to be a
wakeup event source, and so on.)


> It seems to me that when runtime PM is fully supported, drivers will also
> want to know the source of a message.

I don't like this model.  It's like that old programming language joke
idiom "comefrom", which was paired with "goto" in an effort to make
BASIC (or pre-f77 FORTRAN?) code even more cryptic, and highlight the
apple-pie-goodness of Structured Code.


> So there will have to be two pieces =

> of information:
> =

> 	The source, or the reason for the message;
> =

> 	The target, or the desired state or power-level change.

I don't agree that the source should matter.  The target of the
pm_message_t is clearly the device.  But it's the driver which will
take all the facts in hand and deduce the next state ... and like
the available device states, that logic is not knowable outside of
that driver.


> For messages produced by userspace writing to a sysfs attribute file, the =

> source is "the user".

But why should that make a difference?  If it matters, I'd contend
that the reason isn't specifically source, but some other issue.

Also, when a collection of drivers collaborate to manage some aspect
of power (like with USB OTG:  host, peripheral, OTG, and transceiver
drivers may be distinct), I don't think any individual driver should
care whether a request came from userspace or one if its peers.

(And for that matter, I'm fairly sure that userspace should not be
able to bypass/invalidate the agreements such drivers have made with
each other.  I still have truckloads of doubts about this notion that
any userspace power management should think about drivers, rather than
the functionality they expose.)


> When drivers start supporting autosuspend and autoresume, they will want =

> to create PM messages whose source is "the driver".

I don't see why they would...
 =


> Currently hardly any drivers have implemented any serious runtime PM.

Depends what you mean by that term, and what domains you look at.

Lots of drivers for embedded hardware do things like clocking off
everything unless it's in active use.  Or minimizing/eliminating
use of timers, lessening the number of irqs to process.  Or making
"hot" code paths shorter, reducing CPU power demands.  (Etc.)

Agreed that with USB at least we know some good things to do which
we have not yet done ... like autosuspending devices, and thereby
reducing VBUS consumption by factors on the order of 100.  (And
because the functionality is associated with interfaces not devices,
achieving some of those things calls for USB framework updates.)
But this is another case where USB has PM needs that the rest of
the kernel hasn't yet thought about yet.


> When more start doing so, we might want to make explicit the following =

> policy:
> =

> 	A message whose source is USER or DRIVER should not be
> 	allowed to resume a device that was suspended by a message
> 	whose source was SYSTEM.  In other words, runtime PM and
> 	autoresume should not interfere with a system sleep transition.

Why wouldn't that be entirely the driver's responsibility, and
something they don't need API changes to achieve?

A device is in an autosuspend state, ok ... basically, this is
invisible to all code outside the driver.  Then it's told to
suspend(), entering some _different_ state than that autosuspend
state.  A state where autoresume is invalid.  QED, no interference,
just because the driver is written correctly.


> Individual drivers might have requirements of their own, such as this one:
> =

> 	A DRIVER suspend message should fail if the device's remote
> 	wakeup facility is not enabled.
> =

> (Obviously some devices, such as USB hubs, shouldn't autosuspend if they =

> are unable or not permitted to autoresume.  For other devices, such as =

> printers, this wouldn't matter.)

Again, all this can be part of the driver-internal state machine;
you've not shown why it would need to be visible at the pm-core
level (which includes pm_message_t event codes).

- Dave
