From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Re: Hotplug events during sleep transition
Date: Tue, 27 Dec 2005 13:09:53 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0512271300560.4933-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0512242115030.9591-100000@netrider.rowland.org>
	<Pine.LNX.4.50.0512261301090.12383-100000@monsoon.he.net>
	<200512261750.26186.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200512261750.26186.dtor_core@ameritech.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


On Mon, 26 Dec 2005, Dmitry Torokhov wrote:

> On Monday 26 December 2005 16:20, Patrick Mochel wrote:
> > > > =A0Unbinding and
> > > > rebinding do a whole lot more. A device does an entire round trip=
 through
> > > > the driver core, which does a lot of crap. There are several memo=
ry
> > > > allocations, perhaps dozens of sysfs files created, and a handful=
 of locks
> > > > taken adn lists traversed.
> > >
> > > No, you're thinking of unregistering and re-registering a device or
> > > driver. =A0Unbinding and rebinding is much simpler, although still =
somewhat
> > > complex.
> >
> > Ah, point taken; I was thinking that all USB devices were still
> > disconnected during a suspend transition..
> >
>
> Device removal could happen at any point, even during suspend transitio=
n.
> The kernel should be able to handle this scenario therefore implementat=
ion
> that assumes that device tree is frozen in flawed. As far as I understa=
nd
> the only thing that does not work at the moment is invoking hotplug han=
dler.

I don't think that the tree should be assumed to be frozen. I just think
that we should try to avoid doing a full add or remove of a device (or
really, any object) while in a suspend or resume transition.

During normal system operation, how does a USB device get removed? Does i=
t
happen via the USB hub thread? Forgive me for asking a question that's
probably been asked countless times, but is this thread running during a
suspend transition?

Would it be possible to simply mark the device as 'removed' and ignore it
until we resumed, and then clean it up (hotplug events and everything)?

Thanks,


	Patrick
