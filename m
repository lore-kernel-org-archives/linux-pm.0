From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH] thermal: rcar_gen3_thermal: Fix init value of
 IRQCTL register
Date: Thu, 28 Mar 2019 08:06:33 +0100
Message-ID: <20190328070633.GA902@kunai>
References: <1553677398-7896-1-git-send-email-na-hoan@jinso.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553677398-7896-1-git-send-email-na-hoan@jinso.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Nguyen An Hoan <na-hoan@jinso.co.jp>
Cc: linux-renesas-soc@vger.kernel.org, geert+renesas@glider.be, rui.zhang@intel.com, jslaby@suse.com, wsa+renesas@sang-engineering.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com, h-inayoshi@jinso.co.jp, nv-dung@jinso.co.jp, cv-dong@jinso.co.jp
List-Id: linux-pm@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2019 at 06:03:18PM +0900, Nguyen An Hoan wrote:
> From: Hoan Nguyen An <na-hoan@jinso.co.jp>
>=20
> Fix setting value for IRQCTL register. We are setting the last 6 bits
> of (IRQCTL) to be 1 (0x3f), this is only suitable for H3ES1.*, according
> to Hardware manual values 1 are "setting prohibited" for Gen3.
>=20
> Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>

Yes, this is what we discussed for "[v2 PATCH] thermal:
rcar_gen3_thermal: Fix init value of IRQCTL register"

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyccnUACgkQFA3kzBSg
KbYuDg/+M0RVneSw2K0/P7IFF8ql31xrf3WCWCtgmbRkbHAcwWUgY9+xbs0jaF1h
y+nnHILeimX02peBa8dT4WHIDq3zKi+qN0IXMZ9XgU52kz4COlE51MbCtAtDhhgh
O0tHoRCky7U80Qn/8j91QBC7G+vS7vNMaX6ES2ZLEHnrr+m2YjK7olDNLap+Y7qc
oq3zB06fsdCT4qnow2DGCJllorICPATkv/41KI7BK59Opsm/nVnL1HbYH67IWdeh
c+kf1QvxwYrGQG2Rgkw9hOjRRoaZJcsohrfRotVMudthCK3mq7snR/CKUeC/2ylT
Eo6aQx10N/qo0CYxwMb63uz8J+L043bRE81kA5V8CLNaXRwyTL8BObpMAwoQyw01
Dv0sN6ACfiIJ8toYqPVnOFkJMeHsYksmg5TrBoQ9CJ+BsXYEccph0TKSBGuJO/oc
v/GZLKc0GAuwcY0BlthR0p9wu6X1UfcxA4/JHl9H7Tk1vaEdpSgkAcnKn/S5gDS2
rV8Zr5F92AZDGXY55OZC73rVvB7IePrvNcLqUCPk98IAazkj5yj1bCiXpkq6gqpO
iAn3knawf45BP4lD8Yal6lejucnnMsbWhrvsEBOTnG5W61CQ41eS6XZaScqZdcfS
pibHXwG/6re54YGt4dPgwMOp6Bfwnd2nA4tWZcWkrowsOLNY5mE=
=7qpK
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
