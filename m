From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/2] Documentation: Add sbs-manager device tree node
 documentation
Date: Mon, 25 Jul 2016 13:24:25 +0200
Message-ID: <20160725112425.GA1607@katana>
References: <1bIiDr-0004G1-0P>
 <1468349295-4935-1-git-send-email-karl-heinz@schneider-inet.de>
 <1468349295-4935-2-git-send-email-karl-heinz@schneider-inet.de>
 <20160719041432.GB1640@katana>
 <dfc8249b-08ec-888d-7a11-7c6033a1ab64@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dfc8249b-08ec-888d-7a11-7c6033a1ab64@axentia.se>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 25, 2016 at 12:33:20PM +0200, Peter Rosin wrote:
> On 2016-07-19 06:14, Wolfram Sang wrote:
> >> +batman@0a {
> >> +    compatible =3D "lltc,ltc1760";
> >> +    reg =3D <0x0a>;
> >> +    #address-cells =3D <1>;
> >> +    #size-cells =3D <0>;
> >> +
> >> +    i2c@1 {
> >> +        #address-cells =3D <1>;
> >> +        #size-cells =3D <0>;
> >=20
> > Rob, aren't those two lines inherited from above?
>=20
> I too think they are inherited, but am a bit undecided whether I want
> that fact to be explored or not, as they just happen to match. They do
> not express the same thing (it is for the i2c-mux number in the parent,
> and for the i2c device address in the children).

Ah, I see. If they don't mean the same thing, then we should be rather
safe than sorry, I guess.

> But the repetitions are indeed tedious when there are many muxed
> buses...

Yes.


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXlfbpAAoJEBQN5MwUoCm2bL0QAJ34m0eVW9QnJoeB/YbWxUOf
8hm7XF1viRXOs92kzCKJnt0g2QnY+TeL9oFScS2GYAXeeFVt7xMJ8PWVcf3hbH2G
ncqclqEEABBjtf9fAd4qveIZRdYNJPmjCmXbd1uEh6J4pEtfrzY9PYE1SCTfKOYD
8uKrfpIkpJCKI1urIotEjX47oc7s+KQ9UVBHE6HJSPCBm+I+b3A59qjDEivPsjZ9
xW/6xnU+JqL03WaQQHDeaLzU9TJmSgu5/FkbFJVitZ49FBBL/LT8wfLVXeqOcjpX
t2/pJIan8cj8HXjh/sMiCqeyhaAyW55Uo2HLwV6ywwFMKLuYVV5IFiiskpytEA3w
3tfaekAdrJZnrb+LvxEMr5GFHf2u0AkrBN4Mvn2m5/UyHY3B0vUsmPLiq8YmKZUj
+3cu4Stg52B3WFatajPjEYK5XqMH2ojY4Tg3wLw/FqFn0v4mkruFPgivdRPg31GM
ALJ0T0ORnCSw9oEydMvWbH5KISAOflkd7+DLuduBZXaFj2Xbl00r9pT1W0Ie7BBz
xp7chyv/AakpF/P2R2OoUkT8r3TkBvzelDnTBDDPSBbgO/FgfSzv2Cv9ud7QEUfM
b8pzpG/+ues3zaSfZxbXSzt0mhOrfz0tDsmqpfIyfDRXefGgPSNk6k6PwT2gts0a
3NWbINgePl4NN7srNe9Y
=U6PF
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
