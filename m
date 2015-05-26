From: Sebastian Reichel <sre@kernel.org>
Subject: Re: power_supply: Add support for TI BQ25890 charger chip
Date: Tue, 26 May 2015 22:32:15 +0200
Message-ID: <20150526203215.GA18221@earth>
References: <20150526090441.GA18601@mwanda>
 <CAD03FC+H0JQUR32eGLrVWe_OaiiMTxUmCxdBwuWnPwMRz8XSOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54668 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbbEZUck (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 May 2015 16:32:40 -0400
Content-Disposition: inline
In-Reply-To: <CAD03FC+H0JQUR32eGLrVWe_OaiiMTxUmCxdBwuWnPwMRz8XSOQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <lpalcu@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, laurentiu.palcu@intel.com, linux-pm@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 26, 2015 at 09:08:46PM +0300, Laurentiu Palcu wrote:
> On 26 May 2015 17:45, "Dan Carpenter" <dan.carpenter@oracle.com> wrote:
> > The patch 4aeae9cb0dad: "power_supply: Add support for TI BQ25890
> > charger chip" from May 19, 2015, leads to the following static
> > checker warning:
> >
> >         drivers/power/bq25890_charger.c:843 bq25890_probe()
> >         warn: impossible condition '(bq->chip_id < 0) =3D> (0-255 < 0)'
> >
> > drivers/power/bq25890_charger.c
> >    841
> >    842          bq->chip_id =3D bq25890_field_read(bq, F_PN);
> >    843          if (bq->chip_id < 0) {
> >                     ^^^^^^^^^^^^^^^
> > Never true.
> Damn it... :/ I totally missed this. Thanks for catching it. chip_id shou=
ld
> be int... Out of curiosity, what static checker did you use?
>=20
> Sebastian, do you prefer another patch revision or just a separate patch
> with the fix? Either way, it'll probably be early next week since I'm
> travelling this one.

Please send a separate patch.

-- Sebastian

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVZNhMAAoJENju1/PIO/qarKoP/09McMxLEBlvwds81SOx2Xxr
5+9Z1YobchH84xiGHvfn6rPLRAbWiJWvjvajMtvkqUYxXP+Pwf6c+rFs4YC7qVCS
EKFSJLf+IHPUqZekyxjW9CcnhSW+kxxOlAPWIDIl+7bM5adJnjg+n5nq8dbnPwkE
uDbs8cgcvTH9WnlA7sYF5sVyBnkuxtYRLLWdBqYjEkv4sGq0q/0Ad3iJJ5HFnQuy
D/Y5MFgzV9X5gfhFdJ3JTMnxvZe6Vp6vd6AKWRZk4GRKXJNO5E2DKbaTDmZTuh7E
E9iLsoXPTuswyoEDot6tdC/0Z8S4uReaheuuKsRnHJITiOBRCrxfSV4AOSm/ViLm
+WrgzaltyTz9VZZwAlb0gYa7ABgNijgpTZHH4K8bL+0fGBPxlnhJW/asNvjAbkzB
dOqzOvwOZJzlvlQQ1kBEn6repXnRwv5Tcebt1q/Pr+rfnTdzOnnFsW9h7HZqAFUI
snR+F6V2pQ23iMs9OZxYG9ECL6RnIynlqzWI5F8hwfvUcUDHHCUelUIIEV99wy6W
IypYCOb72ldesYua1qf0yj2jFIhsmfEiN5oFqWjvJ1mQtjkRIquomkZOzwerQRoO
tbTQjiqNkHs+zOEjrJkEKY9l0hRKR4CXo+3nh3Oj/jta6ob1cP3AWAcbr7xHRX6t
CVpOYRlAe27VrN+uI9uM
=Y1bP
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
