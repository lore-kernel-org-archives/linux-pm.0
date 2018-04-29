From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3] PM / wakeup: use seq_open() to show wakeup stats
Date: Sun, 29 Apr 2018 16:30:02 +0200
Message-ID: <20180429143002.GC13475@amd>
References: <1524653971-10425-1-git-send-email-opensource.ganesh@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524653971-10425-1-git-send-email-opensource.ganesh@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, rafael@kernel.org, gregkh@linuxfoundation.org, geert@linux-m68k.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-04-25 18:59:31, Ganesh Mahendran wrote:
> single_open() interface requires that the whole output must
> fit into a single buffer. This will lead to timeout when
> system memory is not in a good situation.
>=20
> This patch use seq_open() to show wakeup stats. This method
> need only one page, so timeout will not be observed.

Sounds like magic.

> -static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
> +static void *wakeup_sources_stats_seq_start(struct seq_file *m,
> +					loff_t *pos)
>  {
=2E..
> -	srcuidx =3D srcu_read_lock(&wakeup_srcu);
> -	list_for_each_entry_rcu(ws, &wakeup_sources, entry)
> -		print_wakeup_source_stats(m, ws);
> -	srcu_read_unlock(&wakeup_srcu, srcuidx);
> +	*srcuidx =3D srcu_read_lock(&wakeup_srcu);
> +	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
> +		if (n-- <=3D 0)
> +			return ws;
> +	}
> +
> +	return NULL;
> +}
=2E..
> +static void wakeup_sources_stats_seq_stop(struct seq_file *m, void *v)
> +{
> +	int *srcuidx =3D m->private;
> +
> +	srcu_read_unlock(&wakeup_srcu, *srcuidx);
> +}

But you are holding srcu_lock over return to userspace, and somehow I
don't think that's permitted?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrl1uoACgkQMOfwapXb+vLWfQCfec1XrdlLE0AwT0gWMJILdKJP
fLgAoIqn6yp9O1011jbE2eSYNL1XyMHR
=uMnk
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
