From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 12/13] cpufreq: Add cpufreq driver for Tegra124
Date: Fri, 11 Jul 2014 16:57:36 +0200
Message-ID: <20140711145735.GB6523@ulmo>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>
 <1405028569-14253-13-git-send-email-ttynkkynen@nvidia.com>
 <CAKohpom9ORXFiUU4=V+CxgN0ZOFLMEhEjHiU8HsYUYDybNXgHQ@mail.gmail.com>
 <20140711091207.GY23218@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140711091207.GY23218-Rysk9IDjsxmJz7etNGeUX8VPkgjIgRvpAL8bYrjMMd8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2014 at 12:12:07PM +0300, Peter De Schrijver wrote:
> On Fri, Jul 11, 2014 at 06:35:56AM +0200, Viresh Kumar wrote:
> > Hi Tuomas,
> >=20
> > On 11 July 2014 03:12, Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> > > Add a new cpufreq driver for Tegra124. Instead of using the PLLX as
> > > the CPU clocksource, switch immediately to the DFLL. It allows the use
> > > of higher clock rates, and will automatically scale the CPU voltage as
> > > well. We also rely on the DFLL driver to determine the CPU clock
> > > frequencies that the chip supports, so that we can directly build a
> > > cpufreq table with the OPP library helper dev_pm_opp_init_cpufreq_tab=
le.
> > >
> > > This driver is a completely independent of the old cpufreq driver
> > > (tegra-cpufreq), which is only used on Tegra20.
> > >
> > > Signed-off-by: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >=20
> > Please reuse cpufreq-cpu0 instead of adding a new driver. Similar
> > is being adopted by all platforms now: krait, mvebu, etc..
>=20
> I don't think that's going to work? The voltage scaling is handled in hw.

Do we have to handle it in hardware or can we opt to do it in software,
too?

Thierry

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTv/tfAAoJEN0jrNd/PrOh5fQP/360RWQfDEPQH1EmcEsWbo7M
jt/kDXJkWAI2L4+Vcx3nUdUApXAgiYM9c+2coS8utvx5SSwT+vLTjpj+SVjLpOnE
SQ/G3i2D8qMfipa/ZUAlxLkkGxHqz9dREhos/ZVuUxj8/3YOw/bTWa5lpzovVwsZ
9g7uoPo+KQEY3cWbhlO2G40/O75I+KLWK1hPyd4+jZwI/M/alutiKPrOOYPEcdNH
rRMtfW0oeyhjPHAW9r3YFr8nMSJDHv0C1hQyJjROhIMA/1DeKol4BPJwqzpa2His
o2HXK4xnkjL03nSSEDAXYEXWS7gABpWU/O/QQ5Pm7xAazlWhDYrO+L0aIwqI3Bi2
kyBEWz39CyUeGYNigd90gekXAKqp8lbSxk+GvM3gmuCbBNzULIASRXm/FF/h1pa2
QZpST7rDhyyZ3a8qZ5iPrWK01LZVaIUI/UKZYE4maomT3eUMzqXwK6RBOVzLrVLY
DbjOIzgMUDiqpWbZlaXHX22Nixqidfe2d5eEjdZPmtML4dh/1hfaxI/nKhZWbIPK
MOD5aHX0KlaniNP8iy/83FQpio/hMZJ6+cTrqbqSAQ8G/i+bRKd5PJmHFIbf7bRX
GJDXNiFIcTlgfopJ8Vj8pvVr89I60u8Ok0vGofyjVjhrBW+Dm/FBOl30J7lTwttd
cHoVIKsipFaT1TvEc2WD
=Z6sU
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
