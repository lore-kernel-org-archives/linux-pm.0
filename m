From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Runtime device power management in userspace
Date: Tue, 27 Dec 2005 10:59:44 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0512271054350.30915-100000@monsoon.he.net>
References: <20051223143047.GC16463@f192.suse.de>
	<Pine.LNX.4.50.0512230706530.13289-100000@monsoon.he.net>
	<20051224004029.GC16043@elf.ucw.cz>
	<Pine.LNX.4.50.0512261234350.12383-100000@monsoon.he.net>
	<20051226223325.GE1974@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============97881254849161647=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051226223325.GE1974@elf.ucw.cz>
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

--===============97881254849161647==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Mon, 26 Dec 2005, Pavel Machek wrote:

> On Po 26-12-05 12:43:43, Patrick Mochel wrote:
> > > Is there enough locking in driver core to make this safe?
> >
> > The issue I stated is actually orthogonal to locking the device; but the
> > answer to your question is: probably not. We should probably be taking the
> > per-device semaphore to prevent against competing events that are trying
> > to add/remove a device or driver.
>
> Ok, thanks. That means that some races are still there, but they
> probably don't matter for non-hotpluggable stuff like PCI, right?

Well, the semapohre blocks against driver probing and removing, too.

> Noone uses .../power API just now (except Holger :-), so I think we
> can still change it. Currently it is horribly broken -- taking 0/2 and
> passing it directly to pm_message_t.event. I don't think we can solve
> worlds hunger today... but what about at least changing interface so
> that it lists two states ("on" and "suspend") that are more or less
> common to all drivers?

I don't think we want to do something from the core that is common to all
drivers in that area. The PM values and semantics are so different across
that I don't think we could effectively abstract something for everything.

What we could do is remove the file from being added in the core, and have
the PCI core add it for all PCI devices that have PM capabilities and show
all the states that appear in the config space. From there, we could start
adding logic to filter out unsupported states and adding extra states that
the driver supports (that aren't in the config space, assuming that they
exist for some devices).

In short, you're right - we can't solve world hunger, but we should be
able to make some good progress on at  least one continent. Once I'm back
to a development machine (and not a coffee shop wireless connection), I'll
try to cook up a patch..


	Patrick


--===============97881254849161647==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============97881254849161647==--
