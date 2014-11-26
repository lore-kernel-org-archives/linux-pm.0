From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 3/7] cpufreq: Introduce ->usable() callback for cpufreq
 drivers
Date: Wed, 26 Nov 2014 13:58:33 -0400
Message-ID: <20141126175829.GD1826@developer>
References: <cover.1416980447.git.viresh.kumar@linaro.org>
 <95b84bb8af3d4d9667a79db520cfa37d9444d75b.1416980448.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:46786 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbaKZR6l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 12:58:41 -0500
Received: by mail-qg0-f51.google.com with SMTP id l89so2434587qgf.10
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 09:58:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <95b84bb8af3d4d9667a79db520cfa37d9444d75b.1416980448.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, l.majewski@samsung.com


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2014 at 11:22:58AM +0530, Viresh Kumar wrote:
> Currently there is no callback for cpufreq drivers which is called once t=
he
> policy is ready to be used. There are some requirements where such a call=
back is
> required.
>=20
> One of them is registering a cooling device with the help of
> of_cpufreq_cooling_register(). This routine tries to get 'struct cpufreq_=
policy'
> for CPUs which isn't yet initialed at the time ->init() is called and so =
we face
> issues while registering the cooling device.
>=20
> Because we can't register cooling device from ->init(), we need a callbac=
k that
> is called after the policy is ready to be used and hence we introduce ->u=
sable()
> callback.
>=20

Reviewed-by: Eduardo Valentin <edubezval@gmail.com>
Tested-by: Eduardo Valentin <edubezval@gmail.com>

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 5 +++++
>  include/linux/cpufreq.h   | 4 ++++
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index de2c3e1..4fb95b9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1285,8 +1285,13 @@ static int __cpufreq_add_dev(struct device *dev, s=
truct subsys_interface *sif)
>  	up_write(&policy->rwsem);
> =20
>  	kobject_uevent(&policy->kobj, KOBJ_ADD);
> +
>  	up_read(&cpufreq_rwsem);
> =20
> +	/* Callback for handling stuff after policy is ready */
> +	if (cpufreq_driver->usable)
> +		cpufreq_driver->usable(policy);
> +
>  	pr_debug("initialization complete\n");
> =20
>  	return 0;
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index db3c130..4795c0b 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -267,6 +267,10 @@ struct cpufreq_driver {
>  	void		(*stop_cpu)(struct cpufreq_policy *policy);
>  	int		(*suspend)(struct cpufreq_policy *policy);
>  	int		(*resume)(struct cpufreq_policy *policy);
> +
> +	/* Will be called after the driver is fully initialized */
> +	void		(*usable)(struct cpufreq_policy *policy);
> +
>  	struct freq_attr **attr;
> =20
>  	/* platform specific boost support code */
> --=20
> 2.0.3.693.g996b0fd
>=20

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdhS8AAoJEMLUO4d9pOJWOI0H/Res0PNvjeskDm55W7V7+gqj
cukGkfFigbYHXkgpm3+FnxOcar18Am/WBJEFwa81ZgnlWVhpu9IiJ+hGeULeFXFL
DeQqdDX7LRDHTK965V2b8NbPkO+r65v3O9JpAe1A1uGEi2BCCiqUlMq3HR6xaG+b
PtvzTfGT/5B+hUBQRkME45iEdxFASoNQu0ZCyc6Lb5/5vWPN0m895tw9zcR5tfdN
7I27SoGvr/JydTlO0pISXmNpTJ4Arqb2Mq+lJ2V0Wr0+SlvwA7kgIpGDYKc5kVcu
HMgnbS8iXy2wQsWRcxdJpea5UuNpTP4BwiKCLd9MhEUM3BiT0/fGKOTocKEN4vM=
=Pbrn
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
