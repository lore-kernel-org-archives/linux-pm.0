From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V7 09/12] thermal: tegra: add thermtrip function
Date: Tue, 15 Mar 2016 12:49:30 -0700
Message-ID: <20160315194929.GB26619@localhost.localdomain>
References: <1457665872-30046-1-git-send-email-wni@nvidia.com>
 <20160314191637.GC1872@localhost.localdomain>
 <56E7D1EC.5090907@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56E7D1EC.5090907-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 15, 2016 at 05:12:12PM +0800, Wei Ni wrote:
>=20
>=20
> On 2016=E5=B9=B403=E6=9C=8815=E6=97=A5 03:16, Eduardo Valentin wrote:
> > * PGP Signed by an unknown key
> >=20
> > On Fri, Mar 11, 2016 at 11:11:12AM +0800, Wei Ni wrote:
> >> Add support for hardware critical thermal limits to the
> >> SOC_THERM driver. It use the Linux thermal framework to
> >> create critical trip temp, and set it to SOC_THERM hardware.
> >> If these limits are breached, the chip will reset, and if
> >> appropriately configured, will turn off the PMIC.
> >>
> >> This support is critical for safe usage of the chip.
> >>
> >> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >> ---
> >>  drivers/thermal/tegra/soctherm.c          | 166 +++++++++++++++++++++=
++++++++-
> >>  drivers/thermal/tegra/soctherm.h          |   7 ++
> >>  drivers/thermal/tegra/tegra124-soctherm.c |  24 +++++
> >>  drivers/thermal/tegra/tegra210-soctherm.c |  24 +++++
> >>  4 files changed, 216 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/=
soctherm.c
> >> index 02ac6d2e5a20..dbaab160baba 100644
> >> --- a/drivers/thermal/tegra/soctherm.c
> >> +++ b/drivers/thermal/tegra/soctherm.c
> >> @@ -73,9 +73,14 @@
> >>  #define REG_SET_MASK(r, m, v)	(((r) & ~(m)) | \
> >>  				 (((v) & (m >> (ffs(m) - 1))) << (ffs(m) - 1)))
> >> =20
> >> +static const int min_low_temp =3D -127000;
> >> +static const int max_high_temp =3D 127000;
> >> +
> >>  struct tegra_thermctl_zone {
> >>  	void __iomem *reg;
> >> -	u32 mask;
> >> +	struct device *dev;
> >> +	struct thermal_zone_device *tz;
> >=20
> >=20
> > Why not using tz->dev for the *dev above?
>=20
> The tz is thermal_zone_device, this structure doesn't have *dev.
> It only have the member "struct device device;", but this device is creat=
ed for
> the thermal class, not this tegra_soctherm device.
>=20
> >=20
> >> +	const struct tegra_tsensor_group *sg;
> >>  };
> >> =20
> >>  struct tegra_soctherm {
> >> @@ -145,22 +150,158 @@ static int tegra_thermctl_get_temp(void *data, =
int *out_temp)
> >>  	u32 val;
> >> =20
> >>  	val =3D readl(zone->reg);
> >> -	val =3D REG_GET_MASK(val, zone->mask);
> >> +	val =3D REG_GET_MASK(val, zone->sg->sensor_temp_mask);
> >>  	*out_temp =3D translate_temp(val);
> >> =20
> >>  	return 0;
> >>  }
> >> =20
> >> +static int
> >> +thermtrip_program(struct device *dev, const struct tegra_tsensor_grou=
p *sg,
> >> +		  int trip_temp);
> >> +
> >> +static int tegra_thermctl_set_trip_temp(void *data, int trip, int tem=
p)
> >> +{
> >> +	struct tegra_thermctl_zone *zone =3D data;
> >> +	struct thermal_zone_device *tz =3D zone->tz;
> >> +	const struct tegra_tsensor_group *sg =3D zone->sg;
> >> +	struct device *dev =3D zone->dev;
> >> +	enum thermal_trip_type type;
> >> +	int ret;
> >> +
> >> +	if (!tz)
> >> +		return -EINVAL;
> >=20
> >=20
> > Is the above check needed? If you saw a case in which your function is
> > called without tz, would it be the case we have a but in the probe (or
> > even worse, in thermal-core)?
>=20
> This tz isn't from thermal-core, it's from the "void *data".
> This *data is the private structure "struct tegra_thermctl_zone *zone =3D=
 data;".
> It is registered in devm_thermal_zone_of_sensor_register(*dev, sensor_id,=
 *data,
> *ops). And when it register successful, I will set zone->tz =3D z, in her=
e, the
> zone is the private data.
> Let's consider a special case, once the thermal_zone_of_sensor_register
> successful and didn't run to "zone->tz =3D z" yet, then the thermal_core =
implement
> .set_trip(), then it may cause problems in here, although it's difficult =
to hit
> this case. So I think we need to do this check.


Can you be more specific? I don't recall a case that core would call any
driver callbacks before setting up the data structures properly.

> >=20

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW6GdGAAoJEMLUO4d9pOJW6nYH/1MSu2i/XfgzdZ9YBscb/sGo
vPFmIt6Z8Q5VBGJ/OMOzswE2bVJCaD9lqQUcIS83IoQNOEmvUygvKCkkBkdZ+wmc
ddg4RblDHjsMjfaB3v2JL9pbyb9KCLCMpojldtOajDA82Tw/WoJtk2LilkqL5XZ+
CfoMgvK5QNmqb4bB74zmJ+v/AmMxkahVisNm/mtLFzziAV1JVzdpIH1UPBRWrE/7
cONoc6JvjjkalPkzjfZ5BKVVptMASdCLAGUPxVJ9wKvdBV7FySDcMiHkcJDekQA9
kEqk87kjwysNxbHqQN/6Jw1VCqx4FAJfvdRuElPyBLXk+rKRxSwK/z5dlhZzoJQ=
=nsi6
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
