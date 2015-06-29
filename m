From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 3/4] sched: scheduler-driven cpu frequency selection
Date: Mon, 29 Jun 2015 11:55:16 -0500
Message-ID: <20150629165516.GB32758@saruman.tx.rr.com>
References: <1435362824-26734-1-git-send-email-mturquette@linaro.org>
 <1435362824-26734-4-git-send-email-mturquette@linaro.org>
 <20150627004703.GA19347@saruman.tx.rr.com>
 <20150629164943.9112.4253@quantum>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47465 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100AbbF2Qz5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 29 Jun 2015 12:55:57 -0400
Content-Disposition: inline
In-Reply-To: <20150629164943.9112.4253@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: balbi@ti.com, peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, riel@redhat.com, efault@gmx.de, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, amit.kucheria@linaro.org, juri.lelli@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, alex.shi@linaro.org, linux-pm@vger.kernel.org, abelvesa@gmail.com, pebolle@tiscali.nl

--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 29, 2015 at 09:49:43AM -0700, Michael Turquette wrote:

<snip>

> > > +static int cpufreq_sched_stop(struct cpufreq_policy *policy)
> > > +{
> > > +     struct gov_data *gd =3D policy->governor_data;
> > > +
> > > +     if (cpufreq_driver_might_sleep()) {
> >=20
> > unnecessary curly braces.
> >=20
> > > +             kthread_stop(gd->task);
> >=20
>=20
> Thanks for the review. I'll take into account everything above.
>=20
> > should you switch back to some default OPP when this is removed ? Some
> > SoCs can't run at certain OPPs forever (thermal limitations, or whatever
> > else), might be good to switch to something considered safe.
>=20
> The above only happens when we unload the module or switch governors,
> and every governor has this characteristic.
>=20
> I do not think that open-coding a return to some default opp in every
> governor is a good solution. This sounds like something the cpufreq core
> should take care of.

indeed.

> Also, how do we know which opp is safe?

no idea, that needs to be described somehow.

--=20
balbi

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVkXh0AAoJEIaOsuA1yqREs68QAK8bMLJroQGXV1v9gT6wr6L9
M6vUsPX8WvtzeBt2PyKcPFzYAKO2KKjN8qYPFC9fvbbcu+ZMn2ORqcfMj9E1CltD
JHjdbQnm58+6I92fszbSRdlYd3K1uKwKbBiFRPO/CEwOpmZykQQq8GUUthTRBYXL
K7kSfHWUUEXn1OVhSbsSvLo6Ibuz/yVyfIqsy6SbFkY/CzeEET2JMeP4NZHKIWWl
iSmnBmvCSndvfAUCaJ1jMuBP/lr4581PjYKDQkL4535LpJE55wryRHi/i1hL0oK9
+rwdVMPeFntSFRMaiF0NO6SDT3eH3BI6zewd6FvTaT+sK143OOD2KkJI2mUisUeT
Gfl4ldB/MBnFGlyr5nBvHMHUw1aXbN87dMBotRuAJALf+HrFGZwO1ADwmz+bUdss
BNfov07iznUEZdw2Qgdo1Z13Yb7OxVtTfNpEdXj+SYqZ8p5hCWJdJgSSal0/cArC
uRJ2uBFYSdiFuKJxlvtUHbu6EWeSjbcQ6xLWBcaPpjmOBV2BYISKy11eFl3EFJnw
2l4CJ9uYdkwHelWdxuGyhv6DKHcpOpL1aZTfAjzXJl/QWgh0D6R6uGzeG5gcVfDZ
VrJF84owuIUfic3OUC4+er5evqsIYPB46hc/BFKmJQ+hJsuKPYzS4eiAYfiojQuk
CUmovdQ4+YhJOz7wg6dC
=zGvX
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
