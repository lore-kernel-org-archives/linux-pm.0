From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 1/6] dt-bindings: power: Introduce one property to
 present the battery internal resistance
Date: Sun, 21 Oct 2018 18:21:39 +0200
Message-ID: <20181021162139.4nr5j6vztbcpt6ak@earth.universe>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="buyipfsg5mgqpdut"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, broonie@kernel.org, ctatlor97@gmail.com, linus.walleij@linaro.org
List-Id: linux-pm@vger.kernel.org


--buyipfsg5mgqpdut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 19, 2018 at 06:53:10PM +0800, Baolin Wang wrote:
> The internal resistance of a battery is not a constant in its life cycle,
> this varies over the age of the battery or temperature and so on. But we
> just want use one constant battery internal resistance to estimate the
> battery capacity. Thus this patch introduces one property to present
> the battery factory internal resistance for battery information.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Looks good to me.

-- Sebastian

> Changes from v4:
>  - None.
>=20
> Changes from v3:
>  - Split binding into one separate patch.
>  - Add LinusW reviewed tag.
>=20
> Changes from v2:
>  - Rename the property.
>  - Improve the commit message.
>=20
> Changes from v1:
>  - New patch in v2.
> ---
>  .../devicetree/bindings/power/supply/battery.txt   |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b=
/Documentation/devicetree/bindings/power/supply/battery.txt
> index f4d3b4a..938d027 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -22,6 +22,7 @@ Optional Properties:
>   - charge-term-current-microamp: current for charge termination phase
>   - constant-charge-current-max-microamp: maximum constant input current
>   - constant-charge-voltage-max-microvolt: maximum constant input voltage
> + - factory-internal-resistance-micro-ohms: battery factory internal resi=
stance
> =20
>  Battery properties are named, where possible, for the corresponding
>  elements in enum power_supply_property, defined in
> @@ -42,6 +43,7 @@ Example:
>  		charge-term-current-microamp =3D <128000>;
>  		constant-charge-current-max-microamp =3D <900000>;
>  		constant-charge-voltage-max-microvolt =3D <4200000>;
> +		factory-internal-resistance-micro-ohms =3D <250000>;
>  	};
> =20
>  	charger: charger@11 {
> --=20
> 1.7.9.5
>=20

--buyipfsg5mgqpdut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvMp4sACgkQ2O7X88g7
+prRKQ/+I4JhijYPh+yUYarxP0GvbDOiCWU15l1dKSkBHcAOxBIEqx2LavMKzp6I
X8nEeSovUB1l/8GJrClT5PTy218OCn5LfwQPl0Aphyi0DXIiWLlxk2COVKdXRgE6
hZAg6mUoU4eQfSHRa2Tfbuw1y3XjScjCSBNbau5yQpc3uH2sQf2nAJIZs/zgrssa
UUz5Ode2oSB93GNzWRrHfSO5LyaT8CiYYdUCzGjmLMk3AMxUTT7aMb2MM1Urn6Oe
4YCCyg+BQL2svFGTPYG9mHOR+TNP9K3eSkex2MTYfhqAdFv/HI3/hDsixkG/lR1c
1hFsOoWP2q0ZdDSIo4FC/H73PSDkuwFhJVj4GrW+e2b+GfqMvu8yviVuLdtR2K0V
am5cgWjdDPNq3xfuoNap5xN8eLcfF4QvxzgxbTeS6mE7uVr1Uq7JZnVgYgt+XP+K
7L4bs+pnVhBJxLPetqOVjgczNI7Fx+ADIHheARfp6a/mZEZRmDBZr80JoTidOwjA
T9tDYv+bzOF9Y9kBOe/az68C6Z84/m2ADfw4H8E0EDb+V6yNrMtkZ3a9blIiN5xu
EqsXqutVxf7qSd4Ao2d5ICGIDek4RqG1ZXRoajOggUUacgydCP5YEEd0BBRfEZnY
qq6XF0s4JvdC2Iy0Q1kziaMSdMg7KcdNsPperzfU3UNOLAd3xFg=
=DLLA
-----END PGP SIGNATURE-----

--buyipfsg5mgqpdut--
