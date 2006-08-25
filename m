From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 25 Aug 2006 15:57:15 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5074D0573@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
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
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

> ?  Wouldn't suspending the entire bus completely stop the throughput
of
> any attached device?

Not necessarily (right?).  If I shut off VBUS then yes then I need to
re-enumerate for sure.  One might figure out a cleaver way of shutting
it off and turning it back on in between host requests.  If I have a USB
drive attached it might well be the protocol layers are smart enough
keep using the device once it is restarted at the low layers.  They just
have to wait longer for the data to arrive.

If I just do USB bus suspend the device at the other end can signal
remote wake up to me.  I tell him suspend and he agrees to drop to a low
power state, then I lower current capacity.  When he has some data he
can let me know and I'll up the VBUS current capacity and then go talk
to him.  If I have data I want from him I directly wake him up.

In both cases the extra overhead causes my throughput to drop, but I
still have an effective connection to the device.

At the PM summit Len made a nice observation that you can map all the
processor ACPI-States right to devices.  You can have T states with them
if you 'throttle' them (slow down their clock).  You can have P states
with voltage/frequency changes.  And you can have C-states (1,2,3) by
shutting down devices in-between accesses, etc.  You can likely have a
single state representation which covers processors and devices.  You
might even implement 'race to idle' conditions at the devices.  Get the
work done then shut off to as low a state as you can and still have
acceptable latency.  This was what sparked the 'on-ness' discussion a
while back on this list.

 =

> > The frequency of entering this state should not interfere with my
active
> > use case.
> >
> > -B- After I've put down the USB device, I now can program the
internal
> > SOC bus wrapper for the USB to allow idling of the interconnect.  I
also
> > need to associate the USB remote wake interrupt with a wake up
interrupt
> > to restart my interconnect.  All devices on that interconnect must
be in
> > the same state for the big savings to happen.
> >
> > Certainly for this embedded system, not coordinating the device
states
> > means I can't get the big power savings.
> =

> Part of this programming has to be done in the architecture-specific
> driver for the interconnect.  There already is code being developed to
> suspend USB buses when they aren't in use (although determining _when_
> they aren't in use has not yet been implemented).  However this code
stops
> at the level of the USB controller.  Further development is being
stymied
> by lack of information about how to detect the controller's wake-up
events
> on regular desktop systems; it's possible someone might implement this
> first on an embedded platform.

That seems possible.

> But this doesn't require any over-reaching global coordination.  All
it
> needs is for each driver to know when it's not being used.

Applying an activity time of sorts to each driver 'might' end up in
situations where you get good power savings.  Assuming everything lines
up.  However, given hardware and software bugs and errata, it seems
forcing the situation is much more likely to succeed and make sure you
hit your targets.

Even with a per-driver activity timer how does one set the time out
levels for the whole system?  You need some kind of policy pieces to set
all the knobs.  Letting the self adjust won't likely work for QOS
(quality of service type things) unless they are set very
conservatively.

Thanks,
Richard W.
