From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] PM / Domains: Allow overriding the ->xlate() callback
Date: Wed, 15 Mar 2017 14:36:52 +0100
Message-ID: <20170315133652.GA29259@ulmo.ba.sec>
References: <20170314191516.13083-1-thierry.reding@gmail.com>
 <20170314191516.13083-2-thierry.reding@gmail.com>
 <20d4efbc-b3f1-4d64-0aae-ac51e171a09a@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20d4efbc-b3f1-4d64-0aae-ac51e171a09a-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefan Kristiansson <stefank-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2017 at 08:34:01PM +0000, Jon Hunter wrote:
>=20
> On 14/03/17 19:15, Thierry Reding wrote:
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >=20
> > Allow generic power domain providers to override the ->xlate() callback
> > in case the default genpd_xlate_onecell() translation callback is not
> > good enough.
> >=20
> > One potential use-case for this is to allow generic power domains to be
> > specified by an ID rather than an index.
>=20
> Are you sure this is necessary, because I recall that the genpd core
> does allow for holes in the domain array (which is what we have). See
> commit 609bed67bd8f ('PM / Domains: Allow holes in genpd_data.domains
> array').

I suppose we could use that, but it feels like the wrong solution to me.
Why would we want to deal with holes in the array when we can simply do
all the required work at probe time and add only the existing domains in
any particular SoC.

For example on Tegra186 we've got a maximum ID of 43, so we'd need to
allocate 44 pointers, but we only use 17 of those IDs. People usually
reply to that that newer SoCs come with enough memory to make this
waste irrelevant. I don't buy that. Why should we waste memory if it
can be easily avoided?

Thierry

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljJQ3EACgkQ3SOs138+
s6GXxhAAlRMftsXVWyXxBavvpZGP8Y32pGP2kDfkLIyckThjpi63v/HDVu7lk4LT
SAZnuxXphxN00uepquUNJHfphUaZB/mIoKMmILKWABPlr0xf0Lw3WQPDiMAq4d9S
y5zqGOQarsia/G3NM46yiG9jl0H0mK67Mm5/Q6cwaYc5Z78gzSO//3mPcjk07Ini
tqbw8yKXlzZxGYq8Qfl8rEy1VUGkD7Y2K0FPLbCoWZ04pXBWdaSvvUTpQcqQiiGG
66mKZMP+FknkcTiibMzZ8JwkuI16O723wq80Gn9Q8SM4ud12CLfeddDs5kvNxYUB
l0e15ODHQmZI/xrTZUMu8e3rb9aF6f+RffDp1VRtSl1B+HiZPko1RJ0dEOT2KHMj
ek2QylAhN9Hi2AHwEm/KOqHH16NDsQaiJsUdqNzIej4hIyXT9wEdHHhCWDSm+2pZ
tN6j8nIRZ4VNw5SRo5gXEeISRWV/Xc7U+je9N/cMD51gyYg58azo+u437LojM7Nu
llVHUplRj7iy4OJlxE31INEM7R80OKLczIVqk71XGoecjbuPoT8B4LFOJzWmUl0r
MSU43VPudG91vWgLmICC7LPWvhdoVQVIHBznHUD+cnEcmvkVLetzBHr5JyKfzAiI
PWvftbil5B8dJwA4yubBZ88jF8cw/5YtlcBE0LbT193bHc2YEUM=
=vIBo
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
