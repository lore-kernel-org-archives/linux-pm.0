From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 0/2] power: supply: add sbs-charger driver
Date: Sat, 17 Dec 2016 17:33:09 +0100
Message-ID: <20161217163309.2muxvxdnpuuvs5sj@earth>
References: <1479990823-25841-1-git-send-email-nicolas.saenz@prodys.net>
 <dd0728de-822a-0aee-0aea-8256843b39d0@prodys.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="weo2kcxiursxyjw5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dd0728de-822a-0aee-0aea-8256843b39d0@prodys.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
Cc: mark.rutland@arm.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--weo2kcxiursxyjw5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 13, 2016 at 11:41:01AM +0100, Nicolas Saenz Julienne wrote:
> On 24/11/16 13:33, Nicolas Saenz Julienne wrote:
> > Hi,
> >=20
> > This series adds support for all SBS compatible battery chargers, as de=
fined
> > here: http://sbs-forum.org/specs/sbc110.pdf.
> >=20
> > The first patch changes the sbs-battery device name in order to be able=
 to
> > create a proper supplier/supplied relation between the two of them.
> >=20
> > The second introduces the driver.
> >=20
> > Regards,
> > Nicolas
> >=20
> > changes since v2:
> > - updated driver and dt-binding with Sebatian's comments
> >=20
> > changes since v1:
> > - added dt bindings
> > - updated driver with Sebastian's comments
> > - s/Nicola/Nicolas/ in commits
> >=20
> > Nicolas Saenz Julienne (2):
> >   power: supply: add sbs-charger driver
> >   dt-bindings: power: add bindings for sbs-charger
> >=20
> >  .../bindings/power/supply/sbs_sbs-charger.txt      |  24 ++
> >  drivers/power/supply/Kconfig                       |   6 +
> >  drivers/power/supply/Makefile                      |   1 +
> >  drivers/power/supply/sbs-charger.c                 | 275 +++++++++++++=
++++++++
> >  4 files changed, 306 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/sbs_=
sbs-charger.txt
> >  create mode 100644 drivers/power/supply/sbs-charger.c
> >=20
> Hi,
> any update?

Sorry, I was busy.

-- Sebastian

--weo2kcxiursxyjw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhVaMQACgkQ2O7X88g7
+prvAQ/9GqZBszB9Q5gM+nP3h51QkI86ctQocETGPOhdJUUlubaaQevjvJyL3mUT
FU+CEHSYfmYTZImEW01mUGA3c6QyFm+KcGDX/yxvxBdfEF77ukt9QUzDD0s+NBHA
OqDIJYYQ8yyD10ilmtbEW47s/mn90Pp0xoq9uWzWM9PDe+W3ckKUs+vhZHLYmeHc
ztYjjtN88o6t1NHcRILYyQHQWC1nWl5bzFMTpweU2BoOt+YCyqeWOeC4OCAYFmbc
38RgJ3Xg6z8N48LTAZaYImY1uTRoNs1KsRL+JhrbVq4gFru+ciDUtwEuvB6qR20y
d++/83lT3cOdCvyn81Ss0uCcktXCOAMtvWfhJGYhIYMzRCe+yu75Nv0RfmysNy62
yq5PXLgSwARU46fUom4QHQz75xBaKDwsnIYZ3g/SvwsifueAGvdQqIAE6Qn69F74
QEnYl6/HuasnOvUBiTQTm7yl2JYqErDhezLAYwLVBtGBou+6Yl0vbbIVzhloJ0cK
SXkK/eoEYJonwFGME9YjQNNu34YHbjOoz+bBWosuXFzhyZkiHn5+/HCfnxJDaGGb
dPJSdMxlQ36CAMGTGfNHOUEiFYeA6WCXwruXZTuiYqC+g7jaCl7mZHBOEH46RjPz
IQiZm3O9ijJVKxax/KG7Zxbu1gMy4STjvWrk/NXZT61af17a62I=
=Rjwx
-----END PGP SIGNATURE-----

--weo2kcxiursxyjw5--
