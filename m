From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V7 00/12] Add T210 support in Tegra soctherm
Date: Mon, 14 Mar 2016 14:01:53 -0700
Message-ID: <20160314210152.GA4717@localhost.localdomain>
References: <1457665763-29781-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1457665763-29781-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 11, 2016 at 11:09:11AM +0800, Wei Ni wrote:
> This patchset adds following functions for tegra_soctherm driver:
> 1. add T210 support.

It would be good to update the compatible string in the binding
documentation.

> 2. export debugfs to show some registers.
> 3. add thermtrip funciton.
> 4. add suspend/resume function.

Thanks for your effort in keeping up with upstream. I think overall the
series is good, I had only very few comments (in response to each
patch).

BR,

Eduardo Valentin


>=20
>=20
> --=20
> 1.9.1
>=20

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW5ya+AAoJEMLUO4d9pOJW8AkH/jV5YIWmN4vWJ0UEhNMxAKEx
pnXoxREr002E5KV2R2TPVmZapx7zxunaEKwDbIqXy/hcdRs/ROEW3QsraYKjcByi
2RTQkEZwMMcD7WD+xxH749hETTZZoHdNjt8LH8/owq0qxqwdKjQh/dEI5MMFUeTY
El3u9MEdFm9DA8DLWDlSzHdSjUI6cdHvMqSOJKVeGDMH1iKPF5Kb2J2aRM3BE+6+
IsknVeOcvrGW6unGUp6ID/3Ua6BbDQ4LqNwQHwNU5CzTBYwRZ5O5JQSBjGRiAHB8
SeLf5GOiJxqjg+MDj1PsanWf21+XMWkB138p/yWFh2f6YqjndUjvv/iaBKjfaBs=
=UbDr
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
