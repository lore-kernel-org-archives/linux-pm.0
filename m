From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 01/23] Documentation: dt: atmel-at91: add clocks to
 system timer, rstc and shdwc
Date: Wed, 5 Aug 2015 20:11:38 +0200
Message-ID: <20150805181137.GB11315@earth>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438335599-3301-2-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38503 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036AbbHESLl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 5 Aug 2015 14:11:41 -0400
Content-Disposition: inline
In-Reply-To: <1438335599-3301-2-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 31, 2015 at 11:39:37AM +0200, Alexandre Belloni wrote:
> The system timer (at91rm9200), the reset controller and the shutdown
> controller need an input clock. This is the slow clock and they will not
> function without it.
>=20
> Also fix the shutdown controller example.

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVwlHZAAoJENju1/PIO/qaProP/1+bgPN5vWWoyLQ1CqRvTXDc
QYktd95NiivRzO5NtFn/NkPgdTNsy7wQxkxgqNjr+qiaeedvo04ThYmGtpn1qf3i
IcqxiGQUmVOqWr1GJSpyUfDCA/2I6YEXHyJqr4NNukxfntZ33AonXVVbc01H23Tu
1kfHe2HccanvjR1jpBiE51vLSS2Hj73vW3hoPEQVPjmvpttPyjPs4NVg6KQ/YSRs
43/sZPEIRzY9hIRudJIEbahc4aa+TZs6nmjVEiQ5pnH8kg/lnIZlatG4LTcIj52p
xz4UtZecoYOzwWOn6xQi7PKHzT4pQo8k8VB5TmOoPh4erDK+uVpaI24b6TaVaLUH
dwo/W81y2t9bJthMWu/Wjc1dEVvsywApxe0hKm7G8T1IFzMwzxk2mcpR75dIEkSt
bADGxWwxXrYigyqmAcrvAXm8wUF5YbOGpkXKHkd9ztO95druAf1Gsr2b5xBp2vmX
S3z/BH7keCFG97Hl1HwDsIHOQ3deSQdJChddmKWt19XX92B3ajh65kpQBUyp6qe8
TOyOqIZ6TzReGeVN1sSBklruY1X3vJBKVwrXH3ZayPEqGV3VPnD+4va5KyeSZhg5
KPOsrY5v9y3BU/NEqHAG1uHloAqroj2pKMS4s4vd+hZsmjwxiCUrgfGJtE7DtrBL
JNJMFdaXJyMf1BhiFIVQ
=WQ+E
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
