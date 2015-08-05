From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 08/27] power: Export I2C module alias information in
 missing drivers
Date: Wed, 5 Aug 2015 05:47:36 +0200
Message-ID: <20150805034736.GB16139@earth>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
 <1438273132-20926-9-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44804 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbbHEDrl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 4 Aug 2015 23:47:41 -0400
Content-Disposition: inline
In-Reply-To: <1438273132-20926-9-git-send-email-javier@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Jul 30, 2015 at 06:18:33PM +0200, Javier Martinez Canillas wrote:
> The I2C core always reports the MODALIAS uevent as "i2c:<client name"
> regardless if the driver was matched using the I2C id_table or the
> of_match_table. So the driver needs to export the I2C table and this
> be built into the module or udev won't have the necessary information
> to auto load the correct module when the device is added.

Thanks, queued.

-- Sebastian

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVwYdVAAoJENju1/PIO/qaL9MQAJ1glDZCFj1M5aPx2h11e1IW
ZoupAIqNL86QnijisF0xJ/WF9HGGEbNzt94/J+uyPbAL3P6Yb6mfjyT1m3JIRuZH
NNAGlFHCSUrDfAtvenEiHzod+gf7cL3u0JiyLAhQt2c61nKSGY7pST4ndAghPEkF
Ih/aEAax7akPU1324UiZAcAuSzb3qKgUcVvsorRo58nnB8kRDnOStOF9kjKer5Y9
jsHVWXcG73leBrAl3Z1uKSK7BSRcGWTsQwjEjvKpupWg412/W5gXkSPnEd093FrO
Q4OpqWW1EE2q/MWObwU5ryEd4tJy4VUtX3HeTAPWjoZBmT/4TUMfziFdXZDTyTvX
fAlAK8lCHa6KaeZKns3hMTeuRkXl54W/VfB9C6ZTCNBqlUTafnbMzIZUBzL9wsAP
xPEjlmT7gRPB8O0oJdYE2xkVlDLaT4CITdv4T0yRNAupF1aDNc4lctSSPy84ZKkk
PlE6bnAUhKNsdpXn5ZPank32N0VnmbH3+6LgXxwyy5kcTKNNWnQZO2Dnq6n1VM7R
ZcznRzUFlgoWEfXuZFUYCk1aeYgzNjFOZg2QJmTmof/a8bK2I+42p0HetV3yU+NY
SYuqSb3sP6RW2UCi06e7cbvIkHKESB5ET6QH77P1e70flUhs7TRSN4QmB+HwkhSU
5pRoxOCw5zOI+8RJiYQj
=PIS4
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
