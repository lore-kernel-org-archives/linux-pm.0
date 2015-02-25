From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: rt5033: Constify struct regmap_config
Date: Wed, 25 Feb 2015 21:34:43 +0100
Message-ID: <20150225203442.GD13695@earth>
References: <1424771533-7833-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41180 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbbBYUe4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 Feb 2015 15:34:56 -0500
Content-Disposition: inline
In-Reply-To: <1424771533-7833-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Feb 24, 2015 at 10:52:13AM +0100, Krzysztof Kozlowski wrote:
> The regmap_config struct may be const because it is not modified by the
> driver and regmap_init() accepts pointer to const.

pulled into battery-2.6.git.

-- Sebastian

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU7jHiAAoJENju1/PIO/qaFYYP/jclxpBDZoVpo5zBt7OJBF2z
ywGI7HKnJq6r9iwlX5rmmkhg5+NjklCduu26Gk/Bv/EkspV53Rd/VC/JwPJpRyGY
CXNp1Ts1rcr+Kxt7ccCvCU/cViiPLVk+xJoL61+bYwpShk6F7t2JLaHQQ6V+o7DM
ER57fGKq47roI1MwUcFcrWWZdRfC4BHp8Q4PaEJPBrcxfoebkwXKDgUoo3SqMjQU
SkPt0s/oBMa+PkT09rJfo+Ibnz2bjMf/QHBbH2fGcfKE8J3WVciJtskZd+BvgtwQ
y6vOmuT4y+aDMoFWPviXcHL8UhKhL7gYVTGG+eAltlTsnSoY3awunFi0YzVPmQtq
58bYojsXveSkc7TPg8oNnm3/UURo7pYSCCqtkRNw9z44hUDtH0mcIwfRG6YgHpro
8N59bHUE5Nr0KEtOOr8sELs71vLhfO9afyfFDkH3l+m7IDeQrQm3w6pP9DdgRjry
Mb0GSJuHAMY/hyiRjZw32PXvkrJfaGn+9cr7Tew+c//rmb/ht+MP9I3yFNvYRTKB
KdwwLlf3N9BaYKUfNJnN5D2xJgmPI3H4SHFWdzqwlg9FFa5k3O9o0QaL8NBkf3oY
R9x6GmeV4Ka23Ns1LlvltjIz0GxyKnoJ3ApeZhVXTzIIQqOHSsv9Bs7TvdU/7rqM
8y/oCZiDRsomcxhPJ3jo
=Wy61
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
