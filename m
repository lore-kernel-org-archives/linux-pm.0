From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/1] power: supply: sbs-battery: Cleanup removal of
 chip->pdata
Date: Wed, 21 Sep 2016 02:05:56 +0200
Message-ID: <20160921000555.kzvsbq7vsfnfbe6h@earth>
References: <1474333272-13980-1-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="flh37dsg7nsm7dmb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752187AbcIUAGE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Sep 2016 20:06:04 -0400
Content-Disposition: inline
In-Reply-To: <1474333272-13980-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: arnd@arndb.de, linux-pm@vger.kernel.org


--flh37dsg7nsm7dmb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 20, 2016 at 09:01:12AM +0800, Phil Reid wrote:
> There where still a few lingering references to pdata after commit
> power: supply: sbs-battery: simplify DT parsing.
>=20
> Remove pdata from struct=B7sbs_info and conditional checks to ser if this
> was set from the i2c read / write functions.
> Instead of call max in each function for incrementing poll_retry_count
> do it once in the probe function.
> Fixup null pointer dereference in to pdata in sbs_external_power_changed.
> Change retry counts to u32 to avoid need for max.
>
> Signed-off-by: Phil Reid <preid@electromag.com.au>

Thanks, queued.

-- Sebastian

--flh37dsg7nsm7dmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX4c7gAAoJENju1/PIO/qaqrQP/jk/IKqAMHjVjJoJiLj7fc0d
LJ3GE6XO5uzva0dcbcDP33yxH20TC88LSL/RsuxM8OcAVjbge19GSvcPjp8oA8aP
vP/SRgcMrspKD7FvTguDkQyl8f27moY3UfvkFmqY+zrqdbcxJofsGasaCMM1nh3o
Ng2NMoxXs3TAdMdDp/mMc6NzktlX2fDJ4N4U3h3ILiJfXb53sUXI5Kq3blPhWa0O
5zpz5Xk6YGs0MyMj0SnzGWDOkcUfCxCKzSOGEayO3KlfjOR09U+uebTGvU6qQSWv
PgEjYLQV9G61Jj/6Q8VjGz8pzrU/2n1BILdOiqY94Hb9z02qlJfFiEKUk+yGJXve
04y0YyaFRhYhz35+ayDwd5CMaMVsw5xW+GI0u9o/3OMWRj8UpDndMHHD08P/ApBF
aMP1v5VvCZtjxayf6ePPPhJymdhMISvKSkGaS0yARgD3Z2F1/tO22SsmTpxwDI+k
SgWafc4CKyLl46rOsY5pT96ff1YZgva6g8aFXdn2XaLiNMXWDpBODvQmpQnUs3ar
NkfD/4eQOgw6//xOxNVYItBiNClV3U0P2qUxLOsVQM/KFRW2PpgDhEXJvjXACXzo
Jt8V8uzpLVlQSQViP3FVJy02rY+Xvu8QiYY1AGqEgB5ccn3G3ute53hd5crS+5lC
7A/XlyawMlDCao9AlL5t
=uuoy
-----END PGP SIGNATURE-----

--flh37dsg7nsm7dmb--
