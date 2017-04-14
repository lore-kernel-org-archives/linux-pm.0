From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v11 01/10] devicetree: power: Add battery.txt
Date: Fri, 14 Apr 2017 02:33:04 +0200
Message-ID: <20170414003304.adkptqvwpuxdwdzq@earth>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-2-liam@networkimprov.net>
 <CAKvHMgTxRJXgfpDgqQ_+=ErFEZAh9CodjVn5ZOoCfqPqSZWetA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gdoxylihsgsj6nrp"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKvHMgTxRJXgfpDgqQ_+=ErFEZAh9CodjVn5ZOoCfqPqSZWetA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--gdoxylihsgsj6nrp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 07, 2017 at 12:23:29PM -0700, Liam Breck wrote:
> [+CC Tony Lindgren]
>=20
> Rob & Sebastian & Tony & Andrew,
>=20
> With this binding we allow a DT to hard-code battery characteristics.
> But mainline dts files for boards & boxes really should NOT include
> immutable battery properties unless the battery is inseparable from
> the electronics. We want to prevent unpredictable behavior due to
> incorrect DT properties after a user changes a battery to a different
> type.
>=20
> It's OK for device vendors to hard-code battery characteristics in DT,
> but mainline dts is another matter.
>=20
> If this is agreed, how should we document it?

That's not a problem of mainline vs vendor. The binding may only be
used for batteries, that cannot be exchanged with a different type.
That's why I originally suggested the "fixed-battery" name. IMHO
it would be ok to use the binding also for DTS files distributed
with the mainline kernel as long as the described device provides
some kind of protection against using batteries of a different type.

For example I would feel ok adding a simple-battery node for the
Droid 4 (which probably does not need one), since the battery has
a custom form-factor, is screwed to the device and has a custom
connector. So while it can be replaced, the new battery would have
the same technical specs.

I suggest to add something similar as the following to the binding:

Using incorrect battery parameters is a SAFETY HAZARD - If used
incorrectly, Lithium based batteries can explode. You should be
really sure, that all provided values are correct. Also if the
battery in your device can be replaced with a different battery
(without major hacks), you may not use this binding for safety
reasons.

-- Sebastian

> On Mon, Mar 20, 2017 at 2:43 AM, Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org> wrot=
e:
> > From: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
> >
> > Documentation of static battery characteristics that can be defined
> > for batteries which cannot self-identify. This information is required
> > by fuel-gauge and charger chips for proper handling of the battery.
> >
> > Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> > Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
> > ---
> >  .../devicetree/bindings/power/supply/battery.txt   | 43 ++++++++++++++=
++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/batt=
ery.txt
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt=
 b/Documentation/devicetree/bindings/power/supply/battery.txt
> > new file mode 100644
> > index 0000000..53a68c0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> > @@ -0,0 +1,43 @@
> > +Battery Characteristics
> > +
> > +The devicetree battery node provides static battery characteristics.
> > +In smart batteries, these are typically stored in non-volatile memory
> > +on a fuel gauge chip. The battery node should be used where there is
> > +no appropriate non-volatile memory, or it is unprogrammed/incorrect.
> > +
> > +Required Properties:
> > + - compatible: Must be "simple-battery"
> > +
> > +Optional Properties:
> > + - voltage-min-design-microvolt: drained battery voltage
> > + - energy-full-design-microwatt-hours: battery design energy
> > + - charge-full-design-microamp-hours: battery design capacity
> > +
> > +Battery properties are named, where possible, for the corresponding
> > +elements in enum power_supply_property, defined in
> > +https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/include/linux/power_supply.h#n86
> > +
> > +Batteries must be referenced by chargers and/or fuel-gauges
> > +using a phandle. The phandle's property should be named
> > +"monitored-battery".
> > +
> > +Example:
> > +
> > +       bat: battery {
> > +               compatible =3D "simple-battery";
> > +               voltage-min-design-microvolt =3D <3200000>;
> > +               energy-full-design-microwatt-hours =3D <5290000>;
> > +               charge-full-design-microamp-hours =3D <1430000>;
> > +       };
> > +
> > +       charger: charger@11 {
> > +               ....
> > +               monitored-battery =3D <&bat>;
> > +               ...
> > +       };
> > +
> > +       fuel_gauge: fuel-gauge@22 {
> > +               ....
> > +               monitored-battery =3D <&bat>;
> > +               ...
> > +       };
> > --
> > 2.9.3
> >

--gdoxylihsgsj6nrp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljwGL0ACgkQ2O7X88g7
+prfMhAAgy9mjXn7lGVa3CgMxCcC8CZ2Nlp4CC1f7pQyh9KiXlLi2Zg6Ah0FVnfx
6U3hBeb6Y2dMgsJJXyrMoShiqDqSDAXcdZbOvOPgSlCP4a371Luv0MYGLtaiUjRF
rUNwcO6k7GOZpWSngDLa0leaEhac+wMXE6jFGCvGusZ71FNu1+BwhyVBBCddT74Y
+K+6peJa3/6hXrui0dwMWEeFJKBZWWsdoSgU0Bq78FFgImUJAVPqzwO1qKA2sSAZ
GKl8sp8I37F9c260wI/66gsAGVJqDTWqFUv2kMBv9fsfP6f0up+8621nCmMPqwz+
hfsNpxx/YeP84sA4qEII3zjD4Pi9oPZ9LrTt4JEzB50bhmGvLLwpBWriYJ5yRKOP
YERPeqP4rJJ+HHhs9NvEKBwKQ6743+HkGWyVFRZKXqszJBMKqJvXCbLcwYmdoW0/
xAXjne2dsHYfd2y5TdvMEYgHJjPiX7iDmh6b0ttgs4mgSfLjOs+FTj7oj9jocv3N
3bH+va9fJR7ANKuWSALFgR6PmSYPWbH0EB6/m2O/yA4fEWJ6oO7P6/X1FOureFw8
2w4Nk8GoZs7v0v+aDL/evW/nA9YHbbYypiabj4KPM5/GClwHKQ4sXd0ctssYm9lf
8dpQk0C8aTgi72WosZtvQOirgxdn5Bh9P9aJBmDR+KZTdmjx+sQ=
=esf+
-----END PGP SIGNATURE-----

--gdoxylihsgsj6nrp--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
