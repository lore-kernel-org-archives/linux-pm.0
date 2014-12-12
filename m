From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: imx: Do not print error message in the
 EPROBE_DEFER case
Date: Fri, 12 Dec 2014 09:13:25 -0400
Message-ID: <20141212131323.GB19853@developer>
References: <1418332300-7859-1-git-send-email-festevam@gmail.com>
 <20141211231405.GA19853@developer>
 <CAOMZO5Ao2=wbKj4VtU4bq5FhMfeOaMW5M9kmjf7y7o0vx-WJDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:41850 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967578AbaLLNNd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Dec 2014 08:13:33 -0500
Received: by mail-qg0-f41.google.com with SMTP id j5so5385120qga.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Dec 2014 05:13:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5Ao2=wbKj4VtU4bq5FhMfeOaMW5M9kmjf7y7o0vx-WJDA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "rui.zhang" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fabio,

On Thu, Dec 11, 2014 at 09:18:25PM -0200, Fabio Estevam wrote:
> Hi Eduardo,
>=20
> On Thu, Dec 11, 2014 at 9:14 PM, Eduardo Valentin <edubezval@gmail.com> w=
rote:
>=20
> > Thanks for your patch. But I am queuing a different patch that does a
> > similar job.
> >
> > https://git.kernel.org/cgit/linux/kernel/git/evalenti/linux-soc-thermal=
=2Egit/commit/?h=3Dfixes&id=3D0f1be51c358f740fe5183bd0bcd60076fdfb53d0
>=20
> I am running linux-next 20141211, which has this commit applied.
>=20
> > Can you please check my -fixes branch? When EPROBE_DEFER happens, we are
> > now printing a debug message only.
>=20
> On linux-next I am still getting the error, so I still needed my patch.

Understood. I will be queuing it in my -fixes branch.

Thanks!

>=20
> Thanks

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUiunsAAoJEMLUO4d9pOJWRfcH/RH71xUS6WWb8PntO8ApXYqT
0sX1SAObX35OdI/Vg44XXBDWXOuafBbmhJsWs3U/fgTVYoQGmSmxlkmEJuG3mWO9
vzX3F8qEnBA/YJMCQ76Vjgbgqker/U5jjSh95UGaV7XQ9Guh1AxBkSCLWVOaO4Po
VM1cuUaTW1R0nXeVlyED+DjC3pzs3e8an42nR2pWB1cNWMT9HWGqZwd29nroCC5d
ZmFuGU0K752y0jJU0EWK+K0+/ct1nW8X17/CYm2pW3+HRBIDbB5w/nPEjYgi7YLf
Ba80WhMRE3SvvniaOQdGKLpQTNSe/GuBW/v4kryTOTBrq6SQrjGp3j6njXPJzW8=
=OiJX
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
