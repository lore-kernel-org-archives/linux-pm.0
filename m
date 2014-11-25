From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] cpufreq-dt: register cooling device after validating
 cpufreq table
Date: Mon, 24 Nov 2014 21:44:37 -0400
Message-ID: <20141125014435.GA28906@developer>
References: <b4a56cad08c5ef701cf268881697caabe5229994.1416826729.git.viresh.kumar@linaro.org>
 <20141124181049.GB1449@developer>
 <CAKohpokF8qFUz-bmKT61L879L60GYzsc3X3BRHofLYWAdHa3rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:47392 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaKYNqs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 08:46:48 -0500
Received: by mail-qc0-f180.google.com with SMTP id i8so386624qcq.25
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 05:46:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKohpokF8qFUz-bmKT61L879L60GYzsc3X3BRHofLYWAdHa3rg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Viresh,

On Tue, Nov 25, 2014 at 04:27:44PM +0530, Viresh Kumar wrote:
> On 24 November 2014 at 23:40, Eduardo Valentin <edubezval@gmail.com> wrot=
e:
> > Is it possible to have this registration only when we have a
> > cpufreq driver up and running? The reasoning is that only after we have
> > a way to control cpu frequencies, it makes sense to have the cpu_cooling
> > device.
> >
> > I am planing to have the following check in the cpu cooling code:
> >         if (!cpufreq_get_current_driver()) {
> >                 dev_dbg(bgp->dev, "no cpufreq driver yet\n");
> >                 return -EPROBE_DEFER;
> >         }
> >
> > that is the way I think of checking if the cpufreq layer is ready to
> > have a cpu cooling on top of it. Currently, thermal drivers check this
> > before calling cpu cooling registration. But instead of having this
> > check in every driver, I would like to move it to cpu cooling.
> >
> > However, for cpufreq-dt, the registration currently happens in the
> > init phase, not in probe, so cpufreq driver is not registered, and thus
> > the check won't work.
>=20
> This is how the phases are present in cpufreq drivers:
> -> platform_init
>     -> probe()
>         ->cpufreq_driver->init()

You are right! I got confused because even with your patch, the
sequencing is not working. Looking to that behavior I, somehow, thought
the _init function in cpufreq-dt was about init() calls. But in fact, it
is driver initialization callback.


>=20
> And the cooling device is registered in cpufreq_driver->init() and by
> the time ->init() is called, cpufreq_driver is valid.

However, by the time of ->init() the cpufreq_driver is not really ready.
Or at least, the cpufreq layer is not ready. A call to

cpufreq_frequency_get_table()

for instance, it is not working. The reasoning is because
cpufreq_add_dev() is still not finalized by the time driver->init() is
called. Meaning, the policy cannot be fetch because the cpu masks have
not been set by that time. More important, in order to fetch the cpufreq
table we would need to have the cpufreq_cpu_data properly initialized
per cpu. In other words, when we call driver->init() that happens
before the following code:
	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);

	if (!recover_policy) {
		policy->user_policy.min =3D policy->min;
		policy->user_policy.max =3D
		policy->max;
	}

	down_write(&policy->rwsem);
	write_lock_irqsave(&cpufreq_driver_lock, flags);
	for_each_cpu(j, policy->cpus)
		per_cpu(cpufreq_cpu_data, j) =3D policy;
	write_unlock_irqrestore(&cpufreq_driver_lock, flags);

The thing is, with current code:
cpufreq_add_dev()
	-> cpufreq-dt->init()=20
		-> of_cpufreq_cooling_register()
			-> cpufreq_frequency_get_table()
				-> returns NULL;

Returns invalid data because it is not initialized yet.

The cpufreq-dt would need to add the of based cpufreq cooling only when
cpufreq layer is ready. Any other better cpufreq driver callback to add
the cpu cooling?

We could sort this out by polling in thermal layer for the cpufreq table
until it gets ready, but I believe that would be a dirty hack.

Cheers,

Eduardo Valentin

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc971AAoJEMLUO4d9pOJWRS0H/i5ADvxuqol45e8DTcfP6E63
Ms5lwt4Zgldj0PauBOBxv9Z3b8sU7sMGnow+fOIeG+uIN0FxnNocB21rxO/RzAz/
PFOVY8u5E+/3/8rBhzrLo+gVE0PLQwKDBv8iy9RMTIw/EVonZfTs3H0HTScO5Nwy
DqfHxwcwLsGywVYW346G5VkJlKSNft1GOYs7mm4DflN6gA+9R9rJ8PLm2xHdV4mC
Gehq463EdE4NgbC6EMRjMKsfuhwn390zQ/MSnm0p9zaXDI4bFb45QmwE9X3ad8lS
cQ29TpJN16JAcYbgkHi40uAxngSCXMieaxceoMYPyUKqfyOIwlZkp/WEOEH2nlk=
=FP7g
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
