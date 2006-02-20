From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Re: [RFC][PATCH] swsusp: warn about USB devices in
	documentation
Date: Mon, 20 Feb 2006 12:13:21 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0602201151350.13570-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0602201421370.28136-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============23765196227338525=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0602201421370.28136-100000@netrider.rowland.org>
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
Cc: Linux PM <linux-pm@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============23765196227338525==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Mon, 20 Feb 2006, Alan Stern wrote:

> On Mon, 20 Feb 2006, Patrick Mochel wrote:
>
> > > > > Does swsusp still support these not-completely-powered-off modes?
> > > >
> > > > Yes. echo platform > /sys/power/disk.
> > >
> > > So if you did that, you could suspend-to-disk while leaving USB up, right?
> > > Without anything being wrong with the machine.
> >
> > No, not likely. S4 is +/- equivalent to a "soft off", except that it
> > responds to more wake-up events than a soft off will (which BTW is defined
> > as "S5").
>
> Does it respond to USB wakeup events (like plugging in a new device)?

It depends on the platform - whether or not they provide any power at all,
and whether or not they implemented the GPE plumbing for it.

> > Even S3 will power down all of the PCI buses, including the USB host
> > controllers. The chances of having any low-power system state that will
> > still power the USB ports (by design) is pretty slim.
>
> Here is a counterexample from Kyle Moffet
> (<http://marc.theaimsgroup.com/?l=linux-kernel&m=113980955219914&w=2>):
>
> 	Let me bring up the example of my PowerBook again.  It's RAM is
> 	fully powered right now, running from battery, and it has another
> 	couple days of sleep- charge left before I have to worry about
> 	plugging it in again.  When I open it, the firmware automatically
> 	powers up the CPU and other hardware and returns control to the
> 	OS.  I can _also_ trigger it to wake by leaving it closed and
> 	connecting an external VGA and USB (it wakes every time I connect
> 	a USB, but my suspend script puts it to sleep again if it's closed
> 	and has no external VGA).

No surpirse there - that's the behavior most would expect, and Apple seems
pretty good about implementing things along those lines.

> There's a difference between powering-down and turning off completely.
> The USB suspend-power-budget per attached port is 500 uA at 5 V, which
> amounts to 2.5 mW.  While that's more than you need to keep RAM alive,
> it's not a tremendous amount.  And most devices probably use less power
> when suspended than this maximum.
>
> The EHCI specification includes a lot of very careful language about which
> portions of the controller should be attached to which power well.  It's
> quite clear that most of the controller's circuitry can be turned off
> while still supplying enough suspend power to keep the bus alive and
> enable wakeup events.
>
> And if the computer can wake up in response to USB events, then obviously
> the USB controller _is_ receiving some power.

True, and I apologize if I misunderstood your initial question. By "up", I
thought you meant fully powered and functional.

But yes, the USB ports may receive enough power to recognize a wakeup plug
event, but it does ultimately depend on the platform and what they choose
to implement.

On x86 platforms, ther is no definitive answer. The ACPI spec mentions it
(section A.2.5), but does not require it. Windows might require that
feature, and if they do, that will make it more common on x86 platforms..


	Pat

--===============23765196227338525==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============23765196227338525==--
