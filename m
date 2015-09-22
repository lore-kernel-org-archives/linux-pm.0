From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 1/7] power: bq27x00_battery: Remove unneeded i2c
 MODULE_ALIAS
Date: Tue, 22 Sep 2015 17:18:58 +0200
Message-ID: <20150922151858.GG2533@earth>
References: <1442265973-32261-1-git-send-email-afd@ti.com>
 <1442265973-32261-2-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GdbWtwDHkcXqP16f"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44406 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758136AbbIVPTC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 11:19:02 -0400
Content-Disposition: inline
In-Reply-To: <1442265973-32261-2-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--GdbWtwDHkcXqP16f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Sep 14, 2015 at 04:26:07PM -0500, Andrew F. Davis wrote:
> The MODULE_DEVICE_TABLE macro automatically adds all needed
> i2c MODULE_ALIASes so remove the extra MODULE_ALIAS.

Thanks, queued.

-- Sebastian

--GdbWtwDHkcXqP16f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAXFiAAoJENju1/PIO/qadEcP/0Gy33QVXUqDPJUPdiiCSdD9
0dIawuSfR6iX7tc9VGLU09eICcryTiM5k+nvc4X0PGMW4WW8CuSF3rLUIMohk56T
vm2Tx91a39oJTKYjpNXtEPlj6jmLy8GXkvFS8Dq3SdYaZKnOrxBUZHzZ4bnLvEXu
JGSZkwAaK1fC3wCbwIOaMx9HqIUQtxkGyeQ+n3IqdiZygSneXrp4qmqZiIdLzbWP
X0adkrNftGSTQqe+M4C3afFTh3KG+Ah1tS1+paicBPz9iIdIBIiqEejNErOmsGAL
eZQvMN62IC40T+llP+B9vTmI3SRFt6gdNcvyZgZz6rYwAJmnmkXIYZWChpPGUCoK
3wWcUHX6PtOhStKz3bjsQxZJNyYMCoZGfD7Dvxr+3UZ5f1pF8sH2XnnkVacOsuLT
87chEizrgLN+u0qD+TvBg1+N4XWxpw6ZnhE7hQ77eNu2cWC9FrRb9FvQI06BcYAh
wfNxV3Wry/NwCeSNKNx13oR9Tn8k+eWBCFpRe1yQAXrc3ZA/d3wh0rZscoXs2zWO
hZspqsHT1yIRfeKM+oA9P526RXoh+IGxObYuPJmiN8jE5DntmGVz6ispLhiKnSak
hr8mU7CeSD381v1AA2AwrxI5CPOjEgttKakQvGk5n4BdqeKk9lCWOz+4Gm4cHwhc
0Zo8HlfMAztnCdeU36/R
=Xq5D
-----END PGP SIGNATURE-----

--GdbWtwDHkcXqP16f--
