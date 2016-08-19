From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v6 1/7] power: act8945a_charger: Remove
 "battery_temperature"
Date: Fri, 19 Aug 2016 17:43:36 +0200
Message-ID: <20160819154336.e6etmygoxnxnngd6@earth>
References: <1471569215-6046-1-git-send-email-wenyou.yang@atmel.com>
 <1471569215-6046-2-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dd5nxqelj5ii35pz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471569215-6046-2-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--dd5nxqelj5ii35pz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Aug 19, 2016 at 09:13:29AM +0800, Wenyou Yang wrote:
> -	if (charger->battery_temperature && !(status & APCH_STATUS_TEMPDAT))
> +	if (status & APCH_STATUS_TEMPDAT)

This is still wrong. You removed the negation.

-- Sebastian

--dd5nxqelj5ii35pz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXtykoAAoJENju1/PIO/qa9HgP/Aghb7YDvdH1I2+3ujzKlSIZ
Aq4iDx/gJeVdaIiU5Z0jHx7NPbZBpWerRwGDmN2gcmKLBqM0DPn+OqqCT/5OBQW1
ZxtlK1XlxfSyCG08xkpqpIJr7a09ZutqZQymmxmZrepxsvsM3kqcZ5YR6sk4tJ0y
i6WI77kEzJMJhSJ56jesQRIsSmCi7GL7iwvNkVXbi2Rq+wsc8WcQCDIBOPUiYDBm
KckqPuil0ExATKtxO8g/dmKQ9gkfHvu/Nw2blzmKdnpjZ2tduEitjPMT0VKt521O
djV747UALJd9WFVjKLmHmU2Iirfkwl5B/etak8i0JPdyshkDg/H0V47K6ksT++zX
/nHDuy9YhV0NtXT04+1gkoH5sAUAyR3S89jr2KbJBLp6H9rYOdVy2TV/kuEX7Yh4
72zKkfIiJMjb2CNIBqIumHolkma2xWnQiUYJIh9Z3B13q8iMs3yN2VXCmi3MsFn4
167Uc8z29QAp6xflED2sjJDn7qAQRIgGHHvDGg40+gWIUcsEdqWvdJv8gtUPMuE0
7wt/egAWaDK9XtC5NNAEtK8Xza3FG9rV3+XuBNPqBliqe6CVkX2nksoqEjlVM3uF
G6mKI9iwCfaymsoAdgHbznDgG0/TRIrX9g48MCS39ue4vp4cZELSoox0qTKnefrS
Rjll7POZro4gB2yQiAke
=O+ff
-----END PGP SIGNATURE-----

--dd5nxqelj5ii35pz--
