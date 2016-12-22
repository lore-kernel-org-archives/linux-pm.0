From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 0/2] power: supply: add sbs-charger driver
Date: Thu, 22 Dec 2016 19:04:02 +0100
Message-ID: <20161222180402.yn6jnjpk4tgqba7l@earth>
References: <1482247874-28713-1-git-send-email-nicolas.saenz@prodys.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ro6e4rasvs2ecpuw"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1482247874-28713-1-git-send-email-nicolas.saenz-gbiq2sxWoaasTnJN9+BGXg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Saenz Julienne <nicolas.saenz-gbiq2sxWoaasTnJN9+BGXg@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--ro6e4rasvs2ecpuw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 20, 2016 at 04:31:12PM +0100, Nicolas Saenz Julienne wrote:
> This series adds support for all SBS compatible battery chargers, as defi=
ned
> here: http://sbs-forum.org/specs/sbc110.pdf.
>
> [...]
>
> Nicolas Saenz Julienne (2):
>   power: supply: add sbs-charger driver
>   dt-bindings: power: add bindings for sbs-charger
>=20
>  .../bindings/power/supply/sbs_sbs-charger.txt      |  23 ++
>  drivers/power/supply/Kconfig                       |   6 +
>  drivers/power/supply/Makefile                      |   1 +
>  drivers/power/supply/sbs-charger.c                 | 274 +++++++++++++++=
++++++
>  4 files changed, 304 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sb=
s-charger.txt
>  create mode 100644 drivers/power/supply/sbs-charger.c

Thanks for your patchset. We are currently in the merge
window and your patchset will appear in linux-next once
4.10-rc1 has been tagged by Linus Torvalds.

Until then I queued it into this branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/log=
/?h=3Dfor-next-next

-- Sebastian

--ro6e4rasvs2ecpuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhcFY4ACgkQ2O7X88g7
+poZJg//fEKBJ5Z/Czltb8z/DRc2Y6pfrC9e8JXWpoo8BWeaB+2zrK5R2X6gb6Rq
Cfg3LZXMubfz8obyNxBy22+4sqYpTeXYgqjJOy2yzfW0LunFvqgRIsjpwtRSXAl6
hvI5R1kpz1odXXy8e/QOUgu/CoYqFE1F2tDCOLTuu/LbKxJPCMlTPW6wj4Ajnv+a
iEW8pPodQ7BJvV/ebEAmtFz8O00zggwbWIcE/TKqCTuq/zv913Bd3YBG0xDcsR0M
PA1NgmbK7MOyEFyqRuxB0yrbyyzp1arAnAqt/wPaPktQP2uprGYj+dYey6RR/FXG
rbWP5eEg2ifL9cBYXW6huYd0pULjd8ZOLXK5PK6wwfmJriLfMAO8ss3sElSZO1bv
/TdzR72I6PF+OM72JPTlE1hHIIl16OEVn1SQj9uSfIkPqot7sRC4TVT13b/NCzS+
t1qOgGEEtC3rcjOGsImigxY6DyFnFiRxVxszpxvLcnP99CY+qnzGgqR2fxLm8bB5
YSmNCJl+XuArgLxovyIXTCyNflQYtQuoUOvHwwcDErb0zgyZFHi6imlJREdXsFY/
Pimw/x4JGWKYt7vTbQ29Hcaky5DOtVObO7Q/3AwmtWwjoYd0/otuk6oRIlsOQkJJ
bWo8HRPZQausRkbQtg76GoMift4PuoFLmX8jRw75UPyRz8mxwMg=
=gPwY
-----END PGP SIGNATURE-----

--ro6e4rasvs2ecpuw--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
