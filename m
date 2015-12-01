From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFD] PM_GENERIC_DOMAINS && !PM
Date: Tue, 1 Dec 2015 17:18:09 +0100
Message-ID: <20151201161809.GA20561@ulmo>
References: <565C7C86.7030801@nvidia.com>
 <1517697.Xq8gZV3Xnd@vostro.rjw.lan>
 <565DBEE6.5030704@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37770 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278AbbLAQSN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2015 11:18:13 -0500
Content-Disposition: inline
In-Reply-To: <565DBEE6.5030704@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 01, 2015 at 03:38:14PM +0000, Jon Hunter wrote:
>=20
> On 30/11/15 22:42, Rafael J. Wysocki wrote:
> > On Monday, November 30, 2015 04:42:46 PM Jon Hunter wrote:
> >> Currently, if PM is disabled in the kernel then so is
> >> PM_GENERIC_DOMAINS. Although this makes sense, I can see a scenario
> >> where having minimal genpd support could be advantageous.
> >>
> >> I am looking at enabling genpd for Tegra and ideally we would populate
> >> the power domains when the platform device is probed for the power
> >> management controller (PMC) as this device contains the registers for
> >> enabling the power domains.
> >>
> >> This works fine for the case where PM is enabled, but I am concerned
> >> about the case where we don't have PM enabled in the kernel. In this
> >> case, because domains are not populated early during the boot process,=
 I
> >> am concerned that there is a chance for a device dependent on a power
> >> domain to be probed before the PMC device has been probed and had chan=
ce
> >> to turn on any power domains.
> >=20
> > So make the !PM case invalid for that platform.
>=20
> Thierry, I know that we have not reviewed GPD for tegra recently, but
> what are your thoughts on the above in principle? At least for Tegra 64-b=
it?
>=20
> > Seriously, either PM is mandatory, or it isn't.  If it is mandatory, ma=
ke it so
> > instead of pretending that you can live without it.
>=20
> I understand your point and I do agree, however, this means that for any
> device with power-domains that PM is already mandatory (unless they
> don't use genpd at all).
>=20
> I see some platforms getting around this by enabling all the
> power-domains early during the platform code and if PM is not enabled
> then they won't be turned off and so all is ok (d438462c20a3 "ARM: imx6:
> gpc: always enable PU domain if CONFIG_PM is not set"). However, this
> assumes that power-domains will never fail to power on and this seems a
> little fragile to me.
>=20
> One thought I had was to make the PM_GENERIC_DOMAINS_OF code independent
> of PM (ie. moved to domain_of.c) and with a little tweaking of the
> genpd_dev_pm_attach() function it could be made to work whether PM is
> enable or not. In other words, if PM is not enabled, then
> genpd_dev_pm_attach() would only return success if:
> 1. The device is not dependent on a power domain or
> 2. The device is dependent on a power domain and it is present and
>    already powered on.
>=20
> Alternatively, may be genpd_dev_pm_attach() should always return
> -EPROBE_DEFER (to prevent probing a device) if !PM and the device has a
> "power-domains" node defined.

That all sounds very complicated for little gain. Disabling PM doesn't
make much sense these days, so I'd personally be fine to unconditonally
enable PM on Tegra. I'm not sure what the correct way would be. Since
the PM symbol is user-visible, selecting it doesn't sound like a very
good solution, though a quick grep shows that some architectures do
this.

Rafael, do you know what the canonical way is to make !PM invalid for a
platform?

Thierry

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWXcg+AAoJEN0jrNd/PrOhEnsQAKDMkP3/araAUdYMa9ogNWkf
dalQzsF/FEgjFxGddKifFIDvmjAv24pjrUOLERM83vy9kyIaS/eT9RUaQUNWFgZl
CiXszzus0zmMqWBgSW0Qmm1+MbVDhPFJ+fjZpjnEClBk1x5YQR0CoU82BL/0IVh/
bRBa4UTnzUJ616TKHU/THEquHfNS5MCDOCE3707P1vvQ24BG3LXUpf6XzbAd/zFm
zoAk8gAU2gEYWz2YxsycPrtNRVQnejgBUAZk96JWLHpwmylQFWt74hs6UijAZehd
4Gdkz0b22ndBZsgLkYJgb8e4/UCwps9IWsdKSsUjIPcLILSFXDjOsvbFjM72k17W
L6a5f+mGfQzYeQMfPuwgsM9qaC/tWnr0+rTI5L31K9ZnmpdIzoeBnLTHdHTi+d+7
o2Ex6T6YUxbnwmOyn0ONfwEiYgTAxulEdjVkp4wSMgzuMSIQ+urpb8l0w9lWh4c6
2oHkBkOMsb/9ZK5HKpAZJ9BeIZC0V9PCqW0B0IfJRSdctHMCx35AoZOiVOJImdKr
x7LrU1yYMXEexIxFnp1vY0Gj33x11jqXfqTULeaAfBloavafr1sOg7OvyuE6q4mB
7svQlJJMSmMGrPeWLzpWoaqCITPYw0UOjOXUOh4Tc3hdvQW8LKSHvyFU77LhPp2M
ff1KgonqMTDMtmNnQrIo
=K8Nt
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
