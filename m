From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Re: Hotplug events during sleep transition
Date: Mon, 26 Dec 2005 13:20:53 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0512261301090.12383-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0512242115030.9591-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============37439364757489102=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512242115030.9591-100000@netrider.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============37439364757489102==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Sat, 24 Dec 2005, Alan Stern wrote:

> On Fri, 23 Dec 2005, Patrick Mochel wrote:
>
> > > > So why not fix the subsystems to do the equivalent of an unbinding, from
> > > > a tear-down and reinitialization standpoint? That way, you don't have to
> > > > force the core to contort itself simply for the fact that you want to push
> > > > in a thumbtack with a sledgehammer?
> > >
> > > That sounds very dangerous.  You would end up with a situation where the
> > > driver thinks it has been unbound but the core thinks it is still bound.
> > > Not to mention that some drivers, as part of their unbind routines, unbind
> > > themselves from other interfaces -- these would be true, actual
> > > unbindings.
> >
> > What? No, you are trying to make it sound way more complicated than it
> > needs to be. I didn't say anything about unbinding -
>
> I can't resist pointing out that you _did_ say, just above: "So why not
> fix the subsystems to do the equivalent of an unbinding...".

Fair enough. :)

> The way you wrote this indicates you don't understand the problem we're
> trying to solve, so I'd better explain more fully.
>
> We're not worried about quiescing the device, putting it to bed, or
> whatever.  That will happen just fine, all by itself.
>
> The problem is that the _driver_ needs to be quiesced.  It shouldn't try
> to do any I/O during a system sleep.  Partly because any attempted I/O
> will fail once the USB device has been suspended, partly because during a
> short time interval (between suspending the USB interface and suspending
> the USB device) the I/O will succeed but still shouldn't occur, and partly
> because the attempt will leave the driver in a not-well-defined error
> state.
>
> Now perhaps things aren't quite so strict.  With many drivers it might be
> okay to let them deal with I/O failures.  It's not elegant, though.
>
> > Because all you want to do is stop and start the device.
>
> Stop and start the _driver_, not the device.  But maybe you regard those
> two phrases as meaning the same thing.

Basically. I understand your points, and I think that we were talking
about slightly different points.

Nevertheless, think about both of the things that we are talking about -
quiescing the driver and quiescing the device. Both of those things happen
by unbinding the driver - the driver stops the I/O requests and the device
is put into a non-talkative state. However, there are other things that
happen as a side effect, which I think can (and eventually will) produce
negative results.

I think that we can achieve the things that we talk about in a simpler
manner, which will also happen to be more elegant and more efficient.
Instead of unbinding, what if we simply issued a request to the device to
halt I/O transactions and put the device in a quiescent state?

We could call this method ->stop() and put it in struct device_driver.
Since it is in the core driver structure, it would be filled in and
intercepted by the different bus driver cores. The USB core would receive
the call, prevent any future I/O transactions, then call down to the
(optionally present) driver-specific ->stop().

[ Of course, it looks good on paper, and you may know some of the nasty
details of USB that would prevent something like this. ]

Then again, you could initially implement this for USB only, then move it
into the core once we all decide that it makes sense to propogate
outwards.

> >  Unbinding and
> > rebinding do a whole lot more. A device does an entire round trip through
> > the driver core, which does a lot of crap. There are several memory
> > allocations, perhaps dozens of sysfs files created, and a handful of locks
> > taken adn lists traversed.
>
> No, you're thinking of unregistering and re-registering a device or
> driver.  Unbinding and rebinding is much simpler, although still somewhat
> complex.

Ah, point taken; I was thinking that all USB devices were still
disconnected during a suspend transition..

> At this point I'm starting to feel like the proverbial
> "man-in-the-middle".  Recently I submitted a patch adding suspend/resume
> support to the usblp driver.  Greg objected to it because it added
> explicit checks for whether the driver was suspended before starting up
> I/O operations.  He said that such checks did not belong in USB drivers,
> they belonged in the USB core.  (You can read his original comments in
>
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=113418897301873&w=2
>
> .)  So now what should we do?
>
> 	Require userspace to rmmod usblp before suspending?
>
> 	Add suspend and resume methods to usblp, but make it so they
> 	only cancel outstanding I/O, while relying on usbcore to fail
> 	any new I/O requests?

The latter seems to make the most sense - it is partitioning the problem
between things which are specific to the device (canceling pending I/O,
assuming that it requires issuing commands to the devices)  and will be
generic to all like devices (preventing future I/O, assuming that's a
software flag that is set/checked).

Because the USB core intercepts and forwards the ->suspend()/->resume()
calls (and possibly ->start()/->stop()), it has the ability to do any pre-
and post- work that is generic to all or most devices, which is good
because it prevents unnecessary duplication of work in the various
drivers.

Does that help at all?

Thanks,


	Patrick


--===============37439364757489102==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============37439364757489102==--
