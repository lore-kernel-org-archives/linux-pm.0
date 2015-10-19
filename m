From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: bq27xxx_battery: Remove unneeded dependency in
 Kconfig
Date: Mon, 19 Oct 2015 11:39:09 +0200
Message-ID: <20151019093909.GB11028@earth>
References: <1445006960-3655-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47464 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654AbbJSJjN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 19 Oct 2015 05:39:13 -0400
Content-Disposition: inline
In-Reply-To: <1445006960-3655-1-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Oct 16, 2015 at 09:49:20AM -0500, Andrew F. Davis wrote:
> I2C is only required when using the config item BATTERY_BQ27XXX_I2C which
> already depends on the I2C subsystem, remove the unneeded dependency from
> BATTERY_BQ27XXX.

Thanks, queued.

-- Sebastian

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWJLo9AAoJENju1/PIO/qaZe8P/2HlQ4jL0lo8j7NQ2dlUSbhi
m/Ea/kWw8lnG8gNPypFVEVLK/M1MRk+tLYq9TWNtnFsAeBaK2wqubWVVpy54b3VX
iJAQ0rV9BNkubraFkSuOIbavdDo6gv+2nzix01PaqKukwyI+jpgwxkUQtrKr5fkR
0HzSNehExmX8pzLy1tDytQHx4akBIFnMfQb5uElQpIH1u1PNMCEYjL6ifprddOse
+xBpBMrQ3z6BOvSCe2OeoVCSeshBiI9pFgyKV6tZiiIjwIDfKPujyfFg12Xmse1f
2M3WiahmqIZ5XNeHNMxBhUn9vW7LXLAy2m6C+dLgr2bWPLn0VbrdwpcsQAVuzCFo
O5kQSo6cGeyS7flL0c/+SmN+MuZfLWalcbCermxAhWkIUaRqMUK5wbSImwY5urQs
YVSnEWcb24SrdeI6Nhj7RHSAbBBJfmF3f2JWk39Yp6Uc+csWnVc7cG6q30NVN+Mo
hxYFPlEapNwgKlc6sSyurs/FKhyjO78c2vxXxEIzYnrdii1hZ8oSiGsvP1BbrmMA
m/rmyUhGGkeZ1uCWaE/RL/8tJRzEZ1LEV5HJCJINs4vCSEMIGYKbicrCEeigL5eK
7Xeqw2WtblgzEI94DlGINg3niI/HxmsRB8DbbNUuRh2+hXjMpDpq55oJekWl9Vzy
uXk5iYWX0sCLO7LwSfvd
=hP3m
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
