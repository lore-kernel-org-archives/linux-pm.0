From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 2/8] devicetree: power: add battery state machine
 documentation
Date: Sun, 29 Jan 2017 18:20:06 +0100
Message-ID: <20170129172006.jsjfxrehynfegpfr@earth>
References: <20170122071404.9654-3-matt@ranostay.consulting>
 <20170122222212.27086-1-liam@networkimprov.net>
 <CAKvHMgRYqh_fksDXq2Jv1t6p9ckCOgR+O6gxRTdpd=9r8y__Bg@mail.gmail.com>
 <CAJ_EiSSPeWj+q+R5=HVVrsb39208-Gmj5_7T=ic6mYLxFuekNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nt35vx2j4jldzdx5"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751215AbdA2RUM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Jan 2017 12:20:12 -0500
Content-Disposition: inline
In-Reply-To: <CAJ_EiSSPeWj+q+R5=HVVrsb39208-Gmj5_7T=ic6mYLxFuekNQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matt Ranostay <matt@ranostay.consulting>
Cc: Liam Breck <liam@networkimprov.net>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>


--nt35vx2j4jldzdx5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 25, 2017 at 11:02:03PM -0800, Matt Ranostay wrote:
> On Wed, Jan 25, 2017 at 10:19 PM, Liam Breck <liam@networkimprov.net> wro=
te:
> > On Sun, Jan 22, 2017 at 2:22 PM, Liam Breck <liam@networkimprov.net> wr=
ote:
> >
> >> diff --git a/Documentation/devicetree/bindings/power/supply/battery.tx=
t b/Documentation/devicetree/bindings/power/supply/battery.txt
> >> new file mode 100644
> >> index 000000000000..398b4d622883
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> >> @@ -0,0 +1,34 @@
> >> +Battery Characteristics
> >> +
> >> +Required Properties:
> >> + - compatible: Must be "fixed-battery"
> >> +
> >> +Optional Properties:
> >> + - termination-microvolt: dead battery voltage
> >> + - design-microwatt-hours: battery design energy
> >> + - design-microamp-hours: battery design capacity
> >
> > Also I suspect the members of struct power_supply_battery_info should
> > use the same names as appear in dts:
>=20
> These are internal and we can't be thinking just device tree.. ACPI
> and platform data is also an option.

well platform data just uses the struct. ACPI is probably not
relevant, since in ACPI world one usually has smart batteries.
But yes, the names can be different.

The important part is, that the API is used correctly, so it
should be clear what each property is used for. For example
termination_microvolt is not clear: Is this charge termination
voltage or system shutdown voltage? Also we do not need to add
"micro", since the power-supply subsystem always uses micro
based units.

-- Sebastian

--nt35vx2j4jldzdx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOJEQACgkQ2O7X88g7
+prL/w/8ChdSWlJcWxPzetzoclozNvPgL6INzM7tHy1lYVieEb+fJdRaDc9/HHv9
szotJcC4PVFzlhyuZ4wC8JS19lZ2LlLImbD1OTI00XHQgi1lhhZUw4PGnMfiRliJ
k5DFS4od4H8bT/VNiok8eZCgkrYQJpQNO9eF3jtUml5OV1CJllprWtKHnA8vWuGn
XVF7aoQ/a3k+oZMRsWe6+jSc50Fbsk4ZCrMQob0cGFP/vFykbzax4UnrljW0uYIu
3xOp4aDdJO5+pVEin00/7WK0Mr5OE7c+K8jj0vNwjsr/SrHYoxA9JrB3cV6Sr7DL
UIYPmeKNOybbgTpMQwJ52eJss5B/4iV3zPIWuB0IirI7DK5UV1gcpiOVyrKRWSYj
3Rd8d6c2mMQORvF7U2xrVjyH032YXMLo+e2pTwAaxD1bMuImOJ0TxE9X6hNTzfY8
sZEKyMSvfaynGfszagt6ZH8vw7FDZHNRE/KonlLoyTNj8BNTi5vLW0Q79jzcBB+k
X/gSktOrD30G4UC7r30LtNQJpIvxehdW9CP5SEV6MDvReYoOFbK9xB4jhsl6Y2vs
nMOsASIK4fE9JCQeKrys5a55IHrZTOUGhY2G9WewD+uGvFr4UEmjihbef7Hq0Yyo
KMGSUNgn86Iw0WivM5YDN0+Qhbumqkyh9LSZlzwRgTjdgloUqSg=
=G9lt
-----END PGP SIGNATURE-----

--nt35vx2j4jldzdx5--
