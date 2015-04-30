From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: fix oops in collie_battery driver
Date: Thu, 30 Apr 2015 17:42:07 +0200
Message-ID: <20150430154207.GD6133@earth>
References: <1430154943-29264-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59695 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807AbbD3PmQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 30 Apr 2015 11:42:16 -0400
Content-Disposition: inline
In-Reply-To: <1430154943-29264-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-pm@vger.kernel.org, Andrea Adami <andrea.adami@gmail.com>


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dmitry,

On Mon, Apr 27, 2015 at 08:15:43PM +0300, Dmitry Eremin-Solenikov wrote:
> Fix an oops happening due to typo in 297d716f6260cc9421d971b124ca196b957ee
> [power_supply: Change ownership from driver to core].

Thanks, queued for 4.1-rc with proper Fixes tag:

http://git.infradead.org/battery-2.6.git/commit/ce992369cf29a8762b46338756ef5aba35774981

-- Sebastian

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVQk1PAAoJENju1/PIO/qaADUP/iYUFSWuyIx1eBGLOvRLEQ/Q
f1/arxeEuFUcKu7FiDQGQ2AAMZfPohAkXa5iXThMSwaAYCkW2uHu6N3D23hj3PUl
5cB/M6ralSqHYxM/afhkvdmgb3KsWrnHYlq/o9+VOil1Okkn3jzyJkZ6agb+JMyK
LRuSadJfTItmgyTedxz8+Z+Bl/wC/qNM+IvWy/Vc+ZFvSDGHxTDVVj0545MeM/Qv
3P+Aa9ig8e5VCmpBr5jW9whJLcCkeuyTSLaAGfhmufRYN1dnoCvVX75Df6qgDZJx
FtoenqZs+VhGzEWCvhpr/MDWDPG2Iu3d/PSvFwM2T1iuCO55sOYu18n8oApcjBPI
NhRYMdqnygEEWgn0C2o1tcjHjmpm9pzpJ1HdTL64OmH4Go4UQctZ4jNX0Vb8I+WW
oS6IB2Rqxu4dd1Tvq+QbTlQ2MrpdmEcgRWdyB02UdcpGWyAC19yZ7MECABnvRnxp
ITg3h3JewMZRqp6i3P7fOq0czCTpW+Um4jilO+mT3fO3SfVN7+l6js00q+rOdqE8
Uasos7X63b2Tlp5xPiaxm+8c1j41aB0p1jJpBNllMB5vtOUoTGJp5PlUuZ+L13wG
qiRk8ptuTjRfg7FFqUi3dbeeokwBWnT/g+epITUPh3rbHFT1PvXfFdKzlXF2MpcN
tX1/s47DzzP77LBPyi56
=SNTy
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
