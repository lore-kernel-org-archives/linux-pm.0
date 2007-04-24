From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Tue, 24 Apr 2007 15:51:35 +0200
Message-ID: <1177422695.3528.24.camel@johannes.berg>
References: <1176980411.6141.83.camel@johannes.berg>
	<200704210841.18581.david-b@pacbell.net>
	<20070421214405.GA2758@elf.ucw.cz>
	<200704212005.55743.david-b@pacbell.net> <20070422131343.GD4236@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0175642648880574684=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070422131343.GD4236@ucw.cz>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============0175642648880574684==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Xi2tqy0XrQKHEYtYDjCv"


--=-Xi2tqy0XrQKHEYtYDjCv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-04-22 at 13:13 +0000, Pavel Machek wrote:

> > This is a very straightforward point.  A function that's
> > called on non-S2RAM paths shouldn't be named as if it's
> > only for S2RAM.
>=20
> And the function that's called for s2ram+standby should not be named
> as if it's also for swsusp...
>=20
> > Ergo, those two functions are misnamed.  End of story.
>=20
> ...which is not only misnamed, it is also actively confusing. (And
> someone _will_ ask me to call that function from swsusp, too.
>=20
> ...maybe we could solve it with a big fat comment?

So how about we don't call them s2ram which is confusing since s2ram is
only one suspend state we support but call them suspend as David
originally proposed and add a comment that since suspend-to-disk isn't a
true suspend state, they are not called there?

Has anybody figured out if (and if yes, where) we should add them to
some header file?

johannes

--=-Xi2tqy0XrQKHEYtYDjCv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGLgtm/ETPhpq3jKURAiszAJ0WKKNWN6xFGvE305M3AJxI1zhU0QCdGypO
ux9pLwDGniiMV+SrgxCvppE=
=2MRV
-----END PGP SIGNATURE-----

--=-Xi2tqy0XrQKHEYtYDjCv--


--===============0175642648880574684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0175642648880574684==--
