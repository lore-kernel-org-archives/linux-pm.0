From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] power: supply: sbs-message: double left shift bug in
 sbsm_select()
Date: Wed, 15 Nov 2017 08:45:44 +0100
Message-ID: <20171115074544.5mxmjb66nqkzwyqo@ninjato>
References: <20171107124322.mm3fqkrggw3zidrx@mwanda>
 <20171113105524.xdiusofmau36zdeu@earth>
 <20171113110231.ixxeszux3d7agojv@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tpipa2lijnyuggkc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:34179 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751155AbdKOHpp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Nov 2017 02:45:45 -0500
Content-Disposition: inline
In-Reply-To: <20171113110231.ixxeszux3d7agojv@ninjato>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Karl-Heinz Schneider <karl-heinz@schneider-inet.de>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org


--tpipa2lijnyuggkc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > >  	/* chan goes from 1 ... 4 */
> > > -	reg =3D 1 << BIT(SBSM_SMB_BAT_OFFSET + chan);
> > > +	reg =3D BIT(SBSM_SMB_BAT_OFFSET + chan);
> > >  	ret =3D sbsm_write_word(data->client, SBSM_CMD_BATSYSSTATE, reg);
> > >  	if (ret)
> > >  		dev_err(dev, "Failed to select channel %i\n", chan);
> >=20
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >=20
> > sbs-manager has been added to linux-next through the i2c tree due to
> > dependencies, so this one also needs to go through i2c.
>=20
> I want to send Linus my pull request early this time (like today or
> tomorrow). So, you either apply this patch then yourself afterwards on
> top of linus' tree. Or I send it to him, but then I'd need the original
> patch bounced or resent. Both fine with me.

The sbs-manager code is in linus' tree now. How would you like to
proceed?


--tpipa2lijnyuggkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloL8KQACgkQFA3kzBSg
KbYMOA//ZxY2z4CKrEmFu2PDcuGP/PkE9jErsUuWkHP/SPvbJ/cVTrV2MQZ/nPHd
VBXnn5sLx24ySH691fL6zia+SpQvUQ5tGRnqVUL5nb29L7CUBjUnR9eTIPLVxsZV
D+wszAZUIWjqNnZuMEeIQSVl0MvB+gu6Gm4W0Mtt2HMrjUF35894G0GY87SPqzeg
IOvD70WhZjPmHNuTfOJoo71U6OYW0pP02qqZj+W5Df5OHK+gvnS7y6NDbnvAg+mk
ONGeh/70IKsILvXMKk4ndlftKro4tOOtNFis5rh9XMJCURYmwPzyxhg6kFNsm159
TDbLeDnTKDLc4NJmL3AQCME5GK1bLvErDWqvxL/kWo5kXQZLQo5amsXDUDOpidpn
Vve6NgUqLAGZ5O4A+Cqks5HGa7HO7nOtC3n0hQiA9ZfwukSzNAG7r7TUN02m6r9s
iBFZuF8uUhTdKmnRZUxaOC4U3+FMYYnSgIPRBK424XqS3tqGMuEPQjVcOysQJpEH
J/SQSgckzaij2W8FIDyq2VrNO5WwGtvR2UElN9P7z0FPI5UgqBbe1Ki3n0rQ/Nce
K238+56RSDHQq7xH3lCxXalwvJI9g0p/Vk9zRmzJ6x/LCoEhRJNWAlaNatlFnkst
cJNEl0NG0kSEyuQpPfPD9Pva4mgWya31OJv+KyeXdgoNKYFTQGc=
=zzb0
-----END PGP SIGNATURE-----

--tpipa2lijnyuggkc--
