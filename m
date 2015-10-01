From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Thu, 1 Oct 2015 13:01:09 -0500
Message-ID: <20151001180109.GI4469@saruman.tx.rr.com>
References: <cover.1443057229.git.baolin.wang@linaro.org>
 <e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org>
 <20151001172932.GG4469@saruman.tx.rr.com>
 <20151001174308.GL12635@sirena.org.uk>
 <20151001175849.GH4469@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+WOirvrtTKur1pg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53212 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752924AbbJASB6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 1 Oct 2015 14:01:58 -0400
Content-Disposition: inline
In-Reply-To: <20151001175849.GH4469@saruman.tx.rr.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org

--x+WOirvrtTKur1pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2015 at 12:58:49PM -0500, Felipe Balbi wrote:
> Hi,
>=20
> On Thu, Oct 01, 2015 at 06:43:08PM +0100, Mark Brown wrote:
> > On Thu, Oct 01, 2015 at 12:29:32PM -0500, Felipe Balbi wrote:
> >=20
> > > Frankly, I wanted all of this to be decided in userland with the
> > > kernel just providing notification and basic safety checks (we don't
> > > want to allow a bogus userspace daemon frying anybody's devices).
> >=20
> > What's the advantage of pushing this to userspace?  By the time we
> > provide enough discoverability to enable userspace to configure itself
> > it seems like we'd have enough information to do the job anyway.
>=20
> you're going to be dealing with a setup where each vendor does one thing
> differently. Some will have it all in the SoC part of a single IP (dwc3 c=
an be
> configured that way), some will push it out to companion IC, some might e=
ven use

oh, and as for dwc3 itself: it *can* be configured that way, but all those
charging blocks are optional :-) So you will even have setups where the very
same IP works differently because SoC vendor A configured it differently fr=
om
SoC vendor B.

--=20
balbi

--x+WOirvrtTKur1pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWDXTlAAoJEIaOsuA1yqREuD8P/ApyYvM9xpOKjzxuJo+uls6R
zVpQMSO5hyerR53DLfV9aj/++QoML8KbHfGaAYd9wCiVEiAESh1ZjgXh5SkV122Y
jmNptPQZfXwl/svfjZL7FE41MGsRWgh9tOH7PdZPyqJnvUdX/Q9fu2HlayCciKhQ
LniGGlyychpSg5tB+jrxg2YbWxEZIYmMIm+Fkh0fFAZtfcD1ZzGXyVh/LB0VkZfR
TpI2XNDN4kEujhLfspQNKnWcxGgUkGJebVcptG+Pso4rJ090UpbRES4MhDqU9cDk
ZCHvkh1lAQ2uamQzDmQ8yNLUxavEQq2zylWyH6PAGF0wYb0k994sd1HVLbSqxlnJ
WdpqwIwiPHTHiojbdXyAuW7B2oKNW5RVEHpmXlMMWbSxKNBPTvr81v/StIvrV2zD
IJZ6zWfy4T0bPuycTbqD3sh5QgDj0+ZwS0MjzponV9fvJTdqvMqTTQUuvH4nrIFV
T1xiFMi4/7yZTzLr9Dzqv8H+6vTbLe8Hu6ELAMobhoSIwQb9/bKQdvdZC1tjWoPH
gIh2Oez6/JrydWL+NbF26gO1abtKkOY/wLzMu+u53629UZeMQF4Lnb7D7G/IVs6g
MSFZglrM3wJASpyWw9ry+t+OXnac20MdA+TbiBH3Ra2J2ZNsCw697n16CQriJp/+
NACd55xEQG3xXSApOqTd
=Mq4T
-----END PGP SIGNATURE-----

--x+WOirvrtTKur1pg--
