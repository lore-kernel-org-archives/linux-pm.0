From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/3] net: ethernet: Remove dummy runtime PM callbacks
 from Renesas drivers
Date: Thu, 25 Oct 2018 23:54:48 +0100
Message-ID: <20181025225448.GA20207@kunai>
References: <20181024135134.28456-1-jarkko.nikula@linux.intel.com>
 <20181024135134.28456-3-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181024135134.28456-3-jarkko.nikula@linux.intel.com>
Sender: netdev-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-pm@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2018 at 04:51:33PM +0300, Jarkko Nikula wrote:
> Platform drivers don't need dummy runtime PM callbacks that just return
> success in order to have runtime PM happening. This has changed since
> following commits:
>=20
> 05aa55dddb9e ("PM / Runtime: Lenient generic runtime pm callbacks")
> 543f2503a956 ("PM / platform_bus: Allow runtime PM by default")
> 8b313a38ecff ("PM / Platform: Use generic runtime PM callbacks directly")
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvSSbQACgkQFA3kzBSg
KbYGnBAAmp5zgNu+6o7Pl5OOiVuZ5cK8mN103rg589Oi3cJvdw3/H10OzQlc7Id7
OGUqtO/nSOgDRvO+xHbvERAknUj+WxYwYdtHFTPE4+I07U1cZ2tZq2upERWIUn5X
I+808CZwjkgUtGNt5vf2eAmyxIR/c3Q0n8PxeIt3rUhsScUPdZzT82cK0GRTgi5f
i6E/F4Qzmlsw/LHKXxq0dYukuIo1s7SCP9j/kl83BCbIWimLLvwU/Sisdl28xk8y
uzMCxiXjYLunrns37ryJPBpLS6TBoLb8pQEBmgy57xSrJ5JbyJnVbXIoS+5IOGNu
iW8ASzbXdow+0V6fGtoerWbXnJoZUhgy+1vs3sdiUTDQkaoOCDfvx5mbejJGk96c
9lPuP1nq1bsIKr3zoE+YnJ/IU8YVvgLHGk+KCGnSE3aSp/EQAgXaWyqnZ2mCQ693
u1ilFp/P3QE1nJtTMZBcUU9LeFjX8/oYF0fylFIMbPNBYBE7m963moKt5sarDNBX
gBvlur961KQ89Ru5b2fi8H7qgqM9Gm2GnOKg7BJJp+mSEPlC5VrSEILNRUnDGuMb
0Qu+kDPE8W0rMzI1gbED9c1HgVda8Hxrn0Xp/yNkhu0LVTHhcMOr3XXpvlgpTkcw
WZrFL6CysQKcZF3Sre6UEc6a+Lj/Saw//Cj1jMUCeZOjNpwX9OY=
=G1JU
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
