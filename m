Return-Path: <SRS0=xQv0=SK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74DAC10F14
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 15:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767A3217F4
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 15:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554736219;
	bh=niDhotWFCUa5j7Mkj24VjWjSB8jT15W+sGwIXL6AaPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K8EKfAVu8A92djGQDiFkq4LsTwouADj7NJmKx2jTmxjuqkPINc//cMU4FKWgyonIb
	 2u+b37xUdzMjcNywx5+bSkEJWysYCgrR0rTNhbWpRs8JjUbRpHba1WRuBTA6f36PDd
	 HAu9NWKJS8SshXI8GfHIQ5wFHfUYV3fKGij+IRr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfDHPKR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfDHPKQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Apr 2019 11:10:16 -0400
Received: from earth.universe (dyndsl-037-138-087-101.ewe-ip-backbone.de [37.138.87.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E91AA21473;
        Mon,  8 Apr 2019 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554736216;
        bh=niDhotWFCUa5j7Mkj24VjWjSB8jT15W+sGwIXL6AaPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OlV0q5cQ8I/VVhymJ0bxJMWG9YRIzUtX35QA13Q9vmyZezNSYsrN9zpaITLl5PrwM
         XH9MwDrEn8eC6aab0Yerd8LEGFEEZGOjAKUSdDzXCc+Xa5OqyZE8Hzb4oQDcGotcLj
         QvcoXfkRgiUkURdHayh+5cYALKqsT5PRL9hyXcFo=
Received: by earth.universe (Postfix, from userid 1000)
        id F24963C08D4; Mon,  8 Apr 2019 17:10:13 +0200 (CEST)
Date:   Mon, 8 Apr 2019 17:10:13 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     michael.hennerich@analog.com
Cc:     mike.looijmans@topic.nl, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        robin.getz@analog.com
Subject: Re: [PATCH v2 2/2] power: supply: ltc3651-charger: Fix device name
 (rename files)
Message-ID: <20190408151013.kcycezi7u2htztoz@earth.universe>
References: <1554722240-22183-1-git-send-email-michael.hennerich@analog.com>
 <1554722240-22183-2-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nmffp6qea3dfxbmb"
Content-Disposition: inline
In-Reply-To: <1554722240-22183-2-git-send-email-michael.hennerich@analog.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--nmffp6qea3dfxbmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Mon, Apr 08, 2019 at 01:17:20PM +0200, michael.hennerich@analog.com wrot=
e:
> From: Michael Hennerich <michael.hennerich@analog.com>
>=20
> rename only - no functional changes
>=20
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  .../bindings/power/supply/lt3651-charger.txt       |  29 +++
>  .../bindings/power/supply/ltc3651-charger.txt      |  29 ---
>  drivers/power/supply/Makefile                      |   2 +-
>  drivers/power/supply/lt3651-charger.c              | 207 +++++++++++++++=
++++++
>  drivers/power/supply/ltc3651-charger.c             | 207 ---------------=
------
>  5 files changed, 237 insertions(+), 237 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/lt3651=
-charger.txt
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/ltc365=
1-charger.txt
>  create mode 100644 drivers/power/supply/lt3651-charger.c
>  delete mode 100644 drivers/power/supply/ltc3651-charger.c

Please resend with git rename detection enabled in!

-- Sebastian

--nmffp6qea3dfxbmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlyrZE0ACgkQ2O7X88g7
+pojQA/9HUGj4uU24/8axNYJafkOIMwaIOrt+p8YbpNXr8Qu1McGtAMdKmFh1SsW
glVgGDzEGqpFzT0rbhl9hzWlxsIew2r/+xH4P0t8Gy2gcfb+nLB7W5xjoyhRyaY5
zELohZUWjY0MaARQ4eLvhGtVDfGXI3ip68r+7t/1hemn1rYdfBFf9sLEoFNGmkFF
zme6auMUmUCMHNzTuPRYdIE0HZaaFUxIo2g9o3MX8yDVMC+e37pUxlu5APemxMg6
UYpvwL9JsgRJwoqE1GQQq7vAgtFT9K/LPgMXpVmNllAy7HfuIcpNnHjw3MfGJ6bQ
xH+dkA3qtEXKOzFpXPOva7S3f+cXEyG+Tq8JYaPt4HgOHTFaZb/g96r8clIN6ZSD
ztAH3prybRc306LUAAgpsWUQNcu0uDnmg3ZI6K4UiOlPfFto+FGb3DSg1Y2u82WN
8rMUbKVxi+W0vtJpBK9cOIeuu6Ord3dO58GwbBZeFgJwXodCaBRIdsaumsA++5eN
CuExw6ZNDQa6NgXhhnI+EoaYTqIRDUuOzVb3yA0fylmDcYZGoDC5vVAIEkk43xj9
Ac3gdVuNKvSyyrC/NSgDBYWYqOShebpAxHaZpSfC9E5Gxn8m1QrOD/uYKyziU/5t
M5TfjAjLgNj02Ne95vgnDAV45V6lYozQsDkYBSGNGGJGgAK8zf4=
=CYxJ
-----END PGP SIGNATURE-----

--nmffp6qea3dfxbmb--
