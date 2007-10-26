From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: lockdep report in hibernate code
Date: Fri, 26 Oct 2007 12:36:18 +0200
Message-ID: <1193394978.4406.41.camel@johannes.berg>
References: <Pine.LNX.4.44L0.0710251310030.7029-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4039551615922637684=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0710251310030.7029-100000@netrider.rowland.org>
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
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============4039551615922637684==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-FOWjSh7JwIQERkYxMUra"


--=-FOWjSh7JwIQERkYxMUra
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > We have two paths here:
> >=20
> >  (a) sysfs write -> lock buffer -> call power management code=20
> >      -> lock pm_mutex
> >  (b) boot code -> power management boot -> lock pm_mutex
> >      -> use name_to_dev_t() -> call sysfs -> lock buffer
> >=20
> > As you can see, lockdep rightfully complains about a possible deadlock
> > scenario although of course (b) only happens once at boot at a time
> > where (a) cannot happen. And now we're wondering how to fix it.
>=20
> Why not use mutex_lock_nested() for the boot-time pm_mutex lock call?

Is that going to help though? I thought lock_nested() is only for nested
within a class.

johannes

--=-FOWjSh7JwIQERkYxMUra
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARyHDIaVg1VMiehFYAQLb5xAAl7zA5w68ZDYVS5z5u4EzPScj3qhoKIvU
9Reb87ApOGbSKfnaGzzLDDGgJ7Kl9mGv5wqBcAM6UAfR9tXfva8ubrjQ3KXvGJob
IDyxgqQKpbm8ofH7xKKCjNqGNMz4YHMj6AIsujsdMnUoEozPcqk/qxL+UMqJX6EC
F0CnAaKF+BpfFoGNZrYZuQnW1+TaoUM2/Bdm/FWPSScb/VK9cxXT7ECT1/ZbGStz
Lp70JoW5/vYMbLiR9e1FdhPJScl2rPc8B+otoTXvgbMeKAoXEXuYHcKyEO4YgU8r
bQjjq+lc1Phhbg+tgsO2RGd8deHnrmQ59QKooQ4Ok5ycGuognXmKb6m5Phzm55bE
7QRNS5N6X+1fs4t8z1/ExWLxxf9/C1Dg/RqMjShyS7WQlNtLRfIt1Zzj+DdtVq/O
kJr8lwJNhqgRm4mZ09KS+m7UlBZEEIGGMemLp3U209rzjTJBryLK83tn+aen96aL
pICBZCzbT+4KJ+ynluIzPJEYpXDBT5TzxyPhJvWzhdZjhJE6U+lYU16fWIaC5+wY
41dtuAVfXbpC1xi76LHA/u1xklgirjhjEvSiwYiWa+eupkrDgeiyt5VSLTAdXM32
0qkSmNkM9Becvtx8lS1zOZPcrhJYGaoz3FA0KuwxzgRCdUoHXRPXUpc6PiK724p+
oI1jIb5sle8=
=GPUa
-----END PGP SIGNATURE-----

--=-FOWjSh7JwIQERkYxMUra--


--===============4039551615922637684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4039551615922637684==--
