From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] power: supply: sbs-message: double left shift bug in
 sbsm_select()
Date: Mon, 13 Nov 2017 12:02:32 +0100
Message-ID: <20171113110231.ixxeszux3d7agojv@ninjato>
References: <20171107124322.mm3fqkrggw3zidrx@mwanda>
 <20171113105524.xdiusofmau36zdeu@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="moehyt5otiwovy5t"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55061 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751265AbdKMLCe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Nov 2017 06:02:34 -0500
Content-Disposition: inline
In-Reply-To: <20171113105524.xdiusofmau36zdeu@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Karl-Heinz Schneider <karl-heinz@schneider-inet.de>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org


--moehyt5otiwovy5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2017 at 11:55:24AM +0100, Sebastian Reichel wrote:
> Hi,
>=20
> On Tue, Nov 07, 2017 at 03:43:22PM +0300, Dan Carpenter wrote:
> > The original code does this: "1 << (1 << 11)" which is undefined in C.
> >=20
> > Fixes: dbc4deda03fe ("power: Adds support for Smart Battery System Mana=
ger")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > From static analysis.  Not tested.
> >=20
> > diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/=
sbs-manager.c
> > index ccb4217b9638..cb6e8f66c7a2 100644
> > --- a/drivers/power/supply/sbs-manager.c
> > +++ b/drivers/power/supply/sbs-manager.c
> > @@ -183,7 +183,7 @@ static int sbsm_select(struct i2c_mux_core *muxc, u=
32 chan)
> >  		return ret;
> > =20
> >  	/* chan goes from 1 ... 4 */
> > -	reg =3D 1 << BIT(SBSM_SMB_BAT_OFFSET + chan);
> > +	reg =3D BIT(SBSM_SMB_BAT_OFFSET + chan);
> >  	ret =3D sbsm_write_word(data->client, SBSM_CMD_BATSYSSTATE, reg);
> >  	if (ret)
> >  		dev_err(dev, "Failed to select channel %i\n", chan);
>=20
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>=20
> sbs-manager has been added to linux-next through the i2c tree due to
> dependencies, so this one also needs to go through i2c.

I want to send Linus my pull request early this time (like today or
tomorrow). So, you either apply this patch then yourself afterwards on
top of linus' tree. Or I send it to him, but then I'd need the original
patch bounced or resent. Both fine with me.


--moehyt5otiwovy5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloJe8MACgkQFA3kzBSg
KbbGTxAAtUtcHgsZ/aLWIMMXom9P8KqdWYRAE+SKRtjkMGh006BtmgB3oDn2GQ6Z
hLY8xSr4Ed4tmaqaXcHP25EokMGXumvgS9Z88lRsXiq8gWpmVC+vqeRfmIUPXa45
M9ghOEUkwHofGeccgk9h7GNzh5GJdGxabUKCYSyIKsQK8EYVgUQ7LWHzmbUhvCRY
Ic717DiJOFEofgb5xP7IXy2SCwnEyEdbYsvvKHfHfQUXV//R6Nk4xnMi9VBzHAi/
xrVm3TJZ/X1jRWMBrhbJrsxYG5oVocnEwxPSvfQAlAO9+ZGP7EU60C/Inugr3lC3
ato8/uRyB7pCV1tHurPapW1R6uJfXB6CWd2tgR42thuU2dDsYdhmmc/dQkhdPsZi
MwgSyBct8AKnIVahM/MUyDEMu0szc7YUloi6VrsW/IL07ra2wnM+BHY/XGE5LMXl
cIhSaD4io87vsX+oNxW0MpzsOd7VTqg6FOpA8Js47HC+eyuDlrE2dwMF8tN1lCj7
4gtu3YB20eII+53DFTbMPsMvNj2XmKqrXBOgbYWWcdndeBTcZi6UgDTgrYmGPej8
WV9yEklXzcXg4nUni+ZtvQCLgARvJM5YP/R+mOSkM8lHUg8SdQMb13+QF3RkP7+p
ABD2wJLW7wophVNgteavjynGKsQFArplJIVVnyQcC9m0JPF7BUY=
=sOQE
-----END PGP SIGNATURE-----

--moehyt5otiwovy5t--
