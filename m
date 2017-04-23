From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 1/1] power: check return value of devm_kzalloc
Date: Sun, 23 Apr 2017 21:44:33 +0200
Message-ID: <201704232144.33603@pali>
References: <1492938236-9928-1-git-send-email-bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1625469.KuDvKWFzGX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1492938236-9928-1-git-send-email-bianpan2016@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pan Bian <bianpan2016@163.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--nextPart1625469.KuDvKWFzGX
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 23 April 2017 11:03:56 Pan Bian wrote:
>  		pdata =3D devm_kzalloc(&pdev->dev,
>  			sizeof(struct isp1704_charger_data), GFP_KERNEL);
> +		if (!pdata)
> +			return -ENOMEM;
>  		pdata->enable_gpio =3D gpio;
>=20
>  		dev_info(&pdev->dev, "init gpio %d\n", pdata->enable_gpio);

What about calling "goto fail0", so there will be error message about=20
failure of registering isp1704 like for any other failures?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1625469.KuDvKWFzGX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlj9BCEACgkQi/DJPQPkQ1I7FwCfSeRR8JMSJt59PyTi6Ffh31Ab
zSgAnRHBHmXqlDyFR1ulzIMS7Q+luUhw
=ifi5
-----END PGP SIGNATURE-----

--nextPart1625469.KuDvKWFzGX--
