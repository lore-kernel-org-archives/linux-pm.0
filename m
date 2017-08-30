From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 5/5] thermal: Add Tegra BPMP thermal sensor driver
Date: Wed, 30 Aug 2017 21:32:52 +0200
Message-ID: <20170830193252.GA12761@ulmo>
References: <20170724162918.21050-1-mperttunen@nvidia.com>
 <20170724162918.21050-5-mperttunen@nvidia.com>
 <1502420276.2598.5.camel@intel.com>
 <4315091f-03b1-2df6-b224-6a29d3261371@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4315091f-03b1-2df6-b224-6a29d3261371-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2017 at 10:40:44AM +0800, Wei Ni wrote:
>=20
>=20
> On Friday, August 11, 2017 10:57 AM, Zhang Rui wrote:
> > On Mon, 2017-07-24 at 19:29 +0300, Mikko Perttunen wrote:
> >> On Tegra186, the BPMP (Boot and Power Management Processor) exposes
> >> an
> >> interface to thermal sensors on the system-on-chip. This driver
> >> implements access to the interface. It supports reading the
> >> temperature, setting trip points and receiving notification of a
> >> tripped trip point.
> >>
> >> Signed-off-by: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >=20
> > Wei Ni,
> >=20
> > what do you think of this patch?
>=20
> Reviewed this patch, it looked fine to me.

Can I take this as a Reviewed-by?

Thierry

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmnEt8ACgkQ3SOs138+
s6FZ0w/6Al4+VmWq6FEVFfYY0w3KMRvyThTfyx9/1VmnG5x+U4CHOddk1ouf7BVr
zI2m7o3BzE5rx0GpV/D+W9cTRTnSp5/Pc3PScpjCwk0IhGqCg8McHuF2btNHdW0H
eVcQ1DgeBpVSj+qyzHLqBp3YyPubUn2jy2PpSbLN3yEyQSrWfEuZG4FAN8hjp5pv
CO8vqJWTWCruJaUs7qYeMTeWdYlQFFjUUQtVFMSA0vQHIwCZJ9pUNyk7dYhPPWn7
uKJvkdFFpQ5NT1Tnkh8sMrf1puE3+rjMnG+FiuSSmnKEa9CJpLc0wiAR1lfepAhM
izk2iWuqROyBh3NuOT51VkBtCRqZ4iSMC2HjsHhfQnt/E7yIx9aWuGmH9xzoQz8h
vBZaDfyee9rQLQ+RyOd1wanFLQOogYm2F7rhmkJzmwI9hs+QhM3k6Yn1196DDaDC
z6hi2g00gusZCCmQsvhzMHy1wfC2fXGHlDEbFbBIPQ7xNGW6D9aNAO3ZMYHy6E1T
zgxVHX72QtFC/IKI74Cfs1t1tVbp5H78Xppid/wt8qojeP0SOZ/yqLpgKWHlxXbN
IVA4bXJ4S5Fxm5YGDPrZ6IlgpXY4TtNeGB4aIvtPitLWh6tsbVOtKoTdM9X4Q/J/
Esl/vplmRw/tOohpXACiCKT72AFzJ0E1roLu4xVahxVdw/8qSFw=
=4DhS
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
