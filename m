From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/8] devicetree: power: add battery state machine
 documentation
Date: Sun, 29 Jan 2017 18:27:39 +0100
Message-ID: <20170129172739.suyqlcit6hytc3rg@earth>
References: <20170122071404.9654-3-matt@ranostay.consulting>
 <20170122222212.27086-1-liam@networkimprov.net>
 <CAKvHMgS9ZxE2qxDqeAVRJFzerjkJV=io58aQjtU51j=kFzbYtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eh5elnuadhhkd4k2"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKvHMgS9ZxE2qxDqeAVRJFzerjkJV=io58aQjtU51j=kFzbYtw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--eh5elnuadhhkd4k2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 24, 2017 at 11:56:33AM -0800, Liam Breck wrote:
> On Sun, Jan 22, 2017 at 2:22 PM, Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org> wrot=
e:
> > I think Matt meant the following :-)
> >
> > Note: nominal-microvolt is not the correct term for termination voltage.
> > Changed to termination-microvolt
> > ---
> >
> > Documentation on battery properties that can be defined for
> > fine tuning fuel gauge state machines.
> >
> > From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> > Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> > ---
> >  .../devicetree/bindings/power/supply/battery.txt   | 34 ++++++++++++++=
++++++++
> >  1 file changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/batt=
ery.txt
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt=
 b/Documentation/devicetree/bindings/power/supply/battery.txt
> > new file mode 100644
> > index 000000000000..398b4d622883
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> > @@ -0,0 +1,34 @@
> > +Battery Characteristics
> > +
> > +Required Properties:
> > + - compatible: Must be "fixed-battery"
> > +
> > +Optional Properties:
> > + - termination-microvolt: dead battery voltage
> > + - design-microwatt-hours: battery design energy
> > + - design-microamp-hours: battery design capacity
>=20
>=20
> Two more battery characteristics should be included. Battery chargers
> need them (for instance, BQ24190).
>=20
> - precharge-microamps: maximum charge current during precharge
>   phase (typically 20% of battery capacity)
>=20
> - termination-microamps: a charge cycle terminates when the
>   battery voltage is above recharge threshold, and the current is below
>   this setting (typically 10% of battery capacity)

I guess quite a few battery characteristics could be added. Let's
do this once we have a user for them.

> Perhaps termination-microvolt should be called terminal-microvolt or
> similar to avoid confusion.
>=20
> Sebastian, did you want to include the other fields from your example?

Let's add properties once we have users for them. I just
used the stuff printed on my Nokia N900's battery as an
example :) I guess chemistry-type may actually be useful
already. I think at least some bq27xxx chips would also
work with LiPo based batteries.

-- Sebastian

--eh5elnuadhhkd4k2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOJgsACgkQ2O7X88g7
+pqyLhAAkp3IyuZ5f2le8BxiKGJ/Ih1sgxo1acmPQI+KFbEpA+R8ZcUAi1wwsarK
CYbb/8biA5WS/q67Vxf9LcmFH4fWD5ViVZNVzRPJJgpVWnEnk9YHPt9ApJcb0osn
GD1S4FO0p+Qhv8iknIut+aLh9vtDWeNcZPp4KJ45G+tbA5BR6s/hdrsXlOvZqBIc
H+BjH1AWg8RgxA7Pb7NgP+sOQuHQOY9gfOaxdu8v0VrhlFr0xAI2qdOebJtX6rEC
RKvWO+ByWqIdlqA/dX0Krj8PXhT3oJK0hjnejOQno+bPwCeawlMgk5C7kqYdQuGQ
CST5v/wxXOgbZROm0CJWyDhjDHWWRLm5cH0bS+7yfC3i9OOiyyZWOejpq4bJLeP4
jpVXf+91yt5hlSbD2shozVCEeL9AwDX9gxmK+GkKqVvWS/abTJSnH0wItuJr0CXs
K3rH/Yfztg6Bml96kmUdikOKmyP7OM2S/AkV2xGUr88xOyeF/9iTiaGNWM8RhWtR
7B1FdsKxtLUFabpCNqHaPCIXV+1fRErvf5/1yez4LninEfgUjOF40/0ZcpwZix5q
y0FQIc0M354apadavjmDAVe1Zdu4emeLgwnX2ST0ZI4q5CIwRd7jPb556H4iniwL
rTJoC5PXxi0eK3R9zpxajIHeZNjBD1LoEy8NKQDiOsJ0sJ9RFjI=
=KT8t
-----END PGP SIGNATURE-----

--eh5elnuadhhkd4k2--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
