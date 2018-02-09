From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v13 3/4] thinkpad_acpi: Add support for battery thresholds
Date: Fri, 9 Feb 2018 13:34:14 +0100
Message-ID: <20180209123414.xrtmtgmeeezmma5u@earth.universe>
References: <20180207145844.bd567c36juvlkjvz@thinkpad>
 <20180208220323.cr6j2kcozekwbzo6@earth.universe>
 <CAJZ5v0hOf1DfQuoqcqb3Xjmw_Y49MGCnY19Xv6Qz88KyT5T+xQ@mail.gmail.com>
 <20180209103946.fkolldv6boml3e32@earth.universe>
 <CAJZ5v0h8YW03EpqEVO8LGti9ECo7+Gmm0PdgQViidUCZ=o0AQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fnb6lqmcobuk4f35"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750918AbeBIMeR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Feb 2018 07:34:17 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h8YW03EpqEVO8LGti9ECo7+Gmm0PdgQViidUCZ=o0AQw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>, Ognjen Galic <smclt30p@gmail.com>


--fnb6lqmcobuk4f35
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 09, 2018 at 11:49:40AM +0100, Rafael J. Wysocki wrote:
> On Fri, Feb 9, 2018 at 11:39 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > Hi,
> >
> > On Fri, Feb 09, 2018 at 10:22:54AM +0100, Rafael J. Wysocki wrote:
> >> On Thu, Feb 8, 2018 at 11:03 PM, Sebastian Reichel <sre@kernel.org> wr=
ote:
> >> > Hi,
> >> >
> >> > On Wed, Feb 07, 2018 at 03:58:44PM +0100, Ognjen Galic wrote:
> >> >> 1) Charge start threshold
> >> >> /sys/class/power_supply/BATN/charge_start_threshold
> >> >>
> >> >> Valid values are [0, 99]. A value of 0 turns off the
> >> >> start threshold wear control.
> >> >>
> >> >> 2) Charge stop threshold
> >> >> /sys/class/power_supply/BATN/charge_stop_threshold
> >> >>
> >> >> Valid values are [1, 100]. A value of 100 turns off
> >> >> the stop threshold wear control. This must be
> >> >> configured first.
> >> >
> >> > This is a new sysfs file, that should be documented.
> >>
> >> Right, I should have remembered about that, sorry.
> >>
> >> > Also this looks pretty generic. Just introduce new POWER_SUPPLY_PROP_
> >> > entries for start/stop charging threshold and use them.
> >>
> >> What about doing this as a follow-up?
> >
> > Fine with me.
>=20
> OK
>=20
> Actually, I don't see any documentation whatever for ACPI battery and
> AC power supply properties, so I guess that needs to be added in
> general and I don't think it would be fair to ask Ognjen to do that in
> order to get the extension in.
>=20
> Why don't we pencil this in as work to do?

The generic ones are documented here:

Documentation/power/power_supply_class.txt

-- Sebastian

--fnb6lqmcobuk4f35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp9lUUACgkQ2O7X88g7
+ppp6Q/+PCLctWiBeL5daKJvjQ2a8MzTY+L28qamckfx9Tz9+sOWAR/lTCs1e2hU
SGrIOyFSHRYv8O3OMKLuGhZE42IgckVB8mZEf5A25KyunkdZSFLDdqk0gx8fX2tQ
tyRFcBNg7jpYQKT7m5C2di5+ulaDTin3QJQBZ8/EY7i1XkKUGPG/LZx6e0vQgvvz
caRdlPl2EVIIbaF3CvI0Q2tqgK1LUJr4ZBtr5oCa/6JgB9//+o1KSP26yWuYVzGf
9SGg7LfRy1SqCyeetEUOalR9lc+CAb5hdnM7w4MKQmxtYlY4CvEclLzzzBE5OTcX
84ZAuFcQzBndfWRL6UewjMNrwppTafcwBzKxy/NuJ4jKF+kAKmj1fbfi+LXA87tV
2UYT4TpqOKuS7J5UYDJXKA/XiWA7KKqZAB4XdaNQMcw5/yd333hwrlVRpxsLX4hG
DRn4EI/9Qgxg6S2SdUH6tjNwpWhQM6JTowdNV/sJyKvCB2MnJS4JKCSDB/7Q/qc+
yR/GlFHghXePouoyBmxYo7bYSAOTRNaMBbNuh7KD2Iek6mHEyUvnz63vdH/GY9gc
eNOSl/cH1xOFd4KMrAstg03oAaRXpYmecWxlpmcB4WHNZ3wOASlru0Zq+wyF4DSD
gNXI2SMMenw2u3/QcPLoIbcH6mSq2VPi4tjKXWqIG2gZIl/Vsn4=
=CMUr
-----END PGP SIGNATURE-----

--fnb6lqmcobuk4f35--
