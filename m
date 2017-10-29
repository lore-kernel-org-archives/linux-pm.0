From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v11 00/10] Add sbs-manager with smbalert support
Date: Sun, 29 Oct 2017 15:37:24 +0100
Message-ID: <20171029143724.jz4ok4vjzmsveh6h@earth>
References: <1503567070-115646-1-git-send-email-preid@electromag.com.au>
 <66235a12-a209-be89-5bfd-dc69b769cab9@electromag.com.au>
 <20171028225552.4uhsqx6fkurmcn3j@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ymbqhjz6yhi3zd3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751688AbdJ2Oh3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Oct 2017 10:37:29 -0400
Content-Disposition: inline
In-Reply-To: <20171028225552.4uhsqx6fkurmcn3j@ninjato>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Phil Reid <preid@electromag.com.au>, robh+dt@kernel.org, mark.rutland@arm.com, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, benjamin.tissoires@redhat.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org


--6ymbqhjz6yhi3zd3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 29, 2017 at 12:55:52AM +0200, Wolfram Sang wrote:
>=20
> > > Changes from v10
> > > - i2c: mux: pca954x: Call request irq after adding mux segments
> > >    Added Peters ack
> > >    renamed label 'fail_del_adapters' to 'fail_cleanup'
> >
> > Any comments on this?
>=20
> I just pushed a branch with some minor fixes to my tree [1] so that
> buildbot can check it. If all goes well, I'll post the patches tomorrow
> and merge this branch to for-next soon after.
>=20
> Thanks for your hard work!
>=20
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/sbs-m=
anager

I see some additional commits:

https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git/commit/?h=3Di=
2c/sbs-manager&id=3D7b75a22a903e681d920f383f7c952e5420db7e19
https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git/commit/?h=3Di=
2c/sbs-manager&id=3D567b0a4a7997406633e26898f68a623637f525c0
https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git/commit/?h=3Di=
2c/sbs-manager&id=3Df2b1a502784f996ad2686d7d3f8ad62bfdc89b43

Those are

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

--6ymbqhjz6yhi3zd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAln156EACgkQ2O7X88g7
+po7HA//XG5u8zT97rO/LACmNMIQINXfA55jHDs1TGmc5y2CWSCWzyZ5Xsg9jVhg
Dt0fhK0Ssw7Nd3QJekwn/1TE3hgcFLFlNHpZ0ADifvX6aQTUTp95kdvecLLsnpjq
fCdxHs7N89CXjzGZddHQplKOsJ8zBJOvceC9PvpDY8dolU7lm0mow+gEBfBJuKtL
M4uotSUheq1COJFIFOSUtUEyvU213hgcvghOoJi0Ta7Mv++bfhGUXlWgN4UDorf8
kRmuRZFC6KRWQGwqIEsulsrohI9g1HMO11Vs6EonMR3aMcPvNS3gqYOUBSbpsNd1
MfVm48dZ3CWFgHAvrTzYGatXLNAp6SNbgY/uo7ax4xPL7XYyNG1KDhm0Uyb5nAHK
pHWfYjiymKVjkko1yKjczVZcP5tPqXJVPoBx1KDx246tdmohjy2EffDb8/OrmBt3
p6PQ1c/cKmNNGGGf2zvfacGnifBJrSVX3z4ll5XhWrHZU4gkPyzOkS+elNe51B4g
ZGv4M3+XkVSHhvbwxf8t+Xq7uLV1EMe8Wq0pVVKACgS80ACmV3eu3zmjvnjlKTQJ
lylQobb57rOuoYrQw00H3RyrlcIclM1t9ylnd4x6pVEYwl3/mz4H3/t9ZgPc1Efi
PTuHKKYTLozG7lMv1Q2AVKbDrYCc/uwd//SmK1YNnlZ3Ez/UU0c=
=Cpv3
-----END PGP SIGNATURE-----

--6ymbqhjz6yhi3zd3--
