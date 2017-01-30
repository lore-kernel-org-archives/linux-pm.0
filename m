From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 2/8] devicetree: power: add battery state machine
 documentation
Date: Mon, 30 Jan 2017 03:30:12 +0100
Message-ID: <20170130023012.b2vnye6vb4yoawcq@earth>
References: <20170122071404.9654-3-matt@ranostay.consulting>
 <20170122222212.27086-1-liam@networkimprov.net>
 <CAKvHMgRYqh_fksDXq2Jv1t6p9ckCOgR+O6gxRTdpd=9r8y__Bg@mail.gmail.com>
 <CAJ_EiSSPeWj+q+R5=HVVrsb39208-Gmj5_7T=ic6mYLxFuekNQ@mail.gmail.com>
 <20170129172006.jsjfxrehynfegpfr@earth>
 <CAKvHMgSYXYyW7AEHaa_wkh3UQyE6wJPYV66HAugBf3wHOeoSmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w4jo6if4rc27dmgw"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbdA3CaR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Jan 2017 21:30:17 -0500
Content-Disposition: inline
In-Reply-To: <CAKvHMgSYXYyW7AEHaa_wkh3UQyE6wJPYV66HAugBf3wHOeoSmg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Matt Ranostay <matt@ranostay.consulting>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>


--w4jo6if4rc27dmgw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 29, 2017 at 03:22:31PM -0800, Liam Breck wrote:
> On Sun, Jan 29, 2017 at 9:20 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > On Wed, Jan 25, 2017 at 11:02:03PM -0800, Matt Ranostay wrote:
> >> On Wed, Jan 25, 2017 at 10:19 PM, Liam Breck <liam@networkimprov.net> =
wrote:
> >> > On Sun, Jan 22, 2017 at 2:22 PM, Liam Breck <liam@networkimprov.net>=
 wrote:
> >> >
> >> >> diff --git a/Documentation/devicetree/bindings/power/supply/battery=
=2Etxt b/Documentation/devicetree/bindings/power/supply/battery.txt
> >> >> new file mode 100644
> >> >> index 000000000000..398b4d622883
> >> >> --- /dev/null
> >> >> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> >> >> @@ -0,0 +1,34 @@
> >> >> +Battery Characteristics
> >> >> +
> >> >> +Required Properties:
> >> >> + - compatible: Must be "fixed-battery"
> >> >> +
> >> >> +Optional Properties:
> >> >> + - termination-microvolt: dead battery voltage
> >> >> + - design-microwatt-hours: battery design energy
> >> >> + - design-microamp-hours: battery design capacity
> >> >
> >> > Also I suspect the members of struct power_supply_battery_info should
> >> > use the same names as appear in dts:
> >>
> >> These are internal and we can't be thinking just device tree.. ACPI
> >> and platform data is also an option.
> >
> > well platform data just uses the struct. ACPI is probably not
> > relevant, since in ACPI world one usually has smart batteries.
> > But yes, the names can be different.
> >
> > The important part is, that the API is used correctly, so it
> > should be clear what each property is used for. For example
> > termination_microvolt is not clear: Is this charge termination
> > voltage or system shutdown voltage? Also we do not need to add
> > "micro", since the power-supply subsystem always uses micro
> > based units.
>=20
> It's the min battery voltage. So...
> drained_voltage, depleted_voltage, sapped_voltage, spent_voltage...

This is often called EOD (end of discharge) voltage, so let's use
end_of_discharge_voltage.

-- Sebastian

--w4jo6if4rc27dmgw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOpTEACgkQ2O7X88g7
+ppO2hAAlZ+AfGQhHFqj2jybpXXkhDZm5hOegEoIiCam/pO81EMCBslaTLrGqc8A
PbfK6/dLrszYkZ4fMW20fg7hTTNtAfuIfYh5MYjsNncJGtcJ+joOG6ZOT82G2vJ6
d+296bvy879ONVwi2Ej5hemYibfrMw9noNOYrQWjpVV/eBT5OFB4J/FxHxyFifGq
9c4y47OrgZQcoNaaZxFg9uBL1ESNIjq6hCG7Zw594AaW9kGL5GQPzs+il4QDGddY
bzUIG6Y1YFqujboW/LEf7I4cnxXaII3CH23dZ5UAOrXfSBQQZUzAxbP7p3WKlFtF
+mXHYc/Nll/SkhFX7/PiHrW7aoSM1MKh7fFhATL8ek8emzyBcTsFXMcaRGDFA2VJ
dDWfiS2KYnnfBi0ThBEbYnC6p39wIghKHqTmBp3Jj/CSbzV7u/AiFwDknzSXGX4N
IvIGMc4ykH2rpyWnH8BSlqZ50S90zrn86beWO47T6AGZLoKmDbXsABHUeH4DvHoG
rkHHpa5ZLPbML7qmp1RcHVhHCNz5nvWyzplr+iHL1UioSzSsqXjMDPiusuqvqUH4
K3RGGLuU+xicoElh9m0av5q3gY9lxfGbJZIrIiqQmSqpd1VnFB706nteF3Jcoc50
S6d9Swc+xa9qwuLsYNhlTzvCr3aIyBqp4O0L/OZk+5iadHiSH8Q=
=Bv4b
-----END PGP SIGNATURE-----

--w4jo6if4rc27dmgw--
