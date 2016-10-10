From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 2/4] power: add axp20x-battery driver
Date: Mon, 10 Oct 2016 14:57:26 +0200
Message-ID: <20161010125726.GJ3462@lukather>
References: <20161009062714.5085-1-icenowy@aosc.xyz>
 <20161009062714.5085-2-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2308901754984139505=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161009062714.5085-2-icenowy@aosc.xyz>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Haas <haas@computerlinguist.org>, Russell King <linux@armlinux.org.uk>, quentin@lukather.free-electrons.com, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserser.org>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============2308901754984139505==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1BdFSKqAqVdu8k/"
Content-Disposition: inline


--k1BdFSKqAqVdu8k/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Icenowy,

On Sun, Oct 09, 2016 at 02:27:12PM +0800, Icenowy Zheng wrote:
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret =3D regmap_read(power->regmap, AXP20X_BATT_DISCHRG_I_H, &dh);
> +		if (ret)
> +			return ret;
> +		ret =3D regmap_read(power->regmap, AXP20X_BATT_DISCHRG_I_L, &dl);
> +		if (ret)
> +			return ret;
> +		/* it's a 12 bit integer, high 8-bit is stored in dh */
> +		val->intval =3D dh << 4 | dl >> 4;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D regmap_read(power->regmap, AXP20X_BATT_V_H, &dh);
> +		if (ret)
> +			return ret;
> +		ret =3D regmap_read(power->regmap, AXP20X_BATT_V_L, &dl);
> +		if (ret)
> +			return ret;
> +		/* it's a 12 bit integer, high 8-bit is stored in dh */
> +		val->intval =3D dh << 4 | dl >> 4;
> +		/* The formula below is from axp22_vbat_to_mV function
> +		 * of Allwinner 3.4 kernel.
> +		 */
> +		val->intval =3D val->intval * 1100 / 1000;
> +		break;

I really feel that this should be implemented through a IIO driver
(like the AXP288). This is especially true for the AXP209 and its
multiple GPIOs that can be muxed to a general purpose ADC, but it's
also true for the AXP221 / 223 TS pin that can also be used as an ADC.

Quentin has been working on this lately for the AXP209, feel free to
sync with him to support the AXP22*

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--k1BdFSKqAqVdu8k/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX+5A2AAoJEBx+YmzsjxAghjcP/iGGOskvxjncUTy4aoL3U+Ig
s+PbApkTZyheW7Sfbgr2H0fzbyfuybhF2ArVaExOkYnNMU4H9QQbP+jWV/DThb++
rc0NuKKKAv8tSPhad/baRkyiw+ZfmePLFX6VEsT1yxBbez/B/2W4DZq7KEeQtTxx
zierUsTSlmTfflDvF78nxKD4tDr4h101FMRP8Q2N8LHgE19t4cPbfA5uI9k24Apk
dsbJ/YrCF41PYnx+hXe1rQQLJZOnX6hjN9YcguAmWUzE3QzMbkh+cRIecKwdLyvc
TYX5i4RhFwSG5R57u/Sx0EYoyzWlW9JgSJNpqw8kG0rDbZ3jpBv4zwEIylt27zm8
jjNistQzURehwAFeyth9igIF/i+bZ9zSkm+iwp1+XQkET0AVqBLTpfeRNE0uUG6e
rAEUCadXXBCh+JgJYhAecUQ0AbbAWH/Lusr/en1SmbL/LpFUECcsbhImgsS+iDXe
uoqib84WT5CiTMjHG4eRDFlBUKvziRpD0GJ5h+S2Nn9XlpvXW/+GA5+hR0/uG+fm
0DmzCnuhu4MpPWEhcjghRfyk172BcHP2g/KO8tCLUIfQkfpi6riM2Q69nXPIWZYa
3oWHi5b9zg7i4Z9gf99klvyBLyRBeflcjQWgrUrzEeQPjfWTDTlZBFtvdYVpXkX9
qSwfM7ZsU9ikpz2Gf1Xo
=PYKL
-----END PGP SIGNATURE-----

--k1BdFSKqAqVdu8k/--


--===============2308901754984139505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2308901754984139505==--
