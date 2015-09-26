From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] ARM: dts: twl4030: Add iio properties for bci subnode
Date: Sat, 26 Sep 2015 19:29:37 +0200
Message-ID: <20150926172936.GD22315@earth>
References: <1443212447-5841-1-git-send-email-marek@goldelico.com>
 <1443212447-5841-3-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1443212447-5841-3-git-send-email-marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: neilb-l3A5Bk7waGM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marek,

On Fri, Sep 25, 2015 at 10:20:47PM +0200, Marek Belisko wrote:
> Added new iio properties which are required for twl4030-charger driver and
> allow to use twl4030-madc indirectly.
>=20
> Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
>  arch/arm/boot/dts/twl4030.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.d=
tsi
> index 36ae916..482b7aa 100644
> --- a/arch/arm/boot/dts/twl4030.dtsi
> +++ b/arch/arm/boot/dts/twl4030.dtsi
> @@ -22,6 +22,8 @@
>  	charger: bci {
>  		compatible =3D "ti,twl4030-bci";
>  		interrupts =3D <9>, <2>;
> +		io-channels =3D <&twl4030_madc 11>;
> +		io-channel-name =3D "vac";
>  		bci3v1-supply =3D <&vusb3v1>;
>  	};

Acked-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

This patch is missing correct To/Cc:

$ grep -A5 "OMAP DEVICE TREE SUPPORT" MAINTAINERS
OMAP DEVICE TREE SUPPORT
M:	Beno=EEt Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
M:	Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
L:	linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
L:	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
S:	Maintained

-- Sebastian

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWBtYAAAoJENju1/PIO/qaTBgP/juvubxn1mu0n055xYZNGn0u
Ed1wWKF4gaUn+3iPW8Coxo1aZxzUQ37iEtYt2eW66GgSfsFl2aAfqN2S8WeU9f0L
NoJS9p+5PnAWYNy1BbUygUT7c/x5z5PGEsDfhaTwZwMvGmpucFqdZ5AlcFmObMGn
GvyHsdLfQP9R9qwRLXao9cy3fhoy/cvnrKZ03y5y//xtn1/7Q0psRui5+guV3dJN
GNaChaPgFyPBuyRBsCeiBh5LZK1gdCM6XyAvzam/hBMa3DO9Gg+I94JbgGRAkfpd
BulYBsUBXAY6SoyxVvbUBP+yAPEZ3A15pzEu3suWy5oEJjDPC6OrKiNU+yQCPN+n
xjj25w5xGSrWV5yJzKqXuop43VfSQ2BOMc8nvHL7Fj3YodG0fDjySdGa2t5kzPUp
R+rDJ493Lt17qOBwZp7Ns7++hYREXg5uBU59Xm9yjhGWnLKC54euyLAxN1jAdNwd
i+6P9TMhsVVL6osNCyO32/mlcq6b4EdCVNKCFQ2t+0Ac+KJIFn+O1rz9a5iBXkPy
47DHLtYNqzCV2flpWU0oZBvIcl7wmfkegdKqqt6rnejeFKwP5nTXxc1bIWf9TXJ4
svR3MmH4bTabMm4CQEo4U1LNK67VwOvMKI1dBzNUb3oR6VSR6Yg3YP4qQtFjbY7v
c9Q9Z8mSS7SobCGTYojJ
=7GMb
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
