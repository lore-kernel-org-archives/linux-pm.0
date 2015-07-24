From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: Adjust devm usage
Date: Fri, 24 Jul 2015 14:26:22 +0200
Message-ID: <20150724122622.GA22105@earth>
References: <20150724115813.GA3004@vaishali-Ideapad-Z570>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53901 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088AbbGXM01 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Jul 2015 08:26:27 -0400
Content-Disposition: inline
In-Reply-To: <20150724115813.GA3004@vaishali-Ideapad-Z570>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thanks for the cleanup patch.
I have a couple of comments inlined.

> Subject: Re: [PATCH] power_supply: Adjust devm usage

Please make this "power_supply: bq24735: ...".

On Fri, Jul 24, 2015 at 05:28:13PM +0530, Vaishali Thakkar wrote:
> Use devm_kasprintf instead of kasprintf. Also, remove various
> gotos by direct returns and drop unneeded label err_free_name.

Please also use devm_power_supply_unregister() instead
of power_supply_unregister() to further simplify the driver.

> @@ -267,8 +267,9 @@ static int bq24735_charger_probe() {}
> [...]

Your patch is missing removal of the
kfree(charger->charger_desc.name) in bq24735_charger_remove().

-- Sebastian

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVsi7qAAoJENju1/PIO/qaS8kP+wceDnvo4J/FQS8j+2CS9F2P
e/T3o7FxYbfcvBV16nuc8Lr4CWDQxOvcHw38AappjqgiDXW2FWkEGFbLK9zd+xIC
dG2XEtvKEsNrrSkT9K3SrkQzzuX2VGGLx4bd9AXS9ZxhRngE8o6sF+Kln0CnED1+
Jjlvvxo9SMxiFaFY+d5E0lj4wTDTnVtc7jOhqojf3jpejsNfnntgeqkuuFhO0fTX
24JkuDXTSLNcMc52N0ZdPLjAh/89BXE1BEMuepSYiaIftf2fUaymLmpm3MfG76Gv
4/DRas2cvlk7qRrxB5R7PjeUVL3Kc758SrKgzbfGZJPMGTCfIh9rl+rA0VVVU4DC
Orb6Mfm+FSoUP+3rvvcCc5/BQ//ealhPJhCyanuLC3CJ6zjcPB7m23iBtOp9bJs5
kyeNPhfvCmOQ1prW5eXCTcO2rdub2jraCdwKQrAxEU05JGV5EsvOYGr+sHiGja9a
D+wWvoAusH5aYwkRyn2RcK1ISpiedjzQ3yuFZAuD4fU0Y65um56dliWB7R8afizC
Tj2jdT2ZJF5pxOeLRRot2OBZJ1i48zQgbQ71+HkZLTv3QfyfsiXTK4JGqS4VrYcx
Cpm5uZ7fgCNNhdQX2I1Pyxib9sibjLgIl56rhvYLGfDttqG3VzSk1rzqqOzA87He
CXwZgDjmyZYvnClE7nTx
=3LXl
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
