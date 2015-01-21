From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
Date: Thu, 22 Jan 2015 00:01:49 +0100
Message-ID: <20150121230148.GJ13715@earth.universe>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2fjX3cMESU3XgGmZ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40699 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578AbbAUXB7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 21 Jan 2015 18:01:59 -0500
Content-Disposition: inline
In-Reply-To: <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--2fjX3cMESU3XgGmZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stefan,

Sorry for the big delay.

On Thu, Nov 20, 2014 at 08:14:36PM +0000, Stefan Wahren wrote:
> This patch adds a minimal driver for the Freescale i.MX23, i.MX28
> power subsystem. It's required to trigger the probing of the underlying
> drivers like on-chip regulators. Additionally the drivers supports
> the configuration of the DC-DC clock frequency to avoid possible
> interferences.

I would expect PLL to be board specific and part of DT. Why is it
specified as parameter?

Apart from that the driver/patch looks fine to me.

-- Sebastian

--2fjX3cMESU3XgGmZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUwC/VAAoJENju1/PIO/qaHEUP/0ei1/4oIAp/vaGCDf6JGlWy
IRQdVa9kTiE2OuRWtDJiQEkCQ0z1sgK+GVtdpOX8x9sfZ7oYW4/b5/N1IGT0DIWR
CKerinJKd856v090rlYNlxXpp+ofcH0AaiXdjMws+rEgREl7ZJ2h672hofhaORdL
ZqklhCvp9COz39VjITgf2Kk8m6LH4T4TPLG3bcTr/F320b3KbVBPPA4wy0RaTWPx
Bjqrsyh6HZxT4e0wWfoSDNCsmn+TbxpBcENINRExFN47rsjWpaaUJqs4wyzWdu05
ZiKUqUJ66ARS8ptCoI4lc0qSyHg1H3xxi74kqT+DVL09kHjpMix1cMywDrjAXjBq
2uhYZ84x1gumH2UanvYp0hevmHw6gk6CJQzOSnnDrnJDU7e3cLRtbyAZiumBUM0K
41pZD+ZJVl8eA1lHlMqQ3UJ8SWcW/sTV1XPxvxVSq5DWIg/pLpKL4hPQ3fG5uQq/
9FuIUwM9AiLQRyc26RZcX0d+n+9TOPI4L1C696AH8d1POwfOH24N9RbS1dJqzCnC
rS66ICHBJrOrDfE6cwziyXlEOtk4PnKNwlaL0Pz6KP38Q8IJEzag8rJvEGFkdcAW
oEa6lnbFacG4wOOlbJti2uccmqoP1+4zXSfNfle0k3ifhQbXfen5VOiVV6nDmlRK
d5Lb7u1tLAy837woOXWS
=YmPR
-----END PGP SIGNATURE-----

--2fjX3cMESU3XgGmZ--
