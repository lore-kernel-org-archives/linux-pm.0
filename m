From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/3] soc/tegra: bpmp: Implement generic PM domains
Date: Wed, 15 Mar 2017 16:00:36 +0100
Message-ID: <20170315150036.GC29259@ulmo.ba.sec>
References: <20170314191516.13083-1-thierry.reding@gmail.com>
 <20170314191516.13083-4-thierry.reding@gmail.com>
 <06005f89-a3fd-ce7d-57f0-e77e866f7e8f@kapsi.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36614 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751358AbdCOPAk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2017 11:00:40 -0400
Content-Disposition: inline
In-Reply-To: <06005f89-a3fd-ce7d-57f0-e77e866f7e8f@kapsi.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikko Perttunen <cyndis@kapsi.fi>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, Stefan Kristiansson <stefank@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2017 at 12:49:47PM +0200, Mikko Perttunen wrote:
> On 14.03.2017 21:15, Thierry Reding wrote:
> > ...
> > +
> > +static inline bool tegra_bpmp_powergate_is_powered(struct tegra_bpmp *=
bpmp,
> > +						   unsigned int id)
> > +{
> > +	return tegra_bpmp_powergate_get_state(bpmp, id) =3D=3D PG_STATE_ON;
> > +}
>=20
> This should also check for PG_STATE_RUNNING and consider that to be on.
> There's this tristate thing for legacy reasons..

Okay, I've made this check for !=3D PG_STATE_OFF to avoid multiple cases.

Thierry

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljJVxQACgkQ3SOs138+
s6Hv/Q//Qt/BbrJbqKpbKQGgfuT5vhCTHHghQE+D9MAlUhwRfd3b7G58JsuarVF6
uSqvLzJELHaBVs+0L13GZfJFPTuRXXUuBgiCqYKNYdHDMOc2mZ11+UH+HG248lM7
aKjDOwbtmbbd2/zXP+a3Rmkayus/t8OmBYueaw9YdQAkfLd/sGNjjGkCYfeDA1a4
ZEQ/dB2yoIe5cNPvQJDRxFBCmP5ODEFo14BVke410tDue1b9LTGtncmN8Q0b1JhC
3pXed1hAqwCc8Lp8+q6+pmTzlmKDGNPfjtC+Dyp5Tbfvh56mggXgb+M6Ug0nbAuj
O8XLuFtH+w1IzPjeuSp6aYY/K8KjJaF+UqJR/W1eKER9+iM4sBC6rSklCxcHWkY+
kXv2qzihIB86vvykkcXrAbg6iB+ZzUtH81anI3ZTtVzGfFUW24kpmc3BZ/aArFHW
u2J9u3gp6Y9s/oUa2v2gX2qCA+KIDLq0ejez3E0qZZHPLrSvhXgaf6JVcwp9cAXa
XkbjDWBHf3KFUBbXI0+pZKUwlTGwB6JfqE3o0vgFw1woXaM8ZV0R5rtOa4NgnkDy
6iqXhqpvRpeQuFXwclBl9wIS2MNYLItSNEce3CgsGNo0K+ksNdgMJxbVc0iORfZ3
m7XWj3j58TvynoQGLuTfhz3rRSVeww+Wgl8dy6tnK8U2U3MUrtU=
=1PDe
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
