From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 2/4] cpufreq: introduce cpufreq_driver_might_sleep
Date: Fri, 26 Jun 2015 19:48:31 -0500
Message-ID: <20150627004831.GB19347@saruman.tx.rr.com>
References: <1435362824-26734-1-git-send-email-mturquette@linaro.org>
 <1435362824-26734-3-git-send-email-mturquette@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44316 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbbF0AtN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 26 Jun 2015 20:49:13 -0400
Content-Disposition: inline
In-Reply-To: <1435362824-26734-3-git-send-email-mturquette@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, riel@redhat.com, efault@gmx.de, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, amit.kucheria@linaro.org, juri.lelli@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, alex.shi@linaro.org, linux-pm@vger.kernel.org, abelvesa@gmail.com, pebolle@tiscali.nl, "Rafael J. Wysocki" <rafael@kernel.org>

--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 26, 2015 at 04:53:42PM -0700, Michael Turquette wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 28e59a4..e5296c0 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -112,6 +112,12 @@ bool have_governor_per_policy(void)
>  }
>  EXPORT_SYMBOL_GPL(have_governor_per_policy);
> =20
> +bool cpufreq_driver_might_sleep(void)
> +{
> +	return !(cpufreq_driver->flags & CPUFREQ_DRIVER_WILL_NOT_SLEEP);
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_driver_might_sleep);
> +
>  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy)
>  {
>  	if (have_governor_per_policy())
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 2ee4888..1f2c9a1 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -157,6 +157,7 @@ u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, in=
t io_busy);
>  int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
>  int cpufreq_update_policy(unsigned int cpu);
>  bool have_governor_per_policy(void);
> +bool cpufreq_driver_might_sleep(void);
>  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
>  #else
>  static inline unsigned int cpufreq_get(unsigned int cpu)
> @@ -314,6 +315,14 @@ struct cpufreq_driver {
>   */
>  #define CPUFREQ_NEED_INITIAL_FREQ_CHECK	(1 << 5)
> =20
> +/*
> + * Set by drivers that will never block or sleep during their frequency
> + * transition. Used to indicate when it is safe to call cpufreq_driver_t=
arget
> + * from non-interruptable context. Drivers must opt-in to this flag, as =
the
> + * safe default is that they might sleep.
> + */
> +#define CPUFREQ_DRIVER_WILL_NOT_SLEEP	(1 << 6)

don't you need to update current drivers and pass this flag where
necessary ?

--=20
balbi

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVjfLfAAoJEIaOsuA1yqREWc0P/iWrcq23GsAEPEzBGwuqy767
Ut6WzwzagbK/6mMJQvRJp1luYeHO+h24H1GqekS8qVBOX+5PwSAjvzr4Kf1GMkDc
c25nM/MQsvDe0OQDk9++Ij1oopXiHf8dddIdhpLIEp3MU6cvMwuAoqInrz1PwoYd
a/k7QLy9rCkXJtFCDbSZ7OEqqpEJRQHMSWLiifAm6QX053ZWnOGVDm5g2RBD4daE
xH+5yzC6DICcVQp9vQvPwe+5Oyj49h0J1ucd1EcKVqNNV+Fxtim4vrYMbi8zkktR
KTkAbrHFH/8b3AgHTpwWQ2KvuF3nVdEjRgcaDfdU0sbxZH87hYPf3JrwnWIcrPVG
woC9JxLIa3aRXeLQBc1vhqC47spHXx6MPKM0NlrRnlnA3bRqKxfc6m1OJ49dr1sW
d+x/bPlXYAbRfv1+lNNZlo03PkoZvvtb4jhyv1VBo1lIYwGoYvg6EOARhsivKsaV
pRlJSuU71yoeLStapWFXScN7RhKBkCSLY8cfZcHgIqJgm4NBcBqL+h0C04cHohhW
zMy3t/5Pi87S6JFcjeSfQvRsi+S7fZ+yTN87BK0tAn1vVro2ooMb7T0xZABxkK+z
4OA99NwE9ZSoX86Ubn4Y+XG0U1JtUyee8z7O7Mqolw6lsFtffApEaseO2cNhR4GE
RTpYzpDucaHaR1IPdUS/
=C0Is
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
