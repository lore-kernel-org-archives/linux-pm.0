From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1 7/7] power: bq24190_charger: Set bq24190-battery
 device .type=unknown
Date: Thu, 23 Mar 2017 14:37:30 +0100
Message-ID: <20170323133729.jexsnpwrmbxswn26@earth>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-8-liam@networkimprov.net>
 <20170323105221.qnyw2m4cgjcb24cl@earth>
 <CAKvHMgS4oRCYRRgqo8GbeYxC5uhwgLPqe2j3ZBHQJMDBRYeA_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="odirkygnrt7zmrhr"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751249AbdCWNhf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 09:37:35 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgS4oRCYRRgqo8GbeYxC5uhwgLPqe2j3ZBHQJMDBRYeA_w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>


--odirkygnrt7zmrhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 23, 2017 at 04:31:50AM -0700, Liam Breck wrote:
>> That still leaves the health status reading, though. From
>> userspace's point-of-view this should be merged into the
>> battery device, if fuel-gauge can't provide that information.
>=20
> I think the bigger issue is that multiple sysfs devices for what is
> conceptually one power supply is awkward. With the addition of static
> battery object, we have yet another set of properties which belong to
> that supply.

The simple-battery is consumed by the fuel-gauge, so not a problem.

> A solution to this would be a core registry which allows various
> drivers to submit properties to a named supply. Properties with the
> same id (e.g. health) are OK given a tag (input-V, NTC-1, battery-V)
> to differentiate them. Duplicates would be dropped (e.g. both drivers
> submit monitored-battery stats). The result would be represented in
> sysfs as a single device, where each property would appear as a file
> or directory as necessary. And perhaps also as a file "health_summary"
> which indicates whether there's trouble below decks.

Yes, that would be the proper solution. Might become important, if
more platforms with multiple chips providing battery information
appear. Since I don't think you want to implement your suggestion,
I suggest sticking to the custom "bat_fault" sysfs property. That
should already be exposed for the charger device as far as I can
see.

-- Sebastian

--odirkygnrt7zmrhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTz5cACgkQ2O7X88g7
+pqLwA/6AounOAlf+RlbPaAcQqkpFqwjmikICa1cY3ZYWJHITASHHCf/vC7OpyxM
5gU7608vBZDQcn3BSqMR3ofDEl1TBsyUpy1TGeLL2LpBrXR6+0zZglB+tut6hE9z
dZSnQ/zVm0udY9aAzgPdt4SrTlHIudD1W7V4Z9BM/SLBFwD/AJ813PxkY9VrnIyv
i0BOwmRMXd9c1fFpwvq1ISnJ/Z+SBBOg2vUlhimuB35xobqVSqESj5LviGKhCKZ1
7aJXZZOpk6fMbKoKLE3ey8GegzwwmBQqmBK0zTUhKl5jnUR/7x7JtwvLcDH6JuLX
SbCWf4XgODFLbP+eDUup6XJs0Ru0yW+SPznSIy7PDrHo4p1iwcuyoJc9Pb+T2Rm/
My5YKrYLxMPPmKskNemWjipjPKfoxE+nv65RiflLGJpP1kB5AQzcLpv5wIuXr3K6
uffmAe1zSCP8RlP/vCvnDNpV7kyIrK2g1E9s8rbs7a5sOyxutCEeYQVyxWM+WK1Q
XYlPcw5ivXjFdqaP2IKpVSMWKIr30U/HvX8mP4Bcbc2k/KFOODey4ao9+2OxINwF
KgukTyZcwkM146k0s746wiA6jdFz5ODeY66oIBe36J3f0K1h4WKN7o3g0TersTA9
xewAb0H0Jn6lWQLrlwmwVQIGUgYGclBC+9hIuAkrYS3STVijvXg=
=7OYO
-----END PGP SIGNATURE-----

--odirkygnrt7zmrhr--
