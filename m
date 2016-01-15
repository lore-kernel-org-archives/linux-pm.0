From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4] power: bq27xxx_battery: Fix bq27541 AveragePower
 register address
Date: Fri, 15 Jan 2016 03:13:53 +0100
Message-ID: <20160115021353.GA10973@earth>
References: <1452348639-3072-1-git-send-email-liu.xiang6@zte.com.cn>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43814 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490AbcAOCN6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 Jan 2016 21:13:58 -0500
Content-Disposition: inline
In-Reply-To: <1452348639-3072-1-git-send-email-liu.xiang6@zte.com.cn>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liu Xiang <liu.xiang6@zte.com.cn>
Cc: linux-pm@vger.kernel.org, pali.rohar@gmail.com, dbaryshkov@gmail.com, dwmw2@infradead.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, Jan 09, 2016 at 10:10:39PM +0800, Liu Xiang wrote:
> Currently in bq27541 driver, the average power register address is
> incorrectly set to 0x76, which would result in an error:
> bq27xxx-battery 2-0055: error reading average power register  10: -11
> According to the bq27541 datasheet, fix this problem by setting
> the average power register address to 0x24.

Thanks, queued and already pulled by Torvalds.

-- Sebastian

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWmFXeAAoJENju1/PIO/qa1vQQAJLwdNUeAxgS1WIX5Qdt7bz+
q2yqFCI1OZ28IVLxYMCe/lMVK0wvZ6XI3/WbnfctqBDei0uAGU75GQRPo8+rOkFJ
60fMZoPFoFd0XY1VU1XiV2twFX1nS+ydLt2oBR392MlMQ2Z16HEnZXn/nCKZI5wo
VQFz2T19YcHYWTYu55ZsSJ8VYQI1obeKtPFMo8LDqYNFYJISTX384o+ygZt8IWlL
zeo5Q/ASyURMU+qF0RXpxFtLXW3iQZZn9P9BwsveouwmghWg9Ei3LrHlhy2dfV7N
t5/9qnNusrx+kQCF0tJLwwFJrZSzytJ7Qjmmm4myDccsiatlz33bbv+8Wt5m1onl
4fdBlOnBGLa1S5ITHlRjfBo9W/CFixitp0Q4g/sEMljeF2wdxnsupQQ32bUckMlO
YcR2xWpSR0U8GcNIo6OAp/sDhH+MHXG5qD+XB4HS7kWIMIpL/q3ZYdlUVOnu8MsV
H0U8Fpp0L9XLJKXTMEHyH/H7B5DxFVZlbj5b6kuAmjzn1mfuo5SsjwMs7Fj6SiFu
tsBHu9xlI1UqleI7tW8cKJrzQFqd1xSLAIcc+UeXIoohupsVxsxKvf5P4kO7DPyN
ZoWF2ZV3aa0w4LcDoEZU1fBCEuntsAf/R/1fqwCQKz7nrb6ERnX7NCWzcXejQLJP
7AgKB7l3tyPfAHrEcBCC
=9Xv4
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
