From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC] Add the "icebox"
Date: Wed, 07 Nov 2007 09:58:40 +0100
Message-ID: <1194425920.4055.1.camel@johannes.berg>
References: <Pine.LNX.4.44L0.0711051611190.2800-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0274139290799042584=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0711051611190.2800-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============0274139290799042584==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-w7ggdrHC8jsrCFy+3q0W"


--=-w7ggdrHC8jsrCFy+3q0W
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> This patch adds the icebox, for use by kernel threads that want to=20
> freeze themselves without using the freezer -- which is likely to crop=20
> up when the freezer gets eliminated.

There obviously isn't a way to wait for all tasks that want to enter the
icebox since there's no task flag for this, will tasks need to add extra
locking? Or otherwise how do we make sure that a task hasn't *just* gone
past icebox() and starts executing the code that the icebox() is
supposed to prevent?

johannes

--=-w7ggdrHC8jsrCFy+3q0W
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARzF+P6Vg1VMiehFYAQLKrA/+KQPSmFsDd88803hrl2O+vOiiMDmZ0j1S
9xm5z3yMRuMaHvXA8aXmQtX6S+y+urYWcDLbt//DKcUzmJEU/tWPZowA4lr5Tf55
PzPlpZc7TGnDjDJZ3SnDn5tB0LZVb7HbQ1RZDLAOs0h2nJC/ksa8ocTY4pyIh1Zh
BLLsodxqP2mE5AWHkggTuwfo54984r7hsADtIMI7iSXTXoNG36pJIBjvxppjDdx5
/w69KoaC0nIabtoMLfZSnS5PRNV9aJs365V0B+hsIlfZ5T0wd+txFY55ETeekuI0
+ZuqlC+Xz8ihEZtKwZp77giY96FdgXmmxAC3yTTEz212V/factnu4gy0Y2Gzmqrk
947G2RVXwYy/b99s984nWhN3jcgsBpZtXxB9lJztv/P2RSDBEeoANpnyrLBrU6EQ
IenhdBkr6dWS+4SGUu4ExItwJe+mrUxrOEpCRhut1WYCWjb/rJpU2Bc00O0xs989
ErVxCQfm4N3S00nzivnWVxEXFyWKwR64h5YnlXJVpu4kvUvJPZBx1XITW/KZCsqJ
BSeVTSp+p7LIkZN/JOAU8RTPRjBiGzZ4dCrPYPhod8HJT3ynXepP9cuGf4ucdjdl
PBnn3MvTnyK/R87lHbPg2ZMgO+FYJtFbDr/fw+ZQZcZqt5dgxKdH8KmkVRhLw6HS
Nrg+dEhALbc=
=UBHK
-----END PGP SIGNATURE-----

--=-w7ggdrHC8jsrCFy+3q0W--


--===============0274139290799042584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0274139290799042584==--
