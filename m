From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC 3/4] power_supply: Introduce charger control interface
Date: Mon, 9 Mar 2015 15:55:17 +0100
Message-ID: <20150309145517.GB950@earth>
References: <1425638007-9411-1-git-send-email-jenny.tc@intel.com>
 <1425638007-9411-4-git-send-email-jenny.tc@intel.com>
 <20150308015515.GB25160@earth>
 <20ADAB092842284E95860F279283C5642EEC9149@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20ADAB092842284E95860F279283C5642EEC9149@BGSMSX104.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Tc, Jenny" <jenny.tc@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, David Woodhouse <dwmw2@infradead.org>, "jonghwa3.lee@samsung.com" <jonghwa3.lee@samsung.com>, "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>, "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
List-Id: linux-pm@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 09, 2015 at 12:47:18PM +0000, Tc, Jenny wrote:
> > > +struct power_supply_charger {
> > > +	int (*get_property)(struct power_supply_charger *psyc,
> > > +			    enum psy_charger_control_property pspc,
> > > +			    union power_supply_propval *val);
> >=20
> > The charging framework can simply call the same get_property
> > as used by sysfs. This is already done by all kind of drivers.
>=20
> The idea is to separate power supply properties from power supply
> charger properties. Existing power supply properties exposes a generic
> property of a power supply. But the properties introduced above, is used
> to control charging.  But I agree, if the charger properties are moved to
> enum power_supply_property{ }, the existing set_property()/get_property()
> calls can be used

I think making them part of power_supply_property and re-using
existing functions is sensible.

> > > +	int (*set_property)(struct power_supply_charger *psyc,
> > > +			    enum psy_charger_control_property pspc,
> > > +			    const union power_supply_propval *val);
> >=20
> > I guess this is needed for values, which are supposed to be
> > writable by the kernel / charging framework, but non-writable
> > by the sysfs. I suggest to add set_property_kernel() instead
> > (and make the above properties part of enum power_supply_property)
>=20
> If properties are moved to enum power_supply_property {}, then it's possi=
ble
> to reuse the set_property() call. property_is_writeable() can be used to =
block
> user space  write access.

Right.

> > > +};
> > > +
> > >  struct power_supply {
> > >  	const char *name;
> > >  	enum power_supply_type type;
> > > @@ -200,6 +226,8 @@ struct power_supply {
> > >  	void (*external_power_changed)(struct power_supply *psy);
> > >  	void (*set_charged)(struct power_supply *psy);
> > >
> > > +	struct power_supply_charger *psy_charger;
> >=20
> > Why is this a pointer?
>=20
> This is introduced to access charger properties using power supply
> object.

The question was why you choose (1) over (2), considering that the
struct contains only two pointers.

(1) struct power_supply_charger *psy_charger;
(2) struct power_supply_charger psy_charger;

> If the properties can be accessed using existing
> set_property/get_property(), then this is not really needed

Right, so don't worry about my comment :)

-- Sebastian

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU/bQyAAoJENju1/PIO/qaHZsP/iyKbFfarpA5Uf4alMQmZggQ
uVDIsDMT8GtOc9DTyOtTg+oJpp29zakSoYygYIkZgXsxQySaMXUFTTFHjCep9efN
3N62e+9vN/kYT/4ZcygTc4NdAeSbe/EadsCedXOrjLt4RfsmPcDknEYa4ZV8QoFb
gXryDOcDvh8/qiepwW95jtoRDms5PSAkr5wAKwCYB24muaUhgOCyywNj9TLFUDo0
zQqPW5MOpcLLLwrkgYhDiXoqqYOTqmRCLfSmrDmhqJ2tbED3N1EwT/5GXjOlaV2U
8+Ff3eRMiT0x5CnIcNwzb3fJhWTsBzltr/XB2sYa98Dq5ScUTBvPmfKczkfqTEPo
ZRZ+JzavfgcR1J+xXcxERPdQ5sjybwaVfQuq+HJZ3Ayk3xH1iogJ64JGdarhoNTm
rfEYjA4+7g/S3t7kMAZkxUiG5F6YMyou/3bCKEdpZs7l56ccva1b/oxPDuIge2A7
iIby6Ko8Bjyxbt4MPgQJtyz1a/ogSjA2xmcmea0/g7dB8KTbP7Up0IwvNVwXn60B
Sfwk0ra/bcDnWUA5L95+w9ih2pc8oAaiPpTEGgEOZN3VUYAefc3N76uqWKx+Etyl
eZnbIrP4AZzQv+TVb9HcxQkOP296WUQl6e1ehUv3HSMG5ueH32caHh3L1IvTnAUE
eoevJjRgryWerKS7LSgx
=8lr2
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
