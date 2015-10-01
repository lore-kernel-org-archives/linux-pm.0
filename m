From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Thu, 1 Oct 2015 12:58:49 -0500
Message-ID: <20151001175849.GH4469@saruman.tx.rr.com>
References: <cover.1443057229.git.baolin.wang@linaro.org>
 <e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org>
 <20151001172932.GG4469@saruman.tx.rr.com>
 <20151001174308.GL12635@sirena.org.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2nTeH+t2PBomgucg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51524 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbbJAR7f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 13:59:35 -0400
Content-Disposition: inline
In-Reply-To: <20151001174308.GL12635@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org

--2nTeH+t2PBomgucg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 01, 2015 at 06:43:08PM +0100, Mark Brown wrote:
> On Thu, Oct 01, 2015 at 12:29:32PM -0500, Felipe Balbi wrote:
>=20
> > Frankly, I wanted all of this to be decided in userland with the
> > kernel just providing notification and basic safety checks (we don't
> > want to allow a bogus userspace daemon frying anybody's devices).
>=20
> What's the advantage of pushing this to userspace?  By the time we
> provide enough discoverability to enable userspace to configure itself
> it seems like we'd have enough information to do the job anyway.

you're going to be dealing with a setup where each vendor does one thing
differently. Some will have it all in the SoC part of a single IP (dwc3 can=
 be
configured that way), some will push it out to companion IC, some might eve=
n use
some mostly discrete setup and so on...

We're gonna be dealing with a decision that involves information from multi=
ple
subsystems (USB, regulator, hwmon, power supply to name a few).

We tried doing it all in the kernel back in N800, N810 and N900/N9 days and=
 it's
just plain difficult. To make matters worse, N900 had two USB PHYs, one for
actual runtime use and another just for detecting the charger type on the o=
ther
end.

On top of all that, we still need to figure out what to do when a particular
configuration gets chosen, and what to do when the bus goes into the differ=
ent
suspend levels.

It's going to be a lot of policy getting added to the kernel. On top of all
that, when Type C and power delivery is finally a thing, there will an enti=
re
new stack for USB C commands (using the Type C CC pins or modulated on VBUS=
 for
legacy connectors) which we will have to add to the kernel. And different
devices will support different charging profiles (there are at least 6 of t=
hose,
IIRC).

With all these different things going on, it's best to do what e.g. NFC fol=
ks
did. Just a small set of hooks in the kernel, but actual implementation don=
e by
a userspace daemon. This makes it even easier for middleware development si=
nce
we can provide a higher level API for middleware to talk to the charging da=
emon.

Another benefit is that this charging daemon can also give hints to power
management policy that e.g. we're charging at 10W or 100W and we can e.g. s=
witch
to performance governor safely even though battery is rather low.

Anyway, there's really a lot that needs to happen and shuving it all in the
kernel is, IMHO, the wrong decision. I would be much happier with minimal s=
afety
requirements in the kernel and let a userspace daemon (which we should cert=
ainly
provide a reference implementation) figure out what to do. This might be be=
tter
for things like Chromebooks and Android phones too which might make complet=
ely
different decisions given a certain charging profile.

--=20
balbi

--2nTeH+t2PBomgucg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWDXRZAAoJEIaOsuA1yqREBzMP/36KbiKev+z3U19vywQN0cE8
oFbpywVWPe3iS5QMHro0kdtffSeb3O660we9Tys85/XHMqsYpwGp4abDC4QP631+
sIbEfJsn34RedzY0yKUTYhiICX7dHnXBtKV0WcneI6OW7jhxvwjniRBYArCw5ZYv
LyzIOHsPi0+dgvSDM57LRZMIGt3XKb/Hjri1mUWwcVbSV/SMDPCaI3bHhvRyTsiR
ynqe6kaEOposKe/ivf79sP51bFbMTBoh9kRkYHOLuF/NiQabVhb7rQjXVofloVvQ
xKLFrQOXk1aqAOm7K5mCCn5BPBY6+EgT+gZ7zZnADmajszaVCrtUWR0ZSPVJX9GH
/lNn3fMU1t3/pp+EtarealQTkqXuVOWhPLCtk+9p1EMZL5Dw9IroMBpFDvpJYbbf
Iav5w7nsgOo//b0JV/7E67xhKzfzH5zmMx+Dej4IfcOqIxLVE6cBaN8pcbXrlMsw
xxoiVo+sYQxEVUV7XjSsTuUH1b+fsC6x9WFVQvdYqJZ9938/jaQ43qRnNy8gYv06
i818LTywEfRoSOTwgLas+D9tBYYBmmlI7/5FEc1IRTa2GyfYmDJtRnkW6HSx//C5
wFVvLwzipTSMl1W6RVaczih0rte/twdQcb614HjVZEfRbwLrO6I356o1qP42PecN
GUOUsnM7VnFzqo4B7UQe
=2z+d
-----END PGP SIGNATURE-----

--2nTeH+t2PBomgucg--
