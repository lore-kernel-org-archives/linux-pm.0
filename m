From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 2/2] power: supply: max17040: Add OF device ID table
Date: Wed, 15 Mar 2017 21:50:00 +0100
Message-ID: <20170315205000.oliqozqk2dzczcc3@earth>
References: <20170315034349.8494-1-javier@osg.samsung.com>
 <20170315034349.8494-2-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2r3vr77a77apxnnu"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751183AbdCOUuH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Mar 2017 16:50:07 -0400
Content-Disposition: inline
In-Reply-To: <20170315034349.8494-2-javier@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--2r3vr77a77apxnnu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 15, 2017 at 12:43:49AM -0300, Javier Martinez Canillas wrote:
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees. This is working on the assumption that a
> I2C device registered via OF will always match a legacy I2C device ID and
> that the MODALIAS reported will always be of the form i2c:<device>.
>=20
> But this could change in the future so the correct approach is to have an
> OF device ID table if the devices are registered via OF.
>=20
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks, queued.

-- Sebastian

--2r3vr77a77apxnnu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJqPgACgkQ2O7X88g7
+ppiaxAAgEdtryGMK3k97dDhSVW+26o83QUxwNQV0UBlHYDDc71guIo9KgWcbJ7/
j6ZBheAnCHOxGWgwsNcNEtzGHbrjVxT3095ulzDMvm/S9+Yehpr3JIkg8eKYrqjZ
oJgvnLf8GuUTN4Ydq0yjZMWoiigvJQndz5aEsJeXKrtoF0UFprJ+JtVzFXNO/PM7
igN1ncUzkIFrIBQz7YvZV57b5CQoOMachslmS0qAkqXYpMc2U1W7nLQqtC6/sgRy
Yn7yISIFh4dn96nuZQYB5bvNcssHHIZzaGYQMPudCTQdf5BPFiskbOiYdaVzJN2f
uFg/1Uqf3N3AwX6sxDFdnYzcoSWax2hCQWf4vvSKDbzPmL4AEA0h8pWFGzmVFShR
mjD4ZAJK7MhGKRDfv1vvwHIvBtdLXUoSQczCp9XmOX9HiW060hrLHObTg2qC8BJG
c3Brie8qmiisFF0k5jxbMUOwSfSURtJqDzWHaH6gTgUtLAw2TRTbZjpdRNZhn80t
v1V9OK9zrJYjGhQIJoejX17OB6lzCRbriX02DCLbdf1+MmuwuLSrDxKGSnNTPTBa
n5TLdc+uyz1anLCeBQ4iUem6bMYFz2f1DP+EocmurDENtwQjKb2VWX/g8PxpvfNj
qlCdgkRhCdJivNEsBAy3qjZd2S1tkWk+rne7Opi2pQE3zyafYQE=
=TFqP
-----END PGP SIGNATURE-----

--2r3vr77a77apxnnu--
