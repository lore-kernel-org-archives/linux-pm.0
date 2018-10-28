From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] i2c: sh_mobile: Remove dummy runtime PM callbacks
Date: Sun, 28 Oct 2018 22:22:37 +0000
Message-ID: <20181028222237.GG1882@kunai>
References: <20181024135134.28456-1-jarkko.nikula@linux.intel.com>
 <20181024135134.28456-2-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gm5TwAJMO0F2iVRz"
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181024135134.28456-2-jarkko.nikula@linux.intel.com>
Sender: netdev-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-pm@vger.kernel.org


--gm5TwAJMO0F2iVRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2018 at 04:51:32PM +0300, Jarkko Nikula wrote:
> Platform drivers don't need dummy runtime PM callbacks that just return
> success and non-NULL pm pointer in their struct device_driver in order
> to have runtime PM happening. This has changed since following commits:
>=20
> 05aa55dddb9e ("PM / Runtime: Lenient generic runtime pm callbacks")
> 543f2503a956 ("PM / platform_bus: Allow runtime PM by default")
> 8b313a38ecff ("PM / Platform: Use generic runtime PM callbacks directly")
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-next, thanks!


--gm5TwAJMO0F2iVRz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvWNq0ACgkQFA3kzBSg
KbaZrw//SNsMT9sG1waPr8dZfdP8N42mjVNRfqABCx+9SUftMbMe+BbeWxyU7j2P
tk3HxyctyyTpjG3NbnODXzCv5Jk29XcxV8CxNe8NZdxGSObwjGnS5yT9lW+Ptn8t
A8vZKSlc4q56Y6NpRtk0sWHPk3X/XvJOiEs7ClvchoJjQJ6AG36xAqsq0uhqYjx0
b/7nuj2PcmRoP5aXM7Zo2ZJs0jGcyfX9RSDVGLGa45rxggPJB+kDbt0KHkRSP485
zQ59Qy7yxTNAyfMwjV9LYp4+uhq79DTZUyoYilwTCBmUP5HDMI8yqxikrLuZZ4Ze
Tk7BEvLPO5MiucSzkgsZSAMEY/TIylU7JA36uUIgBuo+5wxS2e1K8xRO7Y8hzrv8
kU1ndKW7Hz7bBKdY4AMg8NUIRbJENF7EqnUNMxLsQgODlE+RYEPhzVpEF+vcyVhL
/z0C4XcLLUb9zDeIWuwtnjPhKT1BkJxC2/d/+ztaY7NDeOG43KR90kZUyRW9oF29
hRJd4MQNoFIMpeEYx3LLDBOjNGvlkGBlM1E/x52AluUA+boqDsyXJPtfSRvdIvtT
rYjbur8sVIXHPLEmg5ysjVJrvYNp0HtB2qWc/j/sPnaMEGwP9a6KSIAtGbJ8TrrF
/zzSxmjU88EvmWt0YmBGARTMbPppjZ1JwD6lXyDbNdaZZ0qO+1w=
=+Vek
-----END PGP SIGNATURE-----

--gm5TwAJMO0F2iVRz--
