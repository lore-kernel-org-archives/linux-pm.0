From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Runtime device power management in userspace
Date: Mon, 26 Dec 2005 12:58:02 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0512261244200.12383-100000@monsoon.he.net>
References: <20051223143047.GC16463@f192.suse.de>
	<Pine.LNX.4.50.0512230706530.13289-100000@monsoon.he.net>
	<20051224153119.GA9721@work.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============59350725752804312=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051224153119.GA9721@work.suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Holger Macht <hmacht@suse.de>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============59350725752804312==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Sat, 24 Dec 2005, Holger Macht wrote:

> On Fr 23. Dez - 07:12:35, Patrick Mochel wrote:

> > How do you determine the idleness of a device? Or, is it based purely on
> > user direction?
>
> That's one of the main problems. For some devices, for instance network
> cards, we can query the NetworkManager (as far as available) via DBus if
> the device is currently in use or not. But we don't have that possiblity
> for all devices. The even more problematic point is the other way
> round. How to figure out if we have to resume a device as soon as another
> application wants to access it? I have currently no clue how to do this.

That is definitely a devlish detail (or rather, several of them). In
general, you want a device to resume as soon as it's needed by an
application. There's no way of knowing this from a 3rd party app, and
there is no way of changing every application to first power up a device.
So, it must happen in the kernel.

Where in the kernel is dependent on the type (class) of device. For some,
it will be on open(2), others will be connect(2), and others will be the
set of read(2)/write(2)/select(2)/poll(2). To this effect, I think that
the individual classes need to be changed to do e.g.

	power_on(dev);

whenever a command that requires hardware access is issued. When that
operation finishes, perhaps it could do e.g.

	power_off(dev);

to start an idle timer that results in the device entering a
pre-determined low-power state (optionally configurable via a per-device
sysfs file).

Note that power_on(dev) would simply cancel the timer if the device wasn't
actually in a low-power state.

Note also that this is beyond having a device enter a user-dictated state,
but will mesh nicely with it. A user-dictated state will cancel the timer
for a device and put it into the low-power state, then it will be woken
automatically once the device is used. (In essence, it would be like
specifying the idle state to enter with a timeout of 0, and have it
trigger immediately..)

Implementing all of this will take time and collaboration with the
different device classes, but I think that this is a direction which most
distros would like to head. Is that even remotely correct?

Any thoughts/ideas on that front?

> > Also, is there source available?
>
> Of course, there is. Tarballs [1] are available at sourceforge. You can
> directly browse the code [2] from the svn webinterface. The corresponding
> source files are device_management.{cpp,h} and device.{cpp,h}.

Cool, thanks. I'll to have a look in the near future.

Thanks,


	Patrick


--===============59350725752804312==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============59350725752804312==--
