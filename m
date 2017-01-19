From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: reset: Add MAX77620 support
Date: Fri, 20 Jan 2017 00:00:36 +0100
Message-ID: <20170119230036.sjfqvqxgxutis6xs@earth>
References: <20170112161507.23774-1-thierry.reding@gmail.com>
 <20170113034425.7ttvc73aewtbitrk@earth>
 <20170119122357.GF30182@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wtr4xualr7kxphqk"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751478AbdASXDQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Jan 2017 18:03:16 -0500
Content-Disposition: inline
In-Reply-To: <20170119122357.GF30182@ulmo.ba.sec>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Martin Michlmayr <tbm@cyrius.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chaitanya Bandi <bandik@nvidia.com>, Guenter Roeck <linux@roeck-us.net>


--wtr4xualr7kxphqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thierry,

> > > [...]
> >
> > Please use register_restart_handler() instead. It has support for
> > priorities, is not arm specific and properly supports unregistering
> > (some handler with lower priority will take over). You can check
> > gpio-restart as an example for the API.
> >=20
> > If you have some other arm_pm_restart handler (those are tried first)
> > I suggest to convert that to the restart handler framework. Actually
> > it may be a good idea to convert all of them and drop arm_pm_restart,
> > since there are only 4 left:
> >=20
> > $ git grep "arm_pm_restart =3D"
> > drivers/firmware/psci.c:        arm_pm_restart =3D psci_sys_reset;
> > arch/arm/mach-prima2/rstc.c:    arm_pm_restart =3D sirfsoc_restart;
> > arch/arm/xen/enlighten.c:       arm_pm_restart =3D xen_restart;
> > arch/arm/kernel/setup.c:                arm_pm_restart =3D mdesc->resta=
rt;
> >=20
> > The first 3 should be easy to update and the last one could
> > be solved by registering a wrapper function as restart handler,
> > which calls mdesc->restart().
>=20
> I remember this not being the first time that this confuses me. And from
> looking around a little it seems like I'm not the only one.
>=20
> Do you know if there's ever been any attempts to formalize all of this
> by adding some sort of framework for this? That way some of the
> confusion may be removed and architecture-specific bits could be
> eliminated more easily.

We have a framework for restart handlers, which has been written
by Guenter Roeck [0] in 2014. You just have to call register_restart_handle=
r()
during probe and unregister_restart_handler() during removal of
your reboot driver. All reboot drivers in drivers/power/reset use
that framework.

The restart handlers are invoked by calling do_kernel_restart()
based on their configured priority. That function is called by
the architecture's machine_restart() function. It's currently
used by mips, ppc, arm & arm64 as far as I can see. ARM's
implementation looks like this:

if (arm_pm_restart)
	arm_pm_restart()
else
	do_kernel_restart() /* reboot handler framework */

No such thing exists for poweroff. Guenter also wrote something for
that [1], but Linus intervened [2]. Anyways, pm_power_off is at
least architecture independent.

[0] https://lwn.net/Articles/605298/
[1] https://lwn.net/Articles/617345/
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/351369.=
html

-- Sebastian

--wtr4xualr7kxphqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliBRREACgkQ2O7X88g7
+ppSlRAAk2fH/BizWXxslN/tveoCYxVnkbXYggvqszyNllOwznj04VLLzOHobdzw
QITLZiAeYUwMHnj0N8n84yfl7c10cUIniWoyt3fvf5YjCuLMQIXYgzm6SZbUWsKz
red1n08l76S6pf6/H9zJ3CmxZcRpsho3BC9LXFmSFA5euru2ypXKzean5zDzqHpv
c+ux6LCUoeX0gG/gXZG2ACT71AiMf8HjjmsS1Dn7V3YQBw5MqcOaZ1wH61tVl3pb
uPFB5fQA1XiNgl4tlaMriBTYSaw/m6+G7zjxYzBmi0adAtu0MZ3LQBHJtyDBUSeH
d3KVSPpQk4QQQnSsOCKvyCgWOdqE20B9a2XhURho2bobKV7MvWYtFmIjr9V/fXRo
5d2I4rs4MZbS5zpLKbiS3q+aV10FBzyrjHkjOrqhgyB82TQp5ti0afLTS3bObWx0
njemo5abijceqjSWRWR3bAxLRuWi0ZUs86m/11UBjWrIAzwP04GQ8W+m6SvqceSr
biU8yDj0Cl4KvclsrgxadbplJxn3uGm6Vx/rN5691TGhXkBXS0UEkNQ5UfETKUNj
OkKr4d2QJPBaikY8MaAewGn7Nqq5fnTdYVF1EHCApDDFQiYR/ZOpXnK+TUimTQ1H
wW7IzSXg+zejCzLV/sWKTXGphyXIDqVRGpzqPAh6nFnF1uSLmo4=
=ATpJ
-----END PGP SIGNATURE-----

--wtr4xualr7kxphqk--
