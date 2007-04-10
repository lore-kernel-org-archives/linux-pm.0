From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Tue, 10 Apr 2007 15:42:32 +0200
Message-ID: <1176212552.8459.93.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704060217.50560.rjw@sisk.pl>
	<1175849322.3489.64.camel@johannes.berg>
	<200704061141.31677.rjw@sisk.pl>
	<1175852652.3489.67.camel@johannes.berg>
	<20070406191903.GD2583@elf.ucw.cz>
	<1175896767.8459.6.camel@johannes.berg>
	<20070410113623.GF8239@elf.ucw.cz>
	<1176205508.8459.89.camel@johannes.berg>
	<20070410120028.GI8239@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0463971069=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070410120028.GI8239@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============0463971069==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-pUluDirx58K/9eoeCpvX"


--=-pUluDirx58K/9eoeCpvX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> > > Hmm, and can't you simply create sysdev for decrementer and special
> > > platform handling? sysdevs should be suspended last...
> >=20
> > In theory, yes.
> >=20
> > In practise, however, it seems to be impossible to get a sysdev into th=
e
> > queue that is suspended before any other sysdevs are suspended (i.e.
> > right after interrupts are disabled)
> >=20
> > And then there are the platform functions. In theory, they could be don=
e
> > with a regular struct device, but in practice they need to be the very
> > last thing before interrupts are disabled, and that again is impossible
> > to achieve.
>=20
> Is it feasible to improve sysdev handling to allow this?

Actually, I think I spoke too soon when I wrote above.
device_power_down() calls sysdev's last so even being first in the
sysdev queue probably wouldn't help here. Then again, I'm not 100%
certain that we do need the decrementer right after disabling IRQs, it
seems to me on casual inspections that it isn't necessary but I'd have
to take another look.

Pushing aside the decrementer, the second issue with the platform
functions remain. I'm not opposed to working on something to allow me to
order the device tree suspend, but I have absolutely no idea how that
could be done.

johannes

--=-pUluDirx58K/9eoeCpvX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGG5RI/ETPhpq3jKURAutvAKC2jy6/c4RvIQaJDbL2ZEunhXitgACeM3/W
MZcSBLpcRhDi4D3Dh3AqXNA=
=IqNc
-----END PGP SIGNATURE-----

--=-pUluDirx58K/9eoeCpvX--


--===============0463971069==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0463971069==--
