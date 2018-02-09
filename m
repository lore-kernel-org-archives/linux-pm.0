From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v13 3/4] thinkpad_acpi: Add support for battery thresholds
Date: Fri, 9 Feb 2018 11:39:46 +0100
Message-ID: <20180209103946.fkolldv6boml3e32@earth.universe>
References: <20180207145844.bd567c36juvlkjvz@thinkpad>
 <20180208220323.cr6j2kcozekwbzo6@earth.universe>
 <CAJZ5v0hOf1DfQuoqcqb3Xjmw_Y49MGCnY19Xv6Qz88KyT5T+xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3xq5us5xzfvyutl6"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hOf1DfQuoqcqb3Xjmw_Y49MGCnY19Xv6Qz88KyT5T+xQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ognjen Galic <smclt30p@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org


--3xq5us5xzfvyutl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 09, 2018 at 10:22:54AM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 8, 2018 at 11:03 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > Hi,
> >
> > On Wed, Feb 07, 2018 at 03:58:44PM +0100, Ognjen Galic wrote:
> >> 1) Charge start threshold
> >> /sys/class/power_supply/BATN/charge_start_threshold
> >>
> >> Valid values are [0, 99]. A value of 0 turns off the
> >> start threshold wear control.
> >>
> >> 2) Charge stop threshold
> >> /sys/class/power_supply/BATN/charge_stop_threshold
> >>
> >> Valid values are [1, 100]. A value of 100 turns off
> >> the stop threshold wear control. This must be
> >> configured first.
> >
> > This is a new sysfs file, that should be documented.
>=20
> Right, I should have remembered about that, sorry.
>=20
> > Also this looks pretty generic. Just introduce new POWER_SUPPLY_PROP_
> > entries for start/stop charging threshold and use them.
>=20
> What about doing this as a follow-up?

Fine with me.

-- Sebastian

--3xq5us5xzfvyutl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp9em4ACgkQ2O7X88g7
+prlSA//TgdyXi95Nhm+D97ROps1xljEQo8Zb4q1KljKq4FN301ub8shC2zILE3w
J/heoAiQvEJrdxVCFSar7PROHlyVKJNyfrjRbaR1Jm1cNd4odug66HYMRLpXmgMC
4zuIWEbpvOBXT9MvCujbLGQaJaJ+6iD/QyybXhvXXnxejp+N8efOxktqH7iINNMX
Mb+jG0HhfO7L3of2PP1E7pcO59lOEnaYk3UDTniy5cL/5GFL9xRIy+E1NPBxRYhA
2tiCp8ftFsVeNyMUcK5vPqLuGgfj3RBCNVnDGaQDCIlrDIAKYZ5tTyg1/Ws/Qy+m
z7FgV+GKOmbNlK1DjHZ48OlrfThkKbI+DqER7GEcDr18GUYuAl3AB9kn0i3FUYcO
bVSSSjlWQ5I1VR7dFcT/TmHvYNcSrphnPB9hBhydI8Q46ZmsHS2biHsRQ7Xx1Orb
zcnP8FBxnz2DIerJEFIOOLOlAprw64lCE2jajMIqMmEllP8b4E3cvhaOTLJwk3Cq
Js9L1LspqFJoj9O8jwyczfSHa31dT7yGvzTjBqNJFNCQKrz1D0Q0BQW9BQ9URtUF
JRWU9K58IUMtFG/yG7CsckTQfkl33ROtr4jV1jkNqagH/TJ8XkaoQeBhMq6Dnxu8
dvXmR2iiYMlq5B1m+4DmHJ8K89TFBKAssdjE20Yef9BP//hRiZg=
=K+VB
-----END PGP SIGNATURE-----

--3xq5us5xzfvyutl6--
