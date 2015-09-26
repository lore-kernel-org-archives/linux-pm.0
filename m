From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3] drivers: power: twl4030_charger: fix link problems
 when building as module
Date: Sat, 26 Sep 2015 19:23:54 +0200
Message-ID: <20150926172353.GC22315@earth>
References: <1443212447-5841-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57037 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbbIZRX7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 26 Sep 2015 13:23:59 -0400
Content-Disposition: inline
In-Reply-To: <1443212447-5841-1-git-send-email-marek@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, neilb@suse.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, hns@goldelico.com


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marek,

On Fri, Sep 25, 2015 at 10:20:45PM +0200, Marek Belisko wrote:
> If either twl4030_charger or twl4030_madc is configured as MODULE,
> we get build (link) errors.
>=20
> To solve, the direct call of twl4030_get_madc_conversion() is replaced
> by a call to iio_read_channel_processed().
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Marek Belisko <marek@goldelico.com>

Thanks, queued for 4.4 together with the DT binding patch.

-- Sebastian

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWBtSpAAoJENju1/PIO/qa7XsQAI0OKnqgAPA8EcYcOgVODjxT
g80HaNA1m+Wq/KQtfP4t5CabCH0T20b90vXEl3tnqYtc8Dw9Be4AQzlWyf95PH/x
jgOSuSbz2Ma/MftO9livTv2heoLQJt7rBXeml1TVVn3kCc9SFzrQrTvS6SeblV2c
2MJAdxG5biK58RTp3pUTT1zb7xoCRtUV1pX1t8jyXDJ6h9pJ/PHsXo9DRTnMqHMb
stqoYbLEQierFHwzT0+TFEgFAllFE6LCzpGwuE08eCESqUsVnjbPkUkclG7amvs4
hX7C5ZPDs7zYX37RVnqXEyDHnk7rgvoFuu+UpqTViJUk3ZS2fAZSOKGV48WcLGtI
zVfOcAVgr8IJTWtjOvOsOhtqN5pnpDg8DU70fETIRhSQBN+H/SzLaUw0fHiT8stO
+H14RCnq6Qk9kpcqENBdOlHJ14rLBd6BTBaecEjX6qhZ19NIvxwhx6LbutTfDl7W
RAVZhETz9UiQKE3MAeZ2u4VX7hqPwdtO/ze6/L/CBdHR8+hJPhuOQr2SRsVWHUkm
Mh16NjzqP86FQzNollnxujP9w7tipTzvQ6w0KzD0LjNT2UsmdyDsqQhrSItADlNJ
k4eMaNk2sELZBLM69VrmoPQSD3PBQ1JuXf60kFaBy/kvohLF1xcNKFTcJmuYF9Yo
4CPbfsatkfsPr5T7fUIs
=gtH6
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
