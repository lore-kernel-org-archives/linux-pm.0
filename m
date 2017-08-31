From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 5/5] thermal: Add Tegra BPMP thermal sensor driver
Date: Thu, 31 Aug 2017 14:45:06 +0200
Message-ID: <20170831124506.GA16437@ulmo.fritz.box>
References: <20170724162918.21050-1-mperttunen@nvidia.com>
 <20170724162918.21050-5-mperttunen@nvidia.com>
 <1502420276.2598.5.camel@intel.com>
 <4315091f-03b1-2df6-b224-6a29d3261371@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4315091f-03b1-2df6-b224-6a29d3261371-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--W/nzBZO5zC0uMSeA
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

Hi Zhang,

given the build-time dependencies, how about if I take this into the
Tegra tree with an Acked-by from you? I can provide a stable branch with
the dependencies included if you want to pull it into your tree in order
to resolve dependencies.

Thierry

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmoBM8ACgkQ3SOs138+
s6EJ4g//VJAujreJqc5nLiRrjGofj7RIRTYAG6+78gOYcpoQ6CcEtpkOuJaIppbS
Nyao6tZ0nwxEvRuRzSPW3Z3L8XIfcnhyxtstm+WJnr2UIz02XRBbzH2w7NEHt7W3
IkEGB1R2iCazx0KhbgJZOOKuGENu6g9HzRS+YRdQiG8+KRBj04KhiBcoGZXyWx4G
pf/pURzXmORtN7D3Rb01XEVxi0LFhCY9H85cEzJOriy9xyCrHSwXEJLklY1vG/hm
8W2p17aRJ7WMO4AE7DtIPvJvtNTFOPtTFcBQ3ZSFEY5V9nuL+rh1O79FdhkCzB9O
zcPxYS0qLiu2F5zc8zWGEtvLlg+YUN/TrHiQcXT4mRRXepwb+HECYwLQsR7bAxC+
Nc395Gs9LABsyzzwnzi3hK+aLI16hclBLI7xzcgZiN+P+jBtKlwvQT6hI82EBfnk
8WCSAsoqdbOMKS+0z3hRo/fupqs952tkawzwtvwHQmlff8xMcc4inv/p6no1ENfx
v3NcieKjxuQ+QDqnnAkQN1hQ2tkTEEbB5w4lIEHlonCBduvor6QaC+MYxnS2j0dA
Yg5FfTTS6ufUiPIzlFxoNnxYry+1nIP1l+Qi76wKj9z26q4v7Wo7a/R+kBNZU7Jg
KuOoQFQLy6ogcY7QSR32wPtH0j0Wyk83ifSce3YKJrI+peCapM8=
=kzv6
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
