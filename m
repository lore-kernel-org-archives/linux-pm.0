From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/2] Hi all,
Date: Fri, 17 Mar 2017 23:49:22 +0100
Message-ID: <201703172349.23056@pali>
References: <20170316160530.14956-1-afd@ti.com> <22cd07ef-78a1-75b6-9552-d8604ab35368@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7135220.lr11a4exXM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32808 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdCQXSm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Mar 2017 19:18:42 -0400
In-Reply-To: <22cd07ef-78a1-75b6-9552-d8604ab35368@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart7135220.lr11a4exXM
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Looks good, you can add my Acked-by.

On Thursday 16 March 2017 17:07:06 Andrew F. Davis wrote:
> Hmm, subject got messed up, should be:
>=20
> [PATCH 0/2] Remove BQ27xxx platform interface
>=20
> On 03/16/2017 11:05 AM, Andrew F. Davis wrote:
> > To finish the work started in this patch[0] we needed to reorganize
> > the 1-wire subsystem a bit, this is done here[1]. After that is
> > taken this series can remove the need for a platform driver for
> > supporting 1-wire connected BQ27xxx devices.
> >=20
> > Thanks,
> > Andrew
> >=20
> > [0] https://patchwork.kernel.org/patch/7684371/
> > [1] https://lkml.org/lkml/2017/3/16/604

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart7135220.lr11a4exXM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAljMZ/MACgkQi/DJPQPkQ1IjEgCfcC6SBCWkOhQaOSOwtXSs4+J0
yyAAoKXIYmD/I2vVLaOBgaklUEH2vkQJ
=jrzM
-----END PGP SIGNATURE-----

--nextPart7135220.lr11a4exXM--
