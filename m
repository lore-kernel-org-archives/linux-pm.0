From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [patch] power: qcom_smbb: test the correct variable
Date: Thu, 24 Sep 2015 22:36:05 +0200
Message-ID: <20150924203604.GC3125@earth>
References: <20150924184137.GA28804@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35502 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263AbbIXUgQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 24 Sep 2015 16:36:16 -0400
Content-Disposition: inline
In-Reply-To: <20150924184137.GA28804@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Courtney Cavin <courtney.cavin@sonymobile.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 24, 2015 at 09:41:37PM +0300, Dan Carpenter wrote:
> "state" is a bool so it's never less than zero.  The intent was to test
> "ret" instead.
>=20
> Fixes: 56d7df8716b2 ('power: Add Qualcomm SMBB driver')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, queued.

-- Sebastian

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWBF6xAAoJENju1/PIO/qaSg8P/RZQTY4Q+kaiB7xveG1SHyer
F9Q0GQoj134QmaibZk75gdDg6m8ht/CspGLnF4QZ7al50oOz0Ryu8UTp9B+R9HoJ
sN5/R0NFB1rMfXMnDeJpyD5CA/R+1N1/fS4vk55sFxz9y2hJvPIPIhHOiEP4QW+c
NsHmiG7h2tnuOYr1Iog0b6zEy++Za+HAPvrxknYOhGOVG17QlJWbfl+NkGvvAeBL
HphgluAERxpUTCAacnjSRzoMWqkOTLv+OEu90hwXq1ggPB6CAnyRf78xRDEn3uoI
Hgh1wWKHZ+emUW12vevB0s7kdeYScMvIEDgnsAZKuThEsOAEWBj2jRAzTuYcOIZX
KbZp9Y/vqK5A74BeDLLMDedRiVAVP5OWlqICQbxe/vAQEvbNBbsDi7kgOXtaNS3A
7+5VU7fyp5rN4Qsg+1SqX7RE/jo/TjQhloe4MAPJ3YEOUcg217tqNwGI33+L4CPp
0FVuavsOPdH+sJn3+9u1mItWzCc1e0EECh/NRxvIgS6XdJyVXg4zFtiXdn+FPfqp
sxUDKQ5TFA1/sHZX7veAf3XZyWxwRPsBUaDg0Qs+HrBaxQKvI9vprT9f3/rfU4qN
i2An0cvMxOF0Zd/Dv0LWqE3wo4F59sldb8BoSm5zxjBbzaasQMhtRpX6niuC0y6u
9S3IoSiUEZXu08EJq5dA
=zOju
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
