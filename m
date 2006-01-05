From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Date: Thu, 5 Jan 2006 22:44:32 +0100
Message-ID: <20060105214432.GE2095@elf.ucw.cz>
References: <20060105211446.GD2095@elf.ucw.cz> <Pine.LNX.4.44L0.0601051631200.6460-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752226AbWAEVpK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601051631200.6460-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Scott E. Preece" <preece@motorola.com>, akpm@osdl.org, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On =C4=8Ct 05-01-06 16:37:52, Alan Stern wrote:
> > > And it's not all that complex.  Certainly no more complex than fo=
rcing
> > > userspace tools to use {"on", "D1, "D2", "suspend"} instead of th=
e
> > > much-more-logical {"D0", "D1", "D2", "D3"}.
> >=20
> > It is not much more logical. First, noone really needs D1 and
> > D2. Plus, people want to turn their devices on and off, and don't w=
ant
> > and should not have to care about details like D1.
>=20
> Who are you to say what people really need?  What about people who wa=
nt to=20
> test their PCI device and see if it behaves properly in D1 or D2?  Ho=
w are=20
> they going to do that if you don't let them put it in that state?

> What about people with platform-specific non-PCI devices that have a =
whole
> bunch of different internal power states?  Why force them to use only=
 two
> of those states?

Its okay with me to add more states _when they are needed_. Just now,
many drivers do not even handle system suspend/resume correctly.

> The kernel isn't supposed to prevent people from doing perfectly lega=
l
> things.  The kernel should provide mechanisms to help people do what =
they
> want.

We are not adding random crap to kernel just because "someone may need
it". And yes, having aliases counts as "random crap". Perfectly legal
but totally useless things count as a random crap, too.

Bring example hardware that needs more than two states, implement
driver support for that, and then we can talk about adding more than
two states into core code.

								Pavel
--=20
Thanks, Sharp!
