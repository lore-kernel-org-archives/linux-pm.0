From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 2/4] power: add axp20x-battery driver
Date: Mon, 10 Oct 2016 15:12:05 +0200
Message-ID: <20161010131205.GK3462@lukather>
References: <20161009062714.5085-1-icenowy@aosc.xyz>
 <20161009062714.5085-2-icenowy@aosc.xyz>
 <20161010125726.GJ3462@lukather>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1089834388428737576=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161010125726.GJ3462@lukather>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Icenowy Zheng <icenowy@aosc.xyz>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, quentin@free-electrons.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Haas <haas@computerlinguist.org>, Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserser.org>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============1089834388428737576==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zPXeIxDajdrcF2en"
Content-Disposition: inline


--zPXeIxDajdrcF2en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Adding the real Quentin address

On Mon, Oct 10, 2016 at 02:57:26PM +0200, Maxime Ripard wrote:
> Hi Icenowy,
>=20
> On Sun, Oct 09, 2016 at 02:27:12PM +0800, Icenowy Zheng wrote:
> > +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> > +		ret =3D regmap_read(power->regmap, AXP20X_BATT_DISCHRG_I_H, &dh);
> > +		if (ret)
> > +			return ret;
> > +		ret =3D regmap_read(power->regmap, AXP20X_BATT_DISCHRG_I_L, &dl);
> > +		if (ret)
> > +			return ret;
> > +		/* it's a 12 bit integer, high 8-bit is stored in dh */
> > +		val->intval =3D dh << 4 | dl >> 4;
> > +		break;
> > +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > +		ret =3D regmap_read(power->regmap, AXP20X_BATT_V_H, &dh);
> > +		if (ret)
> > +			return ret;
> > +		ret =3D regmap_read(power->regmap, AXP20X_BATT_V_L, &dl);
> > +		if (ret)
> > +			return ret;
> > +		/* it's a 12 bit integer, high 8-bit is stored in dh */
> > +		val->intval =3D dh << 4 | dl >> 4;
> > +		/* The formula below is from axp22_vbat_to_mV function
> > +		 * of Allwinner 3.4 kernel.
> > +		 */
> > +		val->intval =3D val->intval * 1100 / 1000;
> > +		break;
>=20
> I really feel that this should be implemented through a IIO driver
> (like the AXP288). This is especially true for the AXP209 and its
> multiple GPIOs that can be muxed to a general purpose ADC, but it's
> also true for the AXP221 / 223 TS pin that can also be used as an ADC.
>=20
> Quentin has been working on this lately for the AXP209, feel free to
> sync with him to support the AXP22*
>=20
> Maxime
>=20
> --=20
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com



--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--zPXeIxDajdrcF2en
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX+5OlAAoJEBx+YmzsjxAgD2MP/13i23TRV+BTzc8HepK5/3D/
7z4BeUsTmrlspBN1AfvQk2ZyzC/NFK+vdRta0nR/eV2Gt9lE4TI486qOM2/+lpl/
wO2ZM1EmkFJKvnT8JFRh+4PDTaQoLEXcGQs4+f3gYg+EC8MWXG4N/EbK+XQCvJfe
9agwK2QSHgMtwMoc+QM0DXqI6Kn75Lunb2jVbEDR+1vQCWJytkzIEElzfIeRLmY2
FYXlshGr0gDBM+V0omtujCkbuKNOVlfR1isHeXfRJC4c9rPz+zkK+gI55bhqJFib
MTVphTxsdLbFT2j8gfNRVKgckbHLQhqvy7divQ3+Lj6gqJ9PkgqffX+g06Hf1EJT
AYBvAGkhkCzxu2NRfjU7rWo975OTgM+vxY+DjWNif6rqsaLcdSJwV34GdJM7XdVD
PDBqsBJThfWhUgtl9BlxETWvJDgjxKOByoHjfD20PXUZJcuQedYvyw+yFBYAhDGe
x3D8OUhckSg4w6TO3z4Misx4xiTA7yPh9ehIh5lPp15AAJef5/FghunMTctjY8iV
eHhSLdIJKIv5CtWBYEg99notbBBTXvA6eSc1sbDtZyEhp8wrKHtzud3bOcK5dHZ5
vI88bv74dPYQmdJASivPkdfEaHdlXKIDUPBP2iQZV8gv9Ug/NgeYxmZnJC7ElKCU
Gx+KRo31MkhZI5hd0nlo
=6aha
-----END PGP SIGNATURE-----

--zPXeIxDajdrcF2en--


--===============1089834388428737576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1089834388428737576==--
