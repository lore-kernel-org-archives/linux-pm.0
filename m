From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/3] soc/tegra: bpmp: Generic PM domains for Tegra186
Date: Tue, 11 Apr 2017 17:28:38 +0200
Message-ID: <20170411152838.GA13819@ulmo.ba.sec>
References: <20170329163452.10761-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170329163452.10761-1-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stefan Kristiansson <stefank-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2017 at 06:34:49PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> Hi Rafael, Kevin, Ulf,
>=20
> This series implement generic power domains for Tegra186. Since the
> power partitions on Tegra186 have a non-contiguous ID range, the PM
> domain core is enhanced with a way to allow PM domain providers to
> override the default ->xlate() implementation. This is used to look
> up the correct PM domain given the ID read from device tree.
>=20
> The second patch updates the BPMP ABI header to a version that has
> support for the MRQ_PG request which is used to enumerate available
> power partitions and control them.
>=20
> An implementation of the generic PM domains using the MRQ_PG request
> is provided in patch 3.
>=20
> Given the dependency of patch 3 on patch 1 I think it'd be easiest
> to get an Acked-by on patch 1 and take all of these through the Tegra
> tree. If that's okay with you, I can provide a stable branch with the
> first patch that could be pulled into the PM tree to resolve potential
> conflicts.
>=20
> Thanks,
> Thierry
>=20
> Changes in v2:
> - take into account PG_STATE_RUNNING in tegra_bpmp_powergate_is_powered()
> - check return value of pm_genpd_init() and clean up on failure
> - simplify error unwinding in tegra_bpmp_init_powergates()
>=20
> Thierry Reding (3):
>   PM / Domains: Allow overriding the ->xlate() callback
>   soc/tegra: bpmp: Update ABI header
>   soc/tegra: bpmp: Implement generic PM domains

Any comments on this? If not, can we get this into v4.12?

Thanks,
Thierry

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljs9iMACgkQ3SOs138+
s6E+ZxAAuzb92nhuYroYs9PzTcP8wRj0ykSFhH+2rfxTHULhPg9kTlYv/iyBM/II
/vCaVOeODBpHyCc2WpAZ/23OYkSFxA2VmMNNnGymj4IqxqROl7d/qws2oahwHrMe
zmuelQzPe6AQEbvQBskJeYRor+OTOpceOvNIJ71UxZiAju6hruqua3zmY7BYJKy8
PNHJ4tR+8JpRTZOeW1CXKRBH7I5K75rqEvpw1CViIAjQq+3BSVOnn7KGkZ0tig1B
+8/6AWsRQITD/QnvKZGJyHXTQclreAwcvdDfvF5gCUzHqXeOmAqGJSpehZqjxRCZ
ySiOg/qU7GhY4MR0CpxNcSoEH+uIQxbx2WK9YxKNb3yt6fiubbEC4BIgGqEYu/jI
qN896hljhpFIhJD01hA0cL11XW3QIdnrXXcoS1RnYVTkjTybBkxZ8OsWR0Or+p//
fPoaD4dOLNGz+jyiz81xDrrkKOMEenb+KQDFOUkixmWc26yel/mEzPq3xacF2yWh
1gZUwwX4sY6jQPceywHVmBlr4TmXoOb815r34jeYfcQzwg8IFajhz4ULVabewsWO
6Xn154Isj6plECupJM02mbzj0PGNlH+ekTulrfzZpcLAFcqD3lxZkKDsrPGFybWe
RsWGX0TI1DcdEJ+j91TgVZwFsvar8dHcticKAp19bFdy188EQyw=
=IJkg
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
