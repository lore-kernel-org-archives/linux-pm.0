From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RESEND PATCH 1/3] power: charger-manager: Replace deprecatd API
 of extcon
Date: Fri, 15 Apr 2016 16:13:18 +0200
Message-ID: <20160415141318.GA24087@earth>
References: <1460681016-2770-1-git-send-email-cw00.choi@samsung.com>
 <1460681016-2770-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50729 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbcDOON0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 15 Apr 2016 10:13:26 -0400
Content-Disposition: inline
In-Reply-To: <1460681016-2770-2-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 15, 2016 at 09:43:34AM +0900, Chanwoo Choi wrote:
> This patch removes the deprecated notifier API of extcon framework and th=
en use
> the new extcon API[2] with the unique id[1] to indicate the each external
> connector. Alter deprecated API as following:
> - extcon_register_interest() -> extcon_register_notifier()
> - extcon_unregister_interest() -> extcon_unregister_notifier()
>=20
> And, extcon alters the name of USB charger connector in patch[3] as follo=
wing:
> - EXTCON_CHG_USB_SDP /* Standard Downstream Port */
> - EXTCON_CHG_USB_DCP /* Dedicated Charging Port */
> - EXTCON_CHG_USB_CDP /* Charging Downstream Port */
> - EXTCON_CHG_USB_ACA /* Accessory Charger Adapter */
>=20
> So, the name of external charger connector are changed as following:
> - "USB" -> "SDP"
> - "TA" -> "DCP"
>=20
> [1] Commit 2a9de9c0f08d61
> - ("extcon: Use the unique id for external connector instead of string)
> [2] Commit 046050f6e623e4
> - ("extcon: Update the prototype of extcon_register_notifier() with enum =
extcon
> [3] Commit 11eecf910bd81d
> - ("extcon: Modify the id and name of external connector")
>=20
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  .../bindings/power_supply/charger-manager.txt      |  4 +--
>  drivers/power/charger-manager.c                    | 31 ++++++++++++++--=
------
>  include/linux/power/charger-manager.h              |  4 +--
>  3 files changed, 24 insertions(+), 15 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power_supply/charger-manag=
er.txt b/Documentation/devicetree/bindings/power_supply/charger-manager.txt
> index ec4fe9de3137..73193e380dc2 100644
> --- a/Documentation/devicetree/bindings/power_supply/charger-manager.txt
> +++ b/Documentation/devicetree/bindings/power_supply/charger-manager.txt
> @@ -65,13 +65,13 @@ Example :
>  		regulator@0 {
>  			cm-regulator-name =3D "chg-reg";
>  			cable@0 {
> -				cm-cable-name =3D "USB";
> +				cm-cable-id =3D 5; /* EXTCON_CHG_USB_SDP */
>  				cm-cable-extcon =3D "extcon-dev.0";
>  				cm-cable-min =3D <475000>;
>  				cm-cable-max =3D <500000>;
>  			};
>  			cable@1 {
> -				cm-cable-name =3D "TA";
> +				cm-cable-id =3D 6; /* EXTCON_CHG_USB_DCP */
>  				cm-cable-extcon =3D "extcon-dev.0";
>  				cm-cable-min =3D <650000>;
>  				cm-cable-max =3D <675000>;

This breaks DT ABI. Looks like charger-manager is not used in
mainline, but I guess ther should be an explicit Acked-By from
a DT binding maintainer. Also I think the defines should be in
some header includable from DTS, so that something like this
can be done:

cm-cable-id =3D <CHARGER_USB_DCP>;

Apart from that:

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXEPb8AAoJENju1/PIO/qajVYP/iOWFiOwz6r2bypjewpafye2
oF78jqYG2ha5et/sWEZqQcv8ox2X3zccQwRH3/czWEgNAG5hzL13sjBLAPSzWXtL
LGvUi6oX8/2gVlL9ZSybGD+tAPMwiyyv0yH0gu5UIphlX4nRHBsyD4LxVBYEmEyF
72XFmdhsXVI8lyVHFhEFgdOHdGsqirYihAVZ8dSVqBXWWh/+8CsDp9F3cdM/hITL
DNw1vosJBGwgwiVIhcYODIOgv6lHzchwe+5wSNMO9xgdf+XXqiig1Wqufd3CUdP+
5TK5UtyNL6gErCa7EpnEe8qlEyXeZXXLlEtkXBy8anv6zH+gpIPSbkZL0LoHAobH
mFf+NbpUYqondn9H7O4FkQZ2RMcmEfnJ6jO6Ghs1uNxR8tO1JYoHaEno5AIc4hcA
DoRe0lSEkAtXqUmCMfJLwuS4OVjjlCk1XpKSmo+Id2t6Cl1igdnEXqo9myi0lshr
N5w50r2AZfHnjjy2RyV7eTbeoqquahy5WI3gUYUq4yFy3++moIaTgAUbZxyp8Cvs
RNWsUOjxmKBvhA/3pjqs6PJ7cbMXShiUnHrCjBZp5fBj+M8j+oRArVaSJXkb+akW
Qv1CxPNKkbr3n/6YF3GK0NggitHRHdzkKFhhMoaidB75Av8FoPD3SNabE+aNQp2N
nnsTo7Wmju+XnUtejXz9
=T0L3
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
