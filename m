From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: sbs-message: double left shift bug in
 sbsm_select()
Date: Wed, 15 Nov 2017 11:05:16 +0100
Message-ID: <20171115100516.andgvd6gvdcrv46y@earth>
References: <20171107124322.mm3fqkrggw3zidrx@mwanda>
 <20171113105524.xdiusofmau36zdeu@earth>
 <20171113110231.ixxeszux3d7agojv@ninjato>
 <20171115074544.5mxmjb66nqkzwyqo@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="be6ipm5etwn2o756"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752323AbdKOKFU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Nov 2017 05:05:20 -0500
Content-Disposition: inline
In-Reply-To: <20171115074544.5mxmjb66nqkzwyqo@ninjato>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Karl-Heinz Schneider <karl-heinz@schneider-inet.de>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org


--be6ipm5etwn2o756
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 15, 2017 at 08:45:44AM +0100, Wolfram Sang wrote:
> > > >  	/* chan goes from 1 ... 4 */
> > > > -	reg =3D 1 << BIT(SBSM_SMB_BAT_OFFSET + chan);
> > > > +	reg =3D BIT(SBSM_SMB_BAT_OFFSET + chan);
> > > >  	ret =3D sbsm_write_word(data->client, SBSM_CMD_BATSYSSTATE, reg);
> > > >  	if (ret)
> > > >  		dev_err(dev, "Failed to select channel %i\n", chan);
> > >=20
> > > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > >=20
> > > sbs-manager has been added to linux-next through the i2c tree due to
> > > dependencies, so this one also needs to go through i2c.
> >=20
> > I want to send Linus my pull request early this time (like today or
> > tomorrow). So, you either apply this patch then yourself afterwards on
> > top of linus' tree. Or I send it to him, but then I'd need the original
> > patch bounced or resent. Both fine with me.
>=20
> The sbs-manager code is in linus' tree now. How would you like to
> proceed?

I plan to send my pull request today and will take it during the -rc phase
through the power-supply tree. Thanks,

-- Sebastian

--be6ipm5etwn2o756
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloMEVYACgkQ2O7X88g7
+prdVA/5AUxAhdzkXvIsSD27XYpyVoiCOeTJi4Li9TmpWwtVUFZ56vtGU+Uk8gQv
377t9YdNA/CAHuZBA31+yloQvh+HV9wWY5mVjtizyS28O/iv0I3PCjEcEaNMDTYL
crPeeYK41CRNj5vN9ijfJC6eekZ5xS6oNWkkAoDOit8B9dBTGW9A71VYmNjTKnq0
WjLZpy8qqAC1g/7Mk/JPts4bfokf5ZrnqK/3T0XYvzasACVBNocT8GvKwQolYt6E
Vo6GClshhjaTjphNoxwjrn+nv01JDWXNQy0X5771ODXRomLMxuQQBgwXhEWsTb1s
fn1i8qyFDRxECoyV7Axy9io7CILpycyAzVMJkyIRVbaT1sNqMbMjMtskTDB8QXoc
RnovIBFG+VxJ47ng1QrkRF/lab+PMC0+PHMFhHnErPH1nDAJxGWmu23464o/9vvy
QlYnZ98JqrkyVI5W5lSYi/LhxofvedtGCkalABfNbN6JETHmk0kDpR5KUN/wNGBr
kugzZKwhBrDrsVjk5uMuVxG0FD1XbvFrAN9PkAcBTKeywG5egKCFlSIWbmB5ligl
C1PrRzqw/E8KeHkkptINwXttt25+WBy/e72InVb8eF5QrAvgSdW0aC/Rcf/OhApU
UHWPwHVEGCIYIaX5MlVL4YdH5waxPU7qqLoGSMHxkY/kj0EDVNU=
=hJAU
-----END PGP SIGNATURE-----

--be6ipm5etwn2o756--
