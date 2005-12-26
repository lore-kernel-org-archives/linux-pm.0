From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Mon, 26 Dec 2005 18:25:40 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512261806360.10595-100000@netrider.rowland.org>
References: <Pine.LNX.4.50.0512261301090.12383-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============33827401308054617=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0512261301090.12383-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============33827401308054617==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 26 Dec 2005, Patrick Mochel wrote:

> Nevertheless, think about both of the things that we are talking about -
> quiescing the driver and quiescing the device. Both of those things happen
> by unbinding the driver - the driver stops the I/O requests and the device
> is put into a non-talkative state. However, there are other things that
> happen as a side effect, which I think can (and eventually will) produce
> negative results.
> 
> I think that we can achieve the things that we talk about in a simpler
> manner, which will also happen to be more elegant and more efficient.
> Instead of unbinding, what if we simply issued a request to the device to
> halt I/O transactions and put the device in a quiescent state?
> 
> We could call this method ->stop() and put it in struct device_driver.
> Since it is in the core driver structure, it would be filled in and
> intercepted by the different bus driver cores. The USB core would receive
> the call, prevent any future I/O transactions, then call down to the
> (optionally present) driver-specific ->stop().
> 
> [ Of course, it looks good on paper, and you may know some of the nasty
> details of USB that would prevent something like this. ]

In fact I do, although it's not nasty.

With USB interfaces (USB devices too, but we're not concerned with them at 
the moment) _all_ I/O is initiated by the host.  There's no need to send a 
special message to make the interface stop doing I/O; the driver merely 
needs to stop making transfers.

So for USB anyway, your proposed stop() method is redundant.  It would do 
nothing more or less than the suspend() method already does.

(I have ignored matters of long-running device activities that get started
by an I/O request and then keep on going, like playing an audio CD.  For
both stop() and suspend() we would want the driver to cancel all such
ongoing activities.)

There is one question here I'm not clear about.  You suggested that the 
USB core would prevent I/O transactions and then call the driver's method.  
That raises the possibility that some transactions could fail for no good 
reason (as far as the driver can tell).  Alternatively, the core could 
call the method first.  That leaves the possibility of accepting some I/O 
that should have been refused.  It's a race, and I don't know which way 
would be best.

> Then again, you could initially implement this for USB only, then move it
> into the core once we all decide that it makes sense to propogate
> outwards.

I'm not convinced that start() and stop() methods are generally
applicable.  Many drivers do their work only when they have something to
do.  There's no reason ever to stop() a printer driver, for instance --
you just don't send data to that printer.

It's only devices like network interfaces (which go ahead doing work all 
on their own as opposed to when somebody asks for it) that can utilize 
these methods.

Maybe there are good reasons for implementing them with arbitrary devices, 
but I haven't heard any.


> > .)  So now what should we do?
> >
> > 	Require userspace to rmmod usblp before suspending?
> >
> > 	Add suspend and resume methods to usblp, but make it so they
> > 	only cancel outstanding I/O, while relying on usbcore to fail
> > 	any new I/O requests?
> 
> The latter seems to make the most sense - it is partitioning the problem
> between things which are specific to the device (canceling pending I/O,
> assuming that it requires issuing commands to the devices)  and will be
> generic to all like devices (preventing future I/O, assuming that's a
> software flag that is set/checked).
> 
> Because the USB core intercepts and forwards the ->suspend()/->resume()
> calls (and possibly ->start()/->stop()), it has the ability to do any pre-
> and post- work that is generic to all or most devices, which is good
> because it prevents unnecessary duplication of work in the various
> drivers.
> 
> Does that help at all?

Yes, okay, I'll work on doing things that way.

Alan Stern


--===============33827401308054617==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============33827401308054617==--
