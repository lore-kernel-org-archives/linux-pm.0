From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: LTC3651 and other GPIO chargers
Date: Mon, 3 Jul 2017 15:52:38 +0200
Message-ID: <20170703135238.6rbjh26l6yd7v7xy@earth>
References: <20170626162105.rgewvl2z2ftbxqyn@lenoch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="353dyreisbmqb5rh"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52450 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933893AbdGCNwn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 09:52:43 -0400
Content-Disposition: inline
In-Reply-To: <20170626162105.rgewvl2z2ftbxqyn@lenoch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-pm@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>, Rob Herring <robh@kernel.org>


--353dyreisbmqb5rh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 26, 2017 at 06:21:06PM +0200, Ladislav Michl wrote:
> A driver for LTC3651 was recently added to -next
> https://patchwork.kernel.org/patch/9717049/
> which brings a question whenever we want to add separate driver
> (or vendor specific bindings) for ever growing list of similar
> chargers. For example those using the same status output lines
> are: BQ24232HA, LTC4007, LTM8061, RT9502, LT3651, LT3650, TP4056,
> MAX1737...
> Others for example BQ24032A and LM3658 (which I have to support)
> are using different status encoding, ie. LM3658:
>=20
> stat1	stat2		Condition
>   0	  0	Power-Down, charging is suspended or interrupted
>   1	  0	Pre-qualification mode, CC and CV charging
>   0	  1	Charge is completed
>   1	  1	Bad battery (Safety timer expired), or LDO mode
>=20
> What about extending gpio-charger instead?
> - allow gpio list fdt subnode
>   - consider each gpio line to represent bit in a word
> - provide per property subnodes
>   - each subnode holds a mask and mapping to property values
> This way we should be able to cover most chargers providing status
> using gpios. Comments welcome and appreciated - those will turn into
> implementation.
>=20
> Thank you,
> 	ladis

I think you mean something like this?

charger {
    compatible =3D "vendor,chip", "gpio-charger;

    status-gpios =3D <status-gpio1>, <status-gpio2>;

    status-mapping-0 {
        mask =3D <00>;
        type =3D "exploded";
    };

    status-mapping-1 {
        mask =3D <01>;
        type =3D "frozen";
    };

    ...
};

In that case: NAK. I like the general idea, but the DT binding looks
like a mess. Instead of providing the mapping in DT, it should be
provided by the driver and selected based on the compatible value.

-- Sebastian

--353dyreisbmqb5rh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllaTCMACgkQ2O7X88g7
+ppOQA/+IGPBzYasQEQKvqu9Ifm2QggCl/D7n2qxkuM1yxKaY1O+jrN5LbHxVDuv
1Smaf5FRq8WEzT9eyenJ7fDPw9HUqdYm3Xd27wjQ0mQNx8P+1XOqfMWc7mtyhaa+
ceZQjdB5WDg29XCKwdfkOzIyPRs/7IB+f8zGElQwm0illo0qhg9QuEFyqCz/hNM1
JV30AplMsDXV/9FQgn/T6QXFyVi9VwHM7+GP31R8xV28LphNN3WUdAPLgb1xEC++
OHQW//SjC26lHoU0iGbROK+xY/8du7fGfQmyHNAB9wrXzFW9T+Nn+V/o0sASdL9M
IStVzywp8q5lStS8MMpfvI0i7CfHfJCKlfY8GKJg9kXJGDUMUQXtEJn5y4puHfI2
xOdxfO3V50sJavBBlq6zKjwV8lGY46vCbcpIwZDqZy8j+Iyc4XblBtSQXmSmBun3
VFuHYiGMXVtNa0zld/8VtK6uiOET4A9ivEh0iz1t9QMtxtlNWcK9Ht2BFeFxD0fb
tva2Pk25D9haMngmiC0Ivw/F+/fm+540YiEgEjNvKNm/L8xMgxalCMf48ihgoJ6e
HhxUvQBTr8ytIsJfWiGoI0kE9LjcMTXDfTiVqLn9j4pRgyNchM8nv9Bx6ABbkhD2
M7wawiydO8iKJjEStRQgFJ2eRIMxVCx5YDVAEyRFXMJpEKwbCu0=
=0hCG
-----END PGP SIGNATURE-----

--353dyreisbmqb5rh--
