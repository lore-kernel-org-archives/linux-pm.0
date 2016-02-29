From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V6 10/10] ARM64: tegra: Add audio PM domain device node
 for Tegra210
Date: Mon, 29 Feb 2016 11:54:47 +0100
Message-ID: <20160229105447.GA674@ulmo>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
 <1456501724-28477-11-git-send-email-jonathanh@nvidia.com>
 <20160229073009.GJ23745@ulmo>
 <56D4206E.6070504@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33697 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbcB2Kyv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 05:54:51 -0500
Content-Disposition: inline
In-Reply-To: <56D4206E.6070504@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 29, 2016 at 10:41:50AM +0000, Jon Hunter wrote:
>=20
>=20
> On 29/02/16 07:30, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> >=20
> > On Fri, Feb 26, 2016 at 03:48:44PM +0000, Jon Hunter wrote:
> >> Add the audio power-domain for tegra210. Note that this also removes t=
he
> >> existing "#power-domain-cells" which was incorrectly included by
> >> commit e53095857166 ("arm64: tegra: Add Tegra210 support").
> >>
> >> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> >>
> >> ---
> >>
> >> So far I have only added the audio power-domain for tegra210 as this is
> >> what I have been testing with to date. However, once this series is
> >> accepted then we can begin to add more.
> >>
> >>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 14 +++++++++++++-
> >>  1 file changed, 13 insertions(+), 1 deletion(-)
> >=20
> > I'm slightly reluctant to apply this, since the domain isn't used
> > anywhere. I'm assuming it will be used by the audio driver that you've
> > been working on, but if that's not going to be merged this cycle, we'd
> > end up with an unused label. Not that that's invalid in any way, but my
> > rule of thumb has been not to introduce labels until they are used.
> >=20
> > Therefore I suggest we postpone this to the series that adds audio
> > support.
>=20
> That's fine with me or I can drop the label, until it is used by a device?

I'd prefer the former, no use in having anything in device tree that
we're not using anyway. Unless we need this somehow to automatically
turn off the domain at boot, in which case it might make more sense
to add all others as well.

Thierry

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW1CNzAAoJEN0jrNd/PrOhjkgQALpet8easofeMARElmAnQEAq
M7txiUgvZOPLhP7GBXkQpzcOfpLLAcLCLltZuWOw1weCZZqK9S/U5yW/QBz544JJ
jA0g58Y6VnSZq+5d6l8YYWjazk8GZxmS6Udo+yFaxDS8pAWRnCvY80uUB+dK7YVq
T1iJvIxFEaMbUIIMCtMaiDr7wOZZSI8wfoc6j4TZEw2CcE3X+T1lEzGuWOcJp7fz
H0NxRwvGRt9R3opcgHvjRTYosB9nFAG6q9FTZ+4g2Rb7fkBBBsspV5FFM5Yu4O/A
Y5evtdSzR6XkOCnmScwyQJRtE0L+q9XFsSAFMK2W5jA3LTKG3XfCrI4x2q+0yprt
sNW5sGeqHPa9vlYRqCFRj4DzfKAWxXFB9abpfqmvMzx5nxAi+d4rhAtx4HuNXiNs
Y9A6G+LdynNJSlO3BCxjwPsU1nlKRI+Z8xkxZlqbQ/lSvGoKT4g3v5fDMn694NSY
r0Eo11LPwbLvQo94xHMoVJTa85Y2+n5IiXmxK7tCsggRgbmPdp2RIrE7+VflDiSt
9iL4Fd21JPGZ+msR5PwbnK3qxcuOnSvO7iLfrGj1XsbZ3FrJUEpUUCXlDMlsrZKK
4fiVOqVbeZqE2WGJTODkIEoePyw8UgKwCkM4nJ7Pulak2I5IAbh9M6fta3NF/w86
RrKa7RpbmBA1PJ9SCEsu
=wV0r
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
