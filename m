From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Runtime device power management in userspace
Date: Tue, 27 Dec 2005 12:54:58 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0512271241350.4933-100000@monsoon.he.net>
References: <20051223143047.GC16463@f192.suse.de>
	<Pine.LNX.4.50.0512230706530.13289-100000@monsoon.he.net>
	<20051224153119.GA9721@work.suse.de>
	<Pine.LNX.4.50.0512261244200.12383-100000@monsoon.he.net>
	<20051227200418.GA4769@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============43970956029999281=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051227200418.GA4769@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============43970956029999281==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Tue, 27 Dec 2005, Pavel Machek wrote:

> On Po 26-12-05 12:58:02, Patrick Mochel wrote:
> > On Sat, 24 Dec 2005, Holger Macht wrote:
> > > On Fr 23. Dez - 07:12:35, Patrick Mochel wrote:
> >
> > > > How do you determine the idleness of a device? Or, is it based purely on
> > > > user direction?
> > >
> > > That's one of the main problems. For some devices, for instance network
> > > cards, we can query the NetworkManager (as far as available) via DBus if
> > > the device is currently in use or not. But we don't have that possiblity
> > > for all devices. The even more problematic point is the other way
> > > round. How to figure out if we have to resume a device as soon as another
> > > application wants to access it? I have currently no clue how to do this.
> >
> > That is definitely a devlish detail (or rather, several of them). In
> > general, you want a device to resume as soon as it's needed by an
> > application. There's no way of knowing this from a 3rd party app, and
> > there is no way of changing every application to first power up a device.
> > So, it must happen in the kernel.
>
> While we want to implement that someday, we should fix the easy stuff.

Please see below.

> > Where in the kernel is dependent on the type (class) of device. For some,
> > it will be on open(2), others will be connect(2), and others will be the
> > set of read(2)/write(2)/select(2)/poll(2). To this effect, I think that
> > the individual classes need to be changed to do e.g.
>
> And for some, it is not possible to keep them functional and powered
> down. Take ethernet interface: if you power it down, you'll not see
> incoming packets.

That's a valid point, but that doesn't invalidate the concept for other
types of devices.

> > Implementing all of this will take time and collaboration with the
> > different device classes, but I think that this is a direction which most
> > distros would like to head. Is that even remotely correct?
>
> Would like to head is correct... but that's year+ away. For now, we'd
> like to get the simpler "power this piece of hardware down, return
> errors to userspace", first.

I'm not talking about now or talking about the easy stuff, I'm talking
about the future and about the hard stuff. It's been evident that we need
a better and more structured solution to the entire scheme for quite some
time.

If it takes a year+, then it takes a year+. But, the important thing is
that we have the discussion. And, while you've probably been involved in
internal discussions about powersave with its developers, it's the first
time that I've interacted with them publically, and I'm very interested in
what they have to say.. :-)

> Example usage is... you are traveling by train, so you know you are
> not using ethernet and wifi... so you just force it down.

That's on ifdown(1), and that's probably the right place to implement the
network-based PM. What system calls does that translate to? Are they only
netdev-based ioctls?

Thanks,


	Patrick

--===============43970956029999281==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============43970956029999281==--
