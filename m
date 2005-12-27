From: Pavel Machek <pavel@suse.cz>
Subject: Re: Runtime device power management in userspace
Date: Tue, 27 Dec 2005 20:41:00 +0100
Message-ID: <20051227194100.GL1822@elf.ucw.cz>
References: <20051223143047.GC16463@f192.suse.de>
	<Pine.LNX.4.50.0512230706530.13289-100000@monsoon.he.net>
	<20051224004029.GC16043@elf.ucw.cz>
	<Pine.LNX.4.50.0512261234350.12383-100000@monsoon.he.net>
	<20051226223325.GE1974@elf.ucw.cz>
	<Pine.LNX.4.50.0512271054350.30915-100000@monsoon.he.net>
	<20051227192254.GJ1822@elf.ucw.cz>
	<20051227192956.GA10704@digitalimplant.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20051227192956.GA10704@digitalimplant.org>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On =DAt 27-12-05 11:29:56, Patrick Mochel wrote:
> On Tue, Dec 27, 2005 at 08:22:54PM +0100, Pavel Machek wrote:
>=20
> > I don't really think we want complexity of putting PCI device into
> > D0/D1/D2/D3hot/D3cold. All that userspace should care about is device
> > working/device suspended, and we could not test all 5 states, anyway.
>=20
> What do you mean?=20
>=20
> The devices and drivers should support various states, and that's the
> whole point of having multiple states - to make a choice based on the
> power saving required vs. the latency requirements of bringing it back.
>=20
> Granted, for most things, the latency to return from D3 (hot only, cold
> is irrelevant during runtime) is not going to be noticable, so that's
> probably the only state most devices will ever enter.=20

Exactly. And for these "most devices", having to test/debug/support
D1/D2 is not worth the effort.

> But, in some cases, peple are going to care about the intermediate
> states, and we'll need to support them. It's simple enought to know
> what states a PCI device supports, so I don't understand where the
> complexity comes in.. ?

Someone has to test all that... Unless we have in-tree driver that
wants use intermediate states, I think supporting them is bad idea.

								Pavel
--=20
Thanks, Sharp!
