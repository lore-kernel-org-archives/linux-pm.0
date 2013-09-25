From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 15/21] cpuidle: free all state kobjects from cpuidle_free_state_kobj()
Date: Thu, 26 Sep 2013 00:09:26 +0200
Message-ID: <52435F16.5080806@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org> <503b7472308007b4c233b33d19f5a54c138212e7.1379779777.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:51810 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab3IYWJ3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2013 18:09:29 -0400
Received: by mail-we0-f172.google.com with SMTP id w61so305395wes.17
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 15:09:28 -0700 (PDT)
In-Reply-To: <503b7472308007b4c233b33d19f5a54c138212e7.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/22/2013 03:21 AM, Viresh Kumar wrote:
> Loop for states is currently present on callers side and so is replic=
ated at
> several places. It would be better to move that inside cpuidle_free_s=
tate_kobj()
> instead.
>=20
> This patch does it.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/cpuidle/sysfs.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index e918b6d..ade31a9 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -378,12 +378,17 @@ static struct kobj_type ktype_state_cpuidle =3D=
 {
>  	.release =3D cpuidle_state_sysfs_release,
>  };
> =20
> -static inline void cpuidle_free_state_kobj(struct cpuidle_device *de=
vice, int i)
> +static inline void cpuidle_free_state_kobj(struct cpuidle_device *de=
vice,
> +		int count)
>  {
> -	kobject_put(&device->kobjs[i]->kobj);
> -	wait_for_completion(&device->kobjs[i]->kobj_unregister);
> -	kfree(device->kobjs[i]);
> -	device->kobjs[i] =3D NULL;
> +	int i;
> +
> +	for (i =3D 0; i < count; i++) {
> +		kobject_put(&device->kobjs[i]->kobj);
> +		wait_for_completion(&device->kobjs[i]->kobj_unregister);
> +		kfree(device->kobjs[i]);
> +		device->kobjs[i] =3D NULL;
> +	}
>  }
> =20
>  /**
> @@ -419,8 +424,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle=
_device *device)
>  	return 0;
> =20
>  error_state:
> -	for (i =3D i - 1; i >=3D 0; i--)
> -		cpuidle_free_state_kobj(device, i);
> +	cpuidle_free_state_kobj(device, i);
>  	return ret;
>  }
> =20
> @@ -430,10 +434,7 @@ error_state:
>   */
>  static void cpuidle_remove_state_sysfs(struct cpuidle_device *device=
)
>  {
> -	int i;
> -
> -	for (i =3D 0; i < device->state_count; i++)
> -		cpuidle_free_state_kobj(device, i);
> +	cpuidle_free_state_kobj(device, device->state_count);
>  }
> =20
>  #ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

