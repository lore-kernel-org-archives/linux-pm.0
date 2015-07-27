From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power/reset: zx: Remove unnecessary include file
Date: Mon, 27 Jul 2015 15:34:32 +0200
Message-ID: <20150727133432.GA12993@earth>
References: <1437980346-1966-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43335 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931AbbG0Nej (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Jul 2015 09:34:39 -0400
Content-Disposition: inline
In-Reply-To: <1437980346-1966-1-git-send-email-jun.nie@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jun Nie <jun.nie@linaro.org>
Cc: sfr@canb.auug.org.au, linux-pm@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jun,

On Mon, Jul 27, 2015 at 02:59:06PM +0800, Jun Nie wrote:
> Including ARM related header file cause build failure
> in i386 build because COMILE_TEST also involve building
> zx driver. Remove the unnecessary include file.

Thanks for taking care of this, queued.

-- Sebastian

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVtjNlAAoJENju1/PIO/qazMwQAJ4QnWDrR7PNpXwnC8gCmkZd
VCgbiiRZF7GEZRm8ww/Xr/Y7yaFzalSQRNTRrdeV2rYdyZ+f/xjrqBlzml+S78pq
2zy7lWV8vpqW0SOL33iOzl4WqItTiQky7DGLA1Wt+ns+aOJ/YqiRz18ws+nw/0Ug
rTvLR5J6x3VBzuFme8ubE7Ap/8DV1hQCWo+Fm4XUP/ZWsrtbBqQl3pppP6KvC3nQ
aGYtS5lVOz+v9Bw3hCKMB9jcr6aOM/YYmBUCMohQ+jyBFt/1NMK8w4qjBsERfNJD
w3Co6jDMA/AA59UQl1Ub/K3Yx66hH+LT9Ew0DMANsjrJwSC9xd/wgfokAutBSZJf
4ZaIC7ud0AW9jvVdcFfO5AuczrykjhViXGpUeMhJFVZTRdMum80MoIkV6JVUNGKT
1Jm3nQ4+3TE4SP3b00/eCem3wnk5Oc3+WNO2nIRtjiOpuoeOq9VxBJiU+a3JnE0Z
4jad6PPCLBONyID5bPw2DWXJ8Exjc0nALeScHNzKeNFxTTeuXJmHxVEgAIqhJtcW
K/aL8yS20VE5Sj5VI0ClXuhELZhSl1ADPToF6v/bRKJe6EZShxpykEHWvY4NGZYd
NLnUi/S7UHEiY7IHJPozSlfyoEaLth5cEIh5WP1hpD8/IL2+PZnYP7WtCGonLzxb
J2CFeAQOI5w5VGjzpq03
=GQ51
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
