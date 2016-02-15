From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 01/22] power: reset: Fix dependencies for !HAS_IOMEM archs
Date: Mon, 15 Feb 2016 06:57:30 +0100
Message-ID: <20160215055730.GE28626@earth>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
 <1453760661-1444-2-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44278 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800AbcBOF5f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Feb 2016 00:57:35 -0500
Content-Disposition: inline
In-Reply-To: <1453760661-1444-2-git-send-email-richard@nod.at>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Moritz Fischer <moritz.fischer@ettus.com>, Florian Fainelli <f.fainelli@gmail.com>, Jun Nie <jun.nie@linaro.org>, linux-pm@vger.kernel.org


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Jan 25, 2016 at 11:24:00PM +0100, Richard Weinberger wrote:
> Not every arch has io memory.
> So, unbreak the build by fixing the dependencies.

Thanks, queued.

-- Sebastian

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWwWjHAAoJENju1/PIO/qaEP8QAIEMqJX+gWC7az87uPN0XgzT
k4ua10B568quYnUmHBcTsdOUwdjjc7MzIxGKTZkVpLf7iupTEvjM9HMNt6qgXnKX
GzGle2zNkh1aRCbuH1USTAPfa+3kvGRSgpM/Ax55BbT8kVsKhC+2scAeIVZD+0qX
FOCebfCCJwDQLbiwrW2sKE8YIPZ3UR9kbXm+dbVxeTbOsl87k3INtRu4huPz8QpP
Gi02aCE/X3NZabjn2j9tK23EvsJk2XNONq9HU8uOfb4IJM6mhdZ3SE9XTDwsxBSk
uZW8IPjghPmDkoU7wUKUDcVWvL4QSJM8oL5HHlJg9PVuSSWahJ1A3jWbKvifbCK1
XSLmumjxfagrTeAV5FYY3jaSz7Pu672+h9y/1ucw0v/vLJLakQDKlDwLM1Jbn+k4
qWEZ/auRk6YQ+nkDLbM8b9NszsMpbiCD7ucHT2xzcEpvI+MciHeqsdlX138MIcAQ
UMVVQ+TMd5xMmfweDUFvhmNM/sH1ATE0lsZFaP+Kt8ivRSNNNzyLyY23lbE/htTi
txn6znkoSIPaFwyHbkJOgmhir7ZbpcqBcyV8C9pLt0ksg/SAvMdrlaBYrjsaJbj0
zvI9Fr59ZMBRBw/erXHSk+sBIP64VYxIlYb1S3tOKuGqbO43PpZppnqWFjkDXqBY
QU+WGISeWtgjucNVCZFU
=sBrp
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
