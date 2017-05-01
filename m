From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: supply: sbs-battery: fix the sbs interrupt request
Date: Mon, 1 May 2017 13:31:05 +0200
Message-ID: <20170501113105.3uz3twrilwhhkcg4@earth>
References: <1492744397-7105-1-git-send-email-raitosyo@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e5dbd4ilpdqb4o3g"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492744397-7105-1-git-send-email-raitosyo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: raitosyo@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--e5dbd4ilpdqb4o3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 21, 2017 at 12:13:17PM +0900, raitosyo@gmail.com wrote:
> From: Ryosuke Saito <raitosyo@gmail.com>
>=20
> Since we use the default primary handler for the irq, IRQF_ONESHOT must
> be set. Otherwise the request fails and the following errors are
> displayed:
>=20
> genirq: Threaded irq requested with handler=3DNULL and !ONESHOT for irq 1=
29
> sbs-battery 0-000b: Failed to request irq: -22
>=20
> Signed-off-by: Ryosuke Saito <raitosyo@gmail.com>

Thanks, queued.

-- Sebastian

--e5dbd4ilpdqb4o3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHHkACgkQ2O7X88g7
+ppgkQ/9HG5Q+f/CCeTKUM8S8p3tvLHrNVMfMXxISFjZ827bBCrNXhwB8B4nIsEm
dJQvGFHtWmkjFMrUj/EFKkII+ps49DhNwT6od5RmCLP8ZNgXA2IdxIyYmI1P38dR
g82X6nn+CLR/f5PlzLrYYc9Q9rpy5Gw4CgjAQlNv71loayYfbEA97QA4JTZRrojG
Lqet7vpsHMxbjhR8zmMu0plaMfCOjufn26mg4kudo+dqZHGoVPZ8eUFQxBhO4WC4
owfomI+6Xn48w3Fqz5OsVGuOPCZiCIuN2SFG6GRhQFaacfHcv6gar1usNngrpe5v
mPEXDT0sdpE1x0vLwQa2aYfCLcMGxvjA/uKtAL4z7wTtt1EEli8Gex20/SnYvO37
L2AAhgRSOh1sM9h+nUUd6VySV5ysQghKWuRNVchzxalQXORbXZbXrq9rPBdEtAVA
N53qiZKJ1KzdL10j3BK0LMSpxZ46TZWCBYbYLfsc4L5XHeoLT+v0uplDg6OcyupN
hsL+r5cycFvSc1ORdFbGes86+/eashHLcnhCU5odHnB09OeBzvmuBcAQhowhnVT3
6enlWy4gB+FM4YgqpD+J6ynrj6PeJo6XzDTfzhl7kRifmFVat98+Ttzgnl6/IGMb
+NhQ3Gt4sCXd0sf0MAqKcUfjPg8pkM5it6IVfuDKFwZA5Cp0qhI=
=uDzM
-----END PGP SIGNATURE-----

--e5dbd4ilpdqb4o3g--
