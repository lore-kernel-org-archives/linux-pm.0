From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH Resend] cpufreq: remove sysfs files for CPU which failed to come back after resume
Date: Tue, 24 Dec 2013 01:35:20 +0100
Message-ID: <1614824.4yERnS53EQ@vostro.rjw.lan>
References: <610b63b7594e5cd364c498f60e69b9e174db9257.1387554926.git.viresh.kumar@linaro.org> <87pponx07s.fsf@nemi.mork.no> <52B85AA4.6070609@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52B85AA4.6070609@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>
Cc: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, December 23, 2013 09:15:40 PM viresh kumar wrote:
> On Monday 23 December 2013 05:12 PM, Bj=C3=B8rn Mork wrote:
> > That would be great.  This could be just me.  I am quite good at
> > breaking stuff.
>=20
> No its not you. While we tried to make sure everything is preserved,
> few special things still stayed out :)
>=20
> And they are solved with this patch, log should be good enough to giv=
e
> proper reasoning:
>=20
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Mon, 23 Dec 2013 20:51:54 +0530
> Subject: [PATCH] cpufreq: preserve user_policy across suspend/resume
>=20
> In __cpufreq_add_dev() we are reinitializing user_policy with default=
 values and
> hence would loose values of user_policy.{min|max|policy|governor} fie=
lds.
>=20
> Preserve them by not overriding these for suspend/resume.

OK

Can you please combine this with the patch you sent previously (if that=
 one
is still necessary) and resubmit with a new subject?

Rafael


> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 16d7b4a..c5c3dac 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -839,9 +839,6 @@ static void cpufreq_init_policy(struct cpufreq_po=
licy *policy)
>=20
>  	/* set default policy */
>  	ret =3D cpufreq_set_policy(policy, &new_policy);
> -	policy->user_policy.policy =3D policy->policy;
> -	policy->user_policy.governor =3D policy->governor;
> -
>  	if (ret) {
>  		pr_debug("setting policy failed\n");
>  		if (cpufreq_driver->exit)
> @@ -1069,8 +1066,10 @@ static int __cpufreq_add_dev(struct device *de=
v, struct subsys_interface *sif,
>  	 */
>  	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>=20
> -	policy->user_policy.min =3D policy->min;
> -	policy->user_policy.max =3D policy->max;
> +	if (!frozen) {
> +		policy->user_policy.min =3D policy->min;
> +		policy->user_policy.max =3D policy->max;
> +	}
>=20
>  	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  				     CPUFREQ_START, policy);
> @@ -1101,6 +1100,11 @@ static int __cpufreq_add_dev(struct device *de=
v, struct subsys_interface *sif,
>=20
>  	cpufreq_init_policy(policy);
>=20
> +	if (!frozen) {
> +		policy->user_policy.policy =3D policy->policy;
> +		policy->user_policy.governor =3D policy->governor;
> +	}
> +
>  	kobject_uevent(&policy->kobj, KOBJ_ADD);
>  	up_read(&cpufreq_rwsem);
>=20
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
