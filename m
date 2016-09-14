From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH V5 2/6] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Wed, 14 Sep 2016 10:41:43 +0100
Message-ID: <87lgyurf6w.fsf@eliezer.anholt.net>
References: <1473759262-27031-1-git-send-email-kernel@martin.sperl.org> <1473759262-27031-3-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:47597 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761326AbcINKMM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Sep 2016 06:12:12 -0400
In-Reply-To: <1473759262-27031-3-git-send-email-kernel@martin.sperl.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Russell King <linux@arm.linux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Stefan Wahren <stefan.wahren@i2se.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Martin Sperl <kernel@martin.sperl.org>

--=-=-=
Content-Type: text/plain

kernel@martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Add basic thermal driver for bcm2835 SOC.
>
> This driver currently relies on the firmware setting up the
> tsense HW block and does not set it up itself.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>
> ChangeLog:
>  V1 -> V2: added specific settings depending on compatiblity
> 	   added trip point based on register
> 	   setting up ctrl-register if HW is not enabled by firmware
> 	     as per recommendation of Eric (untested)
> 	   check that clock frequency is in range
> 	     (1.9 - 5MHz - as per comment in clk-bcm2835.c)
>  V2 -> V4: moved back to thermal (not using bcm sub-directory)
>        	   set polling interval to 1second (was 0ms, so interrupt driven)

This is still:

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX2RtXAAoJELXWKTbR/J7oGIIQAIC/9KDMstZePNKgLp/+6bPH
1COYYn166qRFbQPgBsx0alUDCmsAsnqq5lum30wvXMBAICf+EZsq1j34Jxr4vXDU
zyz94jViOZ0T4A1Tv1odzQiy6Ptjw33Ippz+Rl8qvfP6+jgpL3nUMqxWqKCHinOT
+mkHzPYif3rHOhLDU9ksUOtyUK5nvtQGFDM0N0cI5yyBkoSkZUt9bTH48GWbyoJ7
mRSHwbY5RhzY/x9GKoGUBRGeDYg/cJXTu/r3t9IKCKdcnZYaF/tJJtomGWKF6Q93
7UdqormQI9zUGxRngrqblvTR9Q5RlQL0ihW/zQeGchH+r7UJQ7j2638i1JXSnM2V
TpgB/8oSGotnwe4gncBH/XGam8D828wZCu0iNdkok24Dy4wPdOuAgSrlCsAD5sdu
8a6JxA+eXnhd/W3wHngHDikGhh2lootTOznNLEIAp1zKewI4YUjYd5o0t7r6Keae
iK1HgLOGfK0sTe3HKrWTCLUAln5uZ4iW3kObDJOsQ+U8ImniMLOm1obypPAK8LRt
BEuLjqxdFgRLCCnC8mTUZ+mjkOSywEzIXRP7LzL24+4p1ngZ0C5gvd4YKLDyd6K9
bLcFk5v7W9C+2X9mRH1x3GZznDdJMAW4xi/xPUILGUcykWUSb1ZNykosW0ed57d9
3k9L5kJoK3PGHQJO04JL
=GV7s
-----END PGP SIGNATURE-----
--=-=-=--
