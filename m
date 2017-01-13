From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 1/7] devicetree: power: add battery state machine
 documentation
Date: Fri, 13 Jan 2017 19:33:53 +0100
Message-ID: <20170113183353.u3ug46gi66kaivjd@earth>
References: <20170111062003.10110-1-matt@ranostay.consulting>
 <20170111062003.10110-2-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hthd7sbsaxsxgu6i"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750713AbdAMSd7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 13 Jan 2017 13:33:59 -0500
Content-Disposition: inline
In-Reply-To: <20170111062003.10110-2-matt@ranostay.consulting>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matt Ranostay <matt@ranostay.consulting>, Rob Herring <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com


--hthd7sbsaxsxgu6i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 10, 2017 at 10:19:57PM -0800, Matt Ranostay wrote:
> Documentation on battery properties that can be defined for
> fine tuning fuel gauge state machines.
>=20
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
>  .../devicetree/bindings/power/supply/battery.txt     | 20 ++++++++++++++=
++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/batter=
y.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b=
/Documentation/devicetree/bindings/power/supply/battery.txt
> new file mode 100644
> index 000000000000..a6ca761e0a29
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -0,0 +1,20 @@
> +Battery State Machine Support

Let's also add a mandatory compatible string. This binding
is only relevant for dumb batteries, since other ones can
self-identify. I suggest

compatible =3D "fixed-battery"

> +Optional Properties
> + - nominal-microvolt: dead battery voltage in microvolts
> + - design-microwatt-hours: battery design mWh in microwatts
> + - design-microamp-hours: battery design mAh in microamps

I think we should mandate the property name of the phandle in the
generic binding instead of each potential fuel-gauge/charger.
Maybe something like the following paragraph:

Batteries are supposed to be referenced by chargers and/or
fuel-gauges using a phandle. The phandle's property should
be named "monitored-battery".

> +Example:
> +
> +	bat: battery@0 {
> +		nominal-microvolt =3D <3700000>;
> +		design-microwatt-hours =3D <5290000>;
> +		design-microamp-hours =3D <1430000>;
> +	};
> +
> +	charger: charger@0 {
> +		...
> +		monitored-battery =3D <&bat>;
> +		...
> +	};

Let's also add a fuel-gauge to the example to avoid any confusion
between fuel-gauge and battery.

fuel_gauge: fuel-gauge {
    ...
    monitored-battery =3D <&bat>;
    ...
};

-- Sebastian

--hthd7sbsaxsxgu6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh5HY4ACgkQ2O7X88g7
+prnyRAAnMsO/j9bMr1CN0fkniT+G6/Qd+zu4b68K+D6rkO3jrZB55Dh8EHLSgqH
MNs7yN2SWvZPgqtaou2e0FNK2aZ12tzJT1VJf2LIhzigCuKTVUHsosQmD6ijLAY0
Es5wQzKG2dE/BgZBbKdxRW5g/Av7EBd0mjFpn5v4Bd311eWU1N5tbRstIAZXR9nq
++bURfHuQzAlLDqU/XUg1MVdk8b8wZE97Zj9R2nglzuvUpVUbm+mwyEufDhJFQNj
RMxzZkkEPvDJ9hYBtNGxKpiyVwPrOm6DMh9e4miR5d23brqoSxtcuIkVIYHGxYzC
UXinDzZ3rJTvAIp163+TWFSCHNL0Su0nyO0tYAKK58hxVNc2Z3fCQeqAXqq4uA8b
MNqEbAzxsK3qwPmnAREvgzq2UKugAKpQz6SOwOPXhfaYw5S6s3Bg1EPUreLYq8PQ
YX1Tyxqj/OXhRsFgisfykSib4oW8UjSkZY3PCq4glwbhZhRCpnpG+SlFI31mJQc5
4jhXxYQWH0Oj5GdSZm6VgGZCHbqX1YqGGo80LcAFYRfhxTnslNo22fBPO7+mw77Z
xKrre40JUq6MGEuhemMgy3lZxi7wuVWnH7q5DaNAXj6KY68zuw9ifuI9YRvnpI9k
BJwxwYQpzcRNW8ZMMeq67hMi7X5rZ2krecmrZ+6TLqVkDJATIEg=
=+9Go
-----END PGP SIGNATURE-----

--hthd7sbsaxsxgu6i--
