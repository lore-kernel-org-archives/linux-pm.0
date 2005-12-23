From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 23 Dec 2005 13:32:15 -0500
Message-ID: <200512231332.16777.dtor_core@ameritech.net>
References: <Pine.LNX.4.44L0.0512231018040.15462-100000@netrider.rowland.org>
	<Pine.LNX.4.50.0512230722510.19327-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0512230722510.19327-100000@monsoon.he.net>
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
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Friday 23 December 2005 10:35, Patrick Mochel wrote:
> > > Quite often unbinding is easiest and also correct way. I would love=
 to be
> > > able to just unbind serio port/input device and have it recreated l=
ater.
> > > Unfortunately X/GPM do not [yet?] support hotplugging of devices so=
 kernel
> > > has to compensate.
> >
> > I agree with Dmitry. =A0Many drivers don't need to do anything specia=
l for
> > suspend, or only need to cancel an outstanding input request. =A0Rath=
er than
> > go through every single driver and add a minimal (and possibly errone=
ous)
> > suspend routine, it's much easier just to unbind these drivers.
>=20
> So why not fix the subsystems to do the equivalent of an unbinding, fro=
m
> a tear-down and reinitialization standpoint? That way, you don't have t=
o
> force the core to contort itself simply for the fact that you want to p=
ush
> in a thumbtack with a sledgehammer?
>=20
> Think about what is happening. It's been discovered that shutting down =
the
> device and reinitializing the device performs all the correct actions t=
o
> get the device up and running again after a suspend/resume cycle. All y=
ou
> have to do for each suspend routine is mimic that effect. It arguably
> doesn't require any serious knowledge about the device - it only needs =
a
> copy of the ->probe() and ->remove() routines (or the functional
> equivalent for those devices), without the allocation and freeing of da=
ta
> structures.

That's all good except that it overly complicates things. Look for exampl=
e
at psmouse driver - it can't just reinitialize the hardware, it also has =
to
make sure that device connected to the port is the same device there was
before suspending. And if it is not the same we still have to go though
deardown and re-creating input device to make sure that it reports correc=
t
capabilities to userspace. Again, I would _love_ just to unbind the drive=
r
and have it bind again after resume.

"Full" resume is only required when you have to maintain full state of th=
e
device in question (like a drive may have outstanding requests to complet=
e).
With some devices we can safely drop all outstanding requests.

--=20
Dmitry
