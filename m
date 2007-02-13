From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 05/12] power management: no valid states w/o
	pm_ops +	docs
Date: Tue, 13 Feb 2007 17:08:40 +0100
Message-ID: <1171382920.10344.28.camel@johannes.berg>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124612.176570000@sipsolutions.net>
	<20070213121249.GJ18101@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0460790556=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070213121249.GJ18101@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============0460790556==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-MZuE30Vyv1TAEKmO67T+"


--=-MZuE30Vyv1TAEKmO67T+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-02-13 at 13:12 +0100, Pavel Machek wrote:
> Hi!
>=20
> > This patch changes /sys/power/state to not advertise any valid states
> > (except for disk if SOFTWARE_SUSPEND is enabled) when no pm_ops have be=
en
> > set so userspace can easily discover what states should be available.
> >=20
> > Also, because the pm ops in powermac are obviously not using them as
> > intended, I added documentation for it in kernel-doc format.
> >=20
> > Reordering the fields in struct pm_ops not only makes the output of
> > kernel-doc make more sense but also removes a hole from the structure o=
n
> > 64-bit platforms.
> >=20
> > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> > Cc: linux-pm@lists.osdl.org
> > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > Cc: Pavel Macheck <pavel@ucw.cz>
>=20
> Looks okay to me.

Are you going to pick it up or should I send it to someone else?

johannes

--=-MZuE30Vyv1TAEKmO67T+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF0eKI/ETPhpq3jKURAuoRAJ0TI1Umq8VlvhT9MphCqq5DtmIF0gCfe265
mp4wK77q7cqEHv2/4ih1quo=
=c5z/
-----END PGP SIGNATURE-----

--=-MZuE30Vyv1TAEKmO67T+--


--===============0460790556==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0460790556==--
