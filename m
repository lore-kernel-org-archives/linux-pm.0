From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/8] devicetree: power: add battery state machine
 documentation
Date: Mon, 30 Jan 2017 03:39:34 +0100
Message-ID: <20170130023934.l5s7jwaozcjovqhc@earth>
References: <20170122071404.9654-3-matt@ranostay.consulting>
 <20170122222212.27086-1-liam@networkimprov.net>
 <20170129180619.di5ul4owkzjveoct@earth>
 <CAKvHMgTrFjjEWwK-NeGOF1o6KRQPXYUvcqWcDwaW+5ZKjQ7VZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2yp7bibt7lnmiphy"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKvHMgTrFjjEWwK-NeGOF1o6KRQPXYUvcqWcDwaW+5ZKjQ7VZA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--2yp7bibt7lnmiphy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 29, 2017 at 03:32:10PM -0800, Liam Breck wrote:
> On Sun, Jan 29, 2017 at 10:06 AM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrot=
e:
> > On Sun, Jan 22, 2017 at 02:22:12PM -0800, Liam Breck wrote:
> ...
> >> +Batteries must be referenced by chargers and/or fuel-gauges
> >> +using a phandle. The phandle's property should be named
> >> +"monitored-battery".
> >> +
> >> +Example:
> >> +
> >> +     bat: battery {
> >> +             compatible =3D "fixed-battery";
> >> +             terminate-microvolt =3D <3700000>;
> >> +             design-microwatt-hours =3D <5290000>;
> >> +             design-microamp-hours =3D <1430000>;
> >> +     };
> >> +
> >> +     charger: charger@0 {
> >> +             ....
> >> +             monitored-battery =3D <&bat>;
> >> +             ...
> >> +     };
> >> +
> >> +     fuel_gauge: fuel_gauge@0 {
> >> +             ....
> >> +             monitored-battery =3D <&bat>;
> >> +             ...
> >> +     };
> >
> > The charger stuff does does not integrate well with
> > pre-existing support for power-supplies property
> > described in
> > Documentation/devicetree/bindings/power/supply/power_supply.txt
> >
> > I think the proper chain would be:
> >
> > bat: battery {
> >         compatible =3D "fixed-battery";
> >         terminate-microvolt =3D <3700000>;
> >         design-microwatt-hours =3D <5290000>;
> >         design-microamp-hours =3D <1430000>;
> > };
> >
> > fuel_gauge: fuel_gauge@0 {
> >         ...
> >         monitored-battery =3D <&bat>;
> >         power-supplies =3D <&charger>;
> >         ...
> > };
> >
> > charger: charger@0 {
> >         ...
> > };
> >
> > I added the power-supplies node to the fuel-gauge instead of the batter=
y,
> > since fuel-gauge + fixed-battery is basically a smart battery.
>=20
> BQ24190 charger will need other params from a battery node. How does
> it get them in this scenario?

It should be able to get all required properties from the bq27xxx.
Otherwise supporting smart batteries is impossible. What properties
do you need?

-- Sebastian

--2yp7bibt7lnmiphy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOp2YACgkQ2O7X88g7
+po07g/+M9uckNO/kNMD4I1MihPubmbUyFmME2jLdT02CcTfEH62oWK+0ddcgdRK
sxVOA4DpA8TdrWNQQb+EhROoa9WYZlAFrXdW7HueU+ElDjcRnDk52ZIyhqkXeGNA
X0AsTb4BDgsOGnVOs+n2dYUeodLDNAhyYUIcCkg5MmU3XboDmQqwfm3ngN5PRB58
lMFZ0PkdROT5vvAlr880ssyqIlTBSPs0E81rnGp8AECGh3Cqa68Q2CC8wgIo4Vpt
+y6TXZHRjhvIlgtzlxSPlUTsZ/L2cAKBdvV7ZeZuRHDKx0liHo7J+GwARLjkB7o7
mBwTs7+LKN9GJ64j3Zg6Z4H16q3xfC+DhPayLn7ztB1CN/J0bTYfhRbKBjT0o4Ya
FWUQcMCD3zwQynnYK5dSvJ0uQDpo2bB0tYPYEu0UBImI/kluFAEXPSqKIaZtAxSl
86sX81Un76/V+KfVU74KJ7aRHglKn0fjr/6MTvbrWVIBPuXiPupApJHspGE7fDwD
P8iT2/68jYrjvEMSzzEQUU50JDjDAYV6KkpvPDQQuA0hcYCSHrEwfCyfbJ37wQ4J
+49IErxP65SRlkdqIbYofikloF7FOuWybhYcK/WkSPyLleok9nrGJ6kzpKvwHBo5
fLhYuqqe/5dZPdyDU3SgrSj40UIV1ddQOUs3Fg0GAxlRt02cUJI=
=1sr+
-----END PGP SIGNATURE-----

--2yp7bibt7lnmiphy--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
