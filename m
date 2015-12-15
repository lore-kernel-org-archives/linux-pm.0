From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH linux-next 1/2] power: Add brcm,bcm6358-power-controller
 device tree binding
Date: Wed, 16 Dec 2015 00:23:00 +0100
Message-ID: <20151215232300.GB7421@earth>
References: <5668AB4F.7030100@simon.arlott.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5668AB4F.7030100-qdVf85lJwsCyrPCCpiK2c/XRex20P6io@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 09, 2015 at 10:29:35PM +0000, Simon Arlott wrote:
> The BCM6358 contains power domains controlled with a register. Power
> domains are indexed by bits in the register. Power domain bits can be
> interleaved with other status bits and clocks in the same register.
>=20
> Newer SoCs with dedicated power domain registers are active low.

That's neither a power supply driver (like a battery charger or a
fuel gauge), nor a reboot/poweroff driver, so does not really fit
into my tree. I will add generic PM maintainers to the discussion.

-- Sebastian

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWcKDUAAoJENju1/PIO/qanW0P+gPU6Ii+5doqe4tOqU+RWSUr
PDpj0smF8huH4pmzqSwpbJjci4G0xqGRTSh/XARVq5fJ3IfiDmUQhbFHHR7cb/15
DDxtDN8FhAPfZB/Ylx4tIm5W4pZvAhROJHM25LCiroV5yhPIx+hRja4Uc4LPNImG
tasXry7MG7IthMJAgB+Qc+f3VcMIa1DlUks/nwCCOgY0IO+Sir9V7YFDREfYxdtO
N+owMT2SR3noR0A4IxlaDHd+1cT8giWMd5UOVjFph/j31M7Uxl/haJEvm8ZPwPAJ
ShFhVo5FCpObUlP5bmffywditTLwatf+GFfFY+Z1X916jTK9V9G73PnLlsuIqBTe
2fXiC8q5f7YmGDWOjijLFGxb1vIwcj3qM7B1UkYWqCuUW49dzXbA4FU6DLp5z3vZ
s091BxCi3oXWB0bvFiqc1xooD5beQUALVAFuaGkRzR3tjTttzZP/KA8GuHgBoDrw
S9DQ8Denq9m+o8+0F4cX7noY77m52wHfgGai8vkP0NPq2VlE8lrzpIcZivY37CpM
yswwip0nJ6HnFbqFql4SD/1OrOH04rWe2NtWpL0piDFVZ1VlbeF4ULt8DY1j/Foa
ucdOBI9+93jczW8XAnrER6Vkte6+TyffUUONAUZMn5fEg/Ne85ijTH1BQZfYilmQ
4LR3wrR6ccdi+dGOWuA6
=zyMi
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
