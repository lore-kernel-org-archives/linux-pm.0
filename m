From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Wed, 02 May 2007 11:25:12 +0200
Message-ID: <1178097912.13233.54.camel@johannes.berg>
References: <20070425072350.GA6866@ucw.cz>
	<1177945191.5102.93.camel@johannes.berg>
	<200705011605.16993.rjw@sisk.pl> <200705020002.55331.rjw@sisk.pl>
	<1178094106.13233.39.camel@johannes.berg>
	<20070502091633.GA10245@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6229415426685075141=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070502091633.GA10245@elf.ucw.cz>
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
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org


--===============6229415426685075141==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-fuxvNuOCxN6dwnDFM8jk"


--=-fuxvNuOCxN6dwnDFM8jk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-02 at 11:16 +0200, Pavel Machek wrote:

> Well... the powerdown during hibernation... does not have _anything_
> to do with snapshot/restore. It is really a very deep sleep; similar
> to soft powerdown, but not quite.

It's also horribly confusing to intermingle hibernation and suspend into
one operation struct when there's only a single user for it anyway. Just
look at what all the arm platforms had there, trying to veto suspend to
disk through pm_ops etc. I don't technically disagree with you, but from
a point of how to understand this whole thing I'd rather have hibernate
and suspend be totally orthogonal.

johannes

--=-fuxvNuOCxN6dwnDFM8jk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOFj3/ETPhpq3jKURAhUeAJ9+zkhWyWZlBB9oZSACo9NDMPn0pwCeJuwU
s+nQRaNrSRVWqPcYCiW24UQ=
=bD6Y
-----END PGP SIGNATURE-----

--=-fuxvNuOCxN6dwnDFM8jk--


--===============6229415426685075141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6229415426685075141==--
