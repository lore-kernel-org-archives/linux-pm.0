From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH] pda_power: move from timer to delayed_work
Date: Tue, 18 Apr 2017 04:41:20 +0200
Message-ID: <20170418024120.eca2jk2tiehdvxg7@earth>
References: <1492420261-25635-1-git-send-email-michael@amarulasolutions.com>
 <20170417155157.GA12497@kroah.com>
 <20170417162206.GA31411@panicking>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p76fasbo33zwibpp"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754378AbdDRCl1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Apr 2017 22:41:27 -0400
Content-Disposition: inline
In-Reply-To: <20170417162206.GA31411@panicking>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Greg KH <greg@kroah.com>, linux-pm@vger.kernel.org, stable@vger.kernel.org


--p76fasbo33zwibpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 17, 2017 at 06:22:13PM +0200, Michael Trimarchi wrote:
> On Mon, Apr 17, 2017 at 05:51:57PM +0200, Greg KH wrote:
> > On Mon, Apr 17, 2017 at 11:11:01AM +0200, Michael Trimarchi wrote:
> > > This changed is needed to avoid locking problem during
> > > boot as shown:
> > >=20
> > > <5>[    8.824096] Registering SWP/SWPB emulation handler
> > > <6>[    8.977294] clock: disabling unused clocks to save power
> > > <3>[    9.108154] BUG: sleeping function called from invalid context =
at kernel_albert/kernel/mutex.c:269
> > > <3>[    9.122894] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: s=
wapper/0
> > > <4>[    9.130249] 3 locks held by swapper/0/1:
> > > <4>[    9.134613]  #0:  (&__lockdep_no_validate__){......}, at: [<c03=
42430>] __driver_attach+0x58/0xa8
> > > <4>[    9.144500]  #1:  (&__lockdep_no_validate__){......}, at: [<c03=
42440>] __driver_attach+0x68/0xa8
> > > <4>[    9.154357]  #2:  (&polling_timer){......}, at: [<c0053770>] ru=
n_timer_softirq+0x108/0x3ec
> > > <4>[    9.163726] Backtrace:
> > > <4>[    9.166473] [<c001269c>] (dump_backtrace+0x0/0x114) from [<c067=
e5f0>] (dump_stack+0x20/0x24)
> > > <4>[    9.175811]  r6:00203230 r5:0000010d r4:d782e000 r3:60000113
> > > <4>[    9.182250] [<c067e5d0>] (dump_stack+0x0/0x24) from [<c007441c>=
] (__might_sleep+0x10c/0x128)
> > > <4>[    9.191650] [<c0074310>] (__might_sleep+0x0/0x128) from [<c0688=
f60>] (mutex_lock_nested+0x34/0x36c)
> > > <4>[    9.201660]  r5:c02d5350 r4:d79a0c64
> > > <4>[    9.205688] [<c0688f2c>] (mutex_lock_nested+0x0/0x36c) from [<c=
02d5350>] (regulator_set_current_limit+0x30/0x118)
> > > <4>[    9.217071] [<c02d5320>] (regulator_set_current_limit+0x0/0x118=
) from [<c0435ce0>] (update_charger+0x84/0xc4)
> > > <4>[    9.228027]  r7:d782fb20 r6:00000101 r5:c1767e94 r4:00000000
> > > <4>[    9.234436] [<c0435c5c>] (update_charger+0x0/0xc4) from [<c0435=
d40>] (psy_changed+0x20/0x48)
> > > <4>[    9.243804]  r5:d782e000 r4:c1767e94
> > > <4>[    9.247802] [<c0435d20>] (psy_changed+0x0/0x48) from [<c0435dec=
>] (polling_timer_func+0x84/0xb8)
> > > <4>[    9.257537]  r4:c1767e94 r3:00000002
> > > <4>[    9.261566] [<c0435d68>] (polling_timer_func+0x0/0xb8) from [<c=
00537e4>] (run_timer_softirq+0x17c/0x3ec)
> > > <4>[    9.272033]  r4:c1767eb0 r3:00000000
> > > <4>[    9.276062] [<c0053668>] (run_timer_softirq+0x0/0x3ec) from [<c=
004b000>] (__do_softirq+0xf0/0x298)
> > > <4>[    9.286010] [<c004af10>] (__do_softirq+0x0/0x298) from [<c004b6=
50>] (irq_exit+0x98/0xa0)
> > > <4>[    9.295013] [<c004b5b8>] (irq_exit+0x0/0xa0) from [<c000edbc>] =
(handle_IRQ+0x60/0xc0)
> > > <4>[    9.303680]  r4:c1194e98 r3:c00bc778
> > > <4>[    9.307708] [<c000ed5c>] (handle_IRQ+0x0/0xc0) from [<c0008504>=
] (gic_handle_irq+0x34/0x68)
> > > <4>[    9.316955]  r8:000ac383 r7:d782fc3c r6:d782fc08 r5:c11936c4 r4=
:e0802100
> > > <4>[    9.324310] r3:c026ba48
> > > <4>[    9.327301] [<c00084d0>] (gic_handle_irq+0x0/0x68) from [<c068c=
2c0>] (__irq_svc+0x40/0x74)
> > > <4>[    9.336456] Exception stack(0xd782fc08 to 0xd782fc50)
> > > <4>[    9.342041] fc00:                   d6e30e6c ac383627 00000000 =
ac383417 ea19c000 ea200000
> > > <4>[    9.351104] fc20: beffffff 00000667 000ac383 d6e30670 d6e3066c =
d782fc94 d782fbe8 d782fc50
> > > <4>[    9.360168] fc40: c026ba48 c001d1f0 00000113 ffffffff
> > >=20
> > > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > > ---
> > >  drivers/power/supply/pda_power.c | 48 ++++++++++++++++++++++--------=
----------
> > >  1 file changed, 26 insertions(+), 22 deletions(-)
> >=20
> > <formletter>
> >=20
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> > for how to do this properly.
> >=20
> > </formletter>
>=20
> Ok, clear enough and I will read the documentation and proper re-submit i=
t.
> Is it clear enough to have some brief review process on linux-pm?

