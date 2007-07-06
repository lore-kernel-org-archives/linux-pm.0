From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 6 Jul 2007 19:16:16 +1000
Message-ID: <200707061916.17590.nigel@nigel.suspend2.net>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707060951.47555.oliver@neukum.org>
	<E1I6jot-0003U1-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2026176398231271497=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6jot-0003U1-00@dorka.pomaz.szeredi.hu>
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mjg59@srcf.ucam.org, nigel@suspend2.net, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============2026176398231271497==
Content-Type: multipart/signed; boundary="nextPart8580040.uTIAtyy5Kl";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart8580040.uTIAtyy5Kl
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 06 July 2007 19:09:43 Miklos Szeredi wrote:
> > > > Moreover, if FUSE implements syncing, then the sync from within the=
=20
freezer
> > > > will almost certainly deadlock.
> > >=20
> > > Rafael, think positively: by the time fuse implements sync(), the
> > > freezer will be long gone ;)
> >=20
> > Now you are entering really dangerous territory.
> > If you can implement a meaningfull sync method, you must have dirty
> > pages in the page cache. That means you are in the page freeing path
> > of the vm. Then we are in real trouble. Don't even think about it.
>=20
> VM induced deadlocks are real nasty.  I have thought about them a lot
> already.  Suspend shouldn't introduce any big surprises.

Suspend isn't introducing the surprises. Fuse is. It creates the potential=
=20
deadlocks simply by existing (this isn't suspend or hibernate specific).

Nigel

--nextPart8580040.uTIAtyy5Kl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGjghhN0y+n1M3mo0RAqueAJ9O6KMD1i4aV8jCQlPzl/DH0awBZwCg0KFs
ByEuy78qc8ls5c0jPjFkEgA=
=NZlk
-----END PGP SIGNATURE-----

--nextPart8580040.uTIAtyy5Kl--

--===============2026176398231271497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2026176398231271497==--
