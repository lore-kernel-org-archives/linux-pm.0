From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [RFC/PATCH 2/2] kernel: don't update load
	average during snapshot/shutdown
Date: Fri, 27 Apr 2007 17:12:12 +0200
Message-ID: <1177686732.3565.30.camel@johannes.berg>
References: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
	<200704271700.52678.rjw@sisk.pl>
	<1177686164.3565.24.camel@johannes.berg>
	<20070427150527.GQ22250@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2602352685469226133=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070427150527.GQ22250@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.osdl.org, nigel@nigel.suspend2.net
List-Id: linux-pm@vger.kernel.org


--===============2602352685469226133==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-YBjBulVw17BFxK0hDYfb"


--=-YBjBulVw17BFxK0hDYfb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-27 at 17:05 +0200, Pavel Machek wrote:

> I think we should track -mm for now. git tree means Linus has to
> trust you, and if he does not, you are in _big_ trouble.

We could still generate patches from the actual git tree and send those
on to -mm. Bit more work though. Dunno. I try to import patches I see on
the mailing list into my own patch queue, but that seems not to be
effective all the time (never saw the freezer changes anywhere for
example)

johannes

--=-YBjBulVw17BFxK0hDYfb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMhLM/ETPhpq3jKURAo1cAJ9G9LUod81SoEJxI/s1V4EvXrgm4gCgkxkU
DoVNAMYGyX3wfdatJGBDYv8=
=FhKm
-----END PGP SIGNATURE-----

--=-YBjBulVw17BFxK0hDYfb--


--===============2602352685469226133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2602352685469226133==--