The patch looks ok to me. Please add a "Fixes:" line as described in
Documentation/process/submitting-patches.rst

-- Sebastian

--p76fasbo33zwibpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlj1fMwACgkQ2O7X88g7
+prXEg//Zv+CIsAtbfa6x3SO0uTi6f40ctO7UjDxyMbs3sJPuzRO2QeaRDujyJLe
eU2tDS2X4NUvoJG/IWAKh+kXRiFnG/Oeih6lG1fajRciylpEKQIMKbHAOmZM3zkK
vTgyRS2xb9b4nhsWJjFnnuzjNu+ZcDnQaanh1i4bF4JrONMp6LLkzB1T666iaz12
EXmHntsPE4ZfphO/levXXCj8eyfuBfu5XPR1WuIRRU9u4W+2hHnDwhNW3H9aWVKW
p1WPUZJqWsRKQVzxJ7tdEpcZKFB7RzFwRRFxLpRWpXyClPD2uLZ2ixjxbl5gn2QX
la2iTTkZrWC3Y43ialaexng5RFYZh2pVlLB0Bvb0ZUwAnuL5Kg4fD2bK0i+L3BBM
eouONPBdxfRGxqUOtO2g034Anb/7BlCaxFMrc7Hc6zYfoHPOBon/jjYh31R3hwdi
RTG7OcbwueD6m33jQBIkRbxLLESyTvVl6byjaU4ps+waoCihyE8EUMH+iXOt9dwp
UM9Y7r2sZlgkkeCnAAQqO6ys1VCwq4+V3KFVhAIy38W2vafzNFEGkC0fFkBwCPvR
zrnEXAcef7Nmr7lYHU7BtjXnPGWS0+mz2gRFC7KNhdkScdsIWK1J4O4ftbv3V8cC
3CWRZywtoRJG6+cmYNLJI77pLVVnK/fgtwn5lkdb+wAOPD7S3Fk=
=LEcX
-----END PGP SIGNATURE-----

--p76fasbo33zwibpp--
