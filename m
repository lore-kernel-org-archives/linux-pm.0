From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] power management: change
	/sys/power/disk	display
Date: Thu, 12 Apr 2007 12:43:21 +0200
Message-ID: <1176374601.7052.42.camel@johannes.berg>
References: <1176338224.3579.2.camel@johannes.berg>
	<200704121241.35204.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0958235167=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704121241.35204.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============0958235167==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ATJ8ffaxO1zYw2Wuspbt"


--=-ATJ8ffaxO1zYw2Wuspbt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-12 at 12:41 +0200, Rafael J. Wysocki wrote:
> > -	pr_debug("PM: suspend-to-disk mode set to '%s'\n",
> > -		 pm_disk_modes[mode]);
> > +	if (!error)
> > +		pr_debug("PM: suspend-to-disk mode set to '%s'\n",
> > +			 pm_disk_modes[mode]);
> >  	mutex_unlock(&pm_mutex);
> >  	return error ? error : n;
> >  }
>=20
> .. this is an additional bugfix, right?  If so, can you please separate i=
t from
> this patch?

Huh, yes, it's separate I guess. This must have slipped in from the
original patch where I had an extra file.

johannes

--=-ATJ8ffaxO1zYw2Wuspbt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGHg1J/ETPhpq3jKURApwgAKCu5SA6pyrpKj5U7dJ/Rs07A2/sQgCdFaDi
kTkkISnD/6teRNYIX8Rg6y4=
=uG4c
-----END PGP SIGNATURE-----

--=-ATJ8ffaxO1zYw2Wuspbt--


--===============0958235167==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0958235167==--
