From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: Fix: Bind Cooling Device Weight
Date: Mon, 5 Jan 2015 17:24:58 -0400
Message-ID: <20150105212456.GA31536@developer>
References: <5492C634.5030604@arm.com>
 <20141218134334.GA6276@developer>
 <1419218315.19619.6.camel@rzhang1-toshiba>
 <20141229104021.GD32102@e104805>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:33903 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbbAEVZG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jan 2015 16:25:06 -0500
Received: by mail-vc0-f176.google.com with SMTP id hq12so8619640vcb.35
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2015 13:25:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141229104021.GD32102@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Kapileshwar Singh <Kapileshwar.Singh@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2014 at 10:40:21AM +0000, Javi Merino wrote:

<cut>

>=20
> The patch "thermal: let governors have private data for each thermal
> zone" that you applied[0] allows you to do that.  Governors
> can have a bind_to_tz() op that can fail.  If it does, then the switch
> doesn't happen and you continue with the old governor.
>=20
> [0] http://article.gmane.org/gmane.linux.power-management.general/54163
>=20

Agreed.

Rui, the naming '.bind_to_tz()' seams to be appropriated here, even
considering the validation perspective you mentioned. Binding to a
thermal zone should be the best opportunity to check if the zone makes sense
for that governor. Don't you agree?

I think the .bind_to_tz() should be enough for both cases.

> Cheers,
> Javi

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqwEeAAoJEMLUO4d9pOJWB2UH/3bB1o8q6pGmbiYKUiR+JpkI
n2Gk2vUuCdEzeHN4kuNiNgPGmdkuM3T9RIESxe50J985IwxkTQ4LiE/vjR1p5QN9
qvrG45ISoXPUd8FGsg2XOY9Nit7DMWS1/PxK+6un86dsOPr1hYyjdqBye39ei3yc
8Ikxc7Rxd8YQuKQo3IkOQndhYzPQdRoQcFeNu/mcNqgRwaxQL9Yx3bvy2bs0tgBC
mh6aUv3PgEEmukYyirPaFu7dRaewvDUYLN4oG7eMVY22CeZn9vw60yw4cigcYg64
p76MzbzwlNsStInX/sCYdynq0cjgKuiaUhKMgiuMYjy2oJFhDLhXVGzwszvcDxw=
=78Ex
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
