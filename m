From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 1/2] thermal: IPA: add new divvy-up algorithm
Date: Tue, 23 May 2017 20:40:57 -0700
Message-ID: <20170524034056.GA2891@localhost.localdomain>
References: <1494575248-4166-1-git-send-email-lukasz.luba@arm.com>
 <1494575248-4166-2-git-send-email-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36753 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761881AbdEXDlC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 23:41:02 -0400
Received: by mail-pg0-f68.google.com with SMTP id h64so15487565pge.3
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2017 20:41:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1494575248-4166-2-git-send-email-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, javi.merino@kernel.org, rui.zhang@intel.com


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Sorry for the late answer.

On Fri, May 12, 2017 at 08:47:27AM +0100, Lukasz Luba wrote:
> The IPA algorithm grants actors with some extra power when the following
> conditions are meet:
> - there is at least one actor which got more power than it's max_power
>   value,
> - there is at least one actor which is capable to receive some more power
>   (it's requested power is below max_power value). The IPA grants this
> extra power to all capable actors.
>=20
> Before this commit the algorithm did not take into account the actor's ty=
pe
> (cpu or devfreq), so the extra power was shared fairly to all capable
> actors. Therefore, the extra power can be granted to some actor which is
> not related to this higher computation request.
>=20
> Example related to the previous algorithm: Let's focus on ARM big.LITTLE
> platform which has two cooling devices (one per cluster). If the big CPU
> cluster gets more power that it can consume, the power above the limit is
> cut from the big and spread between other actors.  In this case even the
> GPU gets some extra power, but it does not need it and cannot help to
> offload the big CPU.  The CPU overall performance suffers.
>=20
> This new algorithm takes into account the actor's type and constructs
> families/groups - which are containers for actors of the same type: CPUfr=
eq
> or devfreq. Currently it supports only these two families/groups.  The
> families/groups are created based on cooling device name (string matching=
).
>=20
> The algorithm calculates extra power in two phases: Phase 1: Calculates t=
he
> power budget for each group (CPU or devfreq devices).  Phase 2: The extra
> power in each family/group is shared to the same actor's family/group
> members.  Phase 3: If there is still some extra power (left because the
> family/group actors were not able to consume it), it is shared fairly to
> all of the capable actors in the system (so in this round, the same idea =
to
> the former algorithm).
>=20
> Example for current proposed algorithm: If the 'cpu type' actor gives some
> extra power to the 'cpu type' family/group pool, it is shared fairly among
> capable actors in this family/group ('cpu type'). If some extra power lef=
t,
> it will be granted to 'devfreq type' actors which are capable to consume
> it.
>=20

This is cool, but I would appreciate some data to backup this change.

Besides, looks like we are adding complexity here with stuff hardcoded
inside the kernel without letting the user know what is going on
behind the scenes. Meaning, I would expect this to be shown in sysfs
somehow.

Besides, can this be optional?

Are you sure the grouped/container approach is always better on all
workloads when compared to the fair / current one?

Now, other aspect of this is, now with an almost two level PID,
how do we make sure this stuff is working? :-)

> Suggested-by: Alex Wang <alex.wang@spreadtrum.com>
> Suggested-by: Xin Wang <Xin.Wang@arm.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/power_allocator.c | 175 ++++++++++++++++++++++++++++++++=
------
>  1 file changed, 151 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_al=
locator.c
> index b4d3116..f9e3d3c 100644
> --- a/drivers/thermal/power_allocator.c
> +++ b/drivers/thermal/power_allocator.c
> @@ -30,6 +30,18 @@
>  #define int_to_frac(x) ((x) << FRAC_BITS)
>  #define frac_to_int(x) ((x) >> FRAC_BITS)
> =20
> +enum thermal_actor_type {
> +	OTHER_CDEV =3D 0,
> +	CPUFREQ_CDEV,
> +	DEVFREQ_CDEV,
> +	NUM_CDEV_TYPES
> +};
> +

I am not sure it is a good idea to hard code knowledge of cooling
devices on governors. If I am not mistaken, this is the first change
doing this move...

> +struct thermal_actor {
> +	struct thermal_cooling_device *cdev;
> +	enum thermal_actor_type type;
> +};
> +
>  /**
>   * mul_frac() - multiply two fixed-point numbers
>   * @x:	first multiplicand
> @@ -258,6 +270,104 @@ static u32 pid_controller(struct thermal_zone_devic=
e *tz,
>  	return power_range;
>  }
> =20
> +
> +/**
> + * siblings_grants() - splits the extra power
> + * @max_power:		each actor's maximum available power
> + * @granted_power:	each actor's granted power which is the output array
> + *			and will be increased here
> + * @avail_room:		each actor's capability to consume some more power
> + * @spare_power:	each actor's power value above it's max_power limit,
> + *			which will be consumed by other actors
> + * @num_actors:		size of the @avail_room, @spare_power, @max_power and
> + *			@granted_power's array
> + * @thermal_actor:	array of filtered actors which will be involved in
> + *			this process
> + *
> + * The algorithm calculates the total extra power available per actor's =
family
> + * and splits this power equally between the family members.
> + * The algorithm distinguishes actors based on their names and adds them=
 to the
> + * proper family. Each family has its own sum of available power to cons=
ume
> + * (which can be equal 0).
> + * When the family sharing is done and some power still is available, it=
 goes
> + * to generic power sum, which will be split fairly between all capable =
actors.
> + */
> +static void siblings_grants(struct thermal_zone_device *tz,
> +			u32 *max_power, u32 *granted_power,
> +			u32 *avail_room, u32 *spare_power,
> +			int num_actors,	struct thermal_actor *thermal_actor)
> +{
> +	struct thermal_cooling_device *cdev;
> +	int i;
> +	const char *devfreq_name =3D "thermal-devfreq-";
> +	const char *cpufreq_name =3D "thermal-cpufreq-";

Oww... not sure I like this. :-( Can we derive this somehow dynamically?

> +	u64 sum_spare_power[NUM_CDEV_TYPES] =3D {0};
> +	u64 sum_avail_room[NUM_CDEV_TYPES] =3D {0};
> +	u64 min_sum_extra_power =3D 0;
> +	enum thermal_actor_type type;
> +	u64 rest_avail_room =3D 0;
> +	u64 total_spare_power =3D 0;
> +	u64 total_avail_room =3D 0;
> +	unsigned int rounding_gap =3D num_actors - 1;
> +
> +	/* Group the thermal actors and calculate power budget
=09
	/*
	 * minor:=20
	 * follow kernel coding style here
	 */

> +	 * for each family.
> +	 */
> +	for (i =3D 0; i < num_actors; i++) {
> +		cdev =3D thermal_actor[i].cdev;
> +		if (!cdev)
> +			continue;
> +		if (strstarts(cdev->type, cpufreq_name))
> +			type =3D CPUFREQ_CDEV;
> +		else if (strstarts(cdev->type, devfreq_name))
> +			type =3D DEVFREQ_CDEV;
> +		else
> +			type =3D OTHER_CDEV;
> +
> +		thermal_actor[i].type =3D type;
> +		sum_spare_power[type] +=3D spare_power[i];
> +		sum_avail_room[type] +=3D avail_room[i];
> +		total_spare_power +=3D spare_power[i];
> +		total_avail_room +=3D avail_room[i];
> +	}
> +
> +	/* Share the extra power inside the same family. */
> +	for (i =3D 0; i < num_actors; i++) {
> +		u64 power;
> +
> +		type =3D thermal_actor[i].type;
> +
> +		if (sum_avail_room[type] && avail_room[i]) {
> +			min_sum_extra_power =3D min(sum_spare_power[type],
> +						  sum_avail_room[type]);
> +			power =3D avail_room[i] * min_sum_extra_power;
> +			power =3D div_u64(power, sum_avail_room[type]);
> +			granted_power[i] +=3D power;
> +			avail_room[i] -=3D power;
> +			total_spare_power -=3D power;
> +			rest_avail_room +=3D avail_room[i];
> +		}
> +	}
> +
> +	/* Share the rest (if any) of power between all actors,
> +	 *  no mater the group they belong to.
> +	 */
> +	if (rest_avail_room && total_spare_power > rounding_gap) {
> +		u32 min_extra_power;
> +		u64 power;
> +
> +		min_extra_power =3D min(total_spare_power, rest_avail_room);
> +		for (i =3D 0; i < num_actors; i++) {
> +			if (!avail_room[i])
> +				continue;
> +
> +			power =3D avail_room[i] * min_extra_power;
> +			power =3D div_u64(power, rest_avail_room);
> +			granted_power[i] +=3D power;
> +		}
> +	}
> +}
> +
>  /**
>   * divvy_up_power() - divvy the allocated power between the actors
>   * @req_power:	each actor's requested power
> @@ -266,9 +376,12 @@ static u32 pid_controller(struct thermal_zone_device=
 *tz,
>   * @total_req_power: sum of @req_power
>   * @power_range:	total allocated power
>   * @granted_power:	output array: each actor's granted power
> - * @extra_actor_power:	an appropriately sized array to be used in the
> - *			function as temporary storage of the extra power given
> - *			to the actors
> + * @avail_room:		an appropriately sized array to be used in the
> + *			function as temporary storage of the available room for
> + *			extra power for each actor
> + * @spare_power:	an appropriately sized array to be used in the
> + *			function as temporary storage of the spare power
> + *			for each actor, which can be taken by some other actors
>   *
>   * This function divides the total allocated power (@power_range)
>   * fairly between the actors.  It first tries to give each actor a
> @@ -285,12 +398,16 @@ static u32 pid_controller(struct thermal_zone_devic=
e *tz,
>   * Granted power for each actor is written to @granted_power, which
>   * should've been allocated by the calling function.
>   */
> -static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actor=
s,
> +static void divvy_up_power(struct thermal_zone_device *tz, u32 *req_powe=
r,
> +			   u32 *max_power, int num_actors,
>  			   u32 total_req_power, u32 power_range,
> -			   u32 *granted_power, u32 *extra_actor_power)
> +			   u32 *granted_power, u32 *avail_room,
> +			   u32 *spare_power,
> +			   struct thermal_actor *thermal_actor)
>  {
> -	u32 extra_power, capped_extra_power;
>  	int i;
> +	u64 sum_avail_room =3D 0;
> +	u64 sum_spare_power =3D 0;
> =20
>  	/*
>  	 * Prevent division by 0 if none of the actors request power.
> @@ -298,8 +415,6 @@ static void divvy_up_power(u32 *req_power, u32 *max_p=
ower, int num_actors,
>  	if (!total_req_power)
>  		total_req_power =3D 1;
> =20
> -	capped_extra_power =3D 0;
> -	extra_power =3D 0;
>  	for (i =3D 0; i < num_actors; i++) {
>  		u64 req_range =3D (u64)req_power[i] * power_range;
> =20
> @@ -307,26 +422,25 @@ static void divvy_up_power(u32 *req_power, u32 *max=
_power, int num_actors,
>  							 total_req_power);
> =20
>  		if (granted_power[i] > max_power[i]) {
> -			extra_power +=3D granted_power[i] - max_power[i];
> +			spare_power[i] =3D granted_power[i] - max_power[i];
> +			sum_spare_power +=3D spare_power[i];
>  			granted_power[i] =3D max_power[i];
>  		}
> =20
> -		extra_actor_power[i] =3D max_power[i] - granted_power[i];
> -		capped_extra_power +=3D extra_actor_power[i];
> +		avail_room[i] =3D max_power[i] - granted_power[i];
> +		sum_avail_room +=3D avail_room[i];
>  	}
> =20
> -	if (!extra_power)
> +	if (!sum_avail_room || !sum_spare_power)
>  		return;
> =20
>  	/*
>  	 * Re-divvy the reclaimed extra among actors based on
>  	 * how far they are from the max
>  	 */
> -	extra_power =3D min(extra_power, capped_extra_power);
> -	if (capped_extra_power > 0)
> -		for (i =3D 0; i < num_actors; i++)
> -			granted_power[i] +=3D (extra_actor_power[i] *
> -					extra_power) / capped_extra_power;
> +	siblings_grants(tz, max_power, granted_power, avail_room,
> +			spare_power, num_actors, thermal_actor);
> +
>  }
> =20
>  static int allocate_power(struct thermal_zone_device *tz,
> @@ -334,12 +448,13 @@ static int allocate_power(struct thermal_zone_devic=
e *tz,
>  {
>  	struct thermal_instance *instance;
>  	struct power_allocator_params *params =3D tz->governor_data;
> -	u32 *req_power, *max_power, *granted_power, *extra_actor_power;
> -	u32 *weighted_req_power;
> +	u32 *req_power, *max_power, *granted_power, *avail_room;
> +	u32 *weighted_req_power, *spare_power;
>  	u32 total_req_power, max_allocatable_power, total_weighted_req_power;
>  	u32 total_granted_power, power_range;
>  	int i, num_actors, total_weight, ret =3D 0;
>  	int trip_max_desired_temperature =3D params->trip_max_desired_temperatu=
re;
> +	struct thermal_actor *thermal_actor;
> =20
>  	mutex_lock(&tz->lock);
> =20
> @@ -358,6 +473,13 @@ static int allocate_power(struct thermal_zone_device=
 *tz,
>  		goto unlock;
>  	}
> =20
> +	thermal_actor =3D kcalloc(num_actors, sizeof(struct thermal_actor),
> +				GFP_KERNEL);
> +	if (!thermal_actor) {
> +		ret =3D -ENOMEM;
> +		goto unlock;
> +	}
> +
>  	/*
>  	 * We need to allocate five arrays of the same size:
>  	 * req_power, max_power, granted_power, extra_actor_power and
> @@ -367,18 +489,21 @@ static int allocate_power(struct thermal_zone_devic=
e *tz,
>  	 */
>  	BUILD_BUG_ON(sizeof(*req_power) !=3D sizeof(*max_power));
>  	BUILD_BUG_ON(sizeof(*req_power) !=3D sizeof(*granted_power));
> -	BUILD_BUG_ON(sizeof(*req_power) !=3D sizeof(*extra_actor_power));
> +	BUILD_BUG_ON(sizeof(*req_power) !=3D sizeof(*avail_room));
>  	BUILD_BUG_ON(sizeof(*req_power) !=3D sizeof(*weighted_req_power));
> -	req_power =3D kcalloc(num_actors * 5, sizeof(*req_power), GFP_KERNEL);
> +	BUILD_BUG_ON(sizeof(*req_power) !=3D sizeof(*spare_power));
> +	req_power =3D kzalloc(num_actors * 6 * sizeof(*req_power), GFP_KERNEL);
>  	if (!req_power) {
>  		ret =3D -ENOMEM;
> +		kfree(thermal_actor);
>  		goto unlock;
>  	}
> =20
>  	max_power =3D &req_power[num_actors];
>  	granted_power =3D &req_power[2 * num_actors];
> -	extra_actor_power =3D &req_power[3 * num_actors];
> +	avail_room =3D &req_power[3 * num_actors];
>  	weighted_req_power =3D &req_power[4 * num_actors];
> +	spare_power =3D &req_power[5 * num_actors];
> =20
>  	i =3D 0;
>  	total_weighted_req_power =3D 0;
> @@ -412,14 +537,15 @@ static int allocate_power(struct thermal_zone_devic=
e *tz,
>  		max_allocatable_power +=3D max_power[i];
>  		total_weighted_req_power +=3D weighted_req_power[i];
> =20
> +		thermal_actor[i].cdev =3D cdev;
>  		i++;
>  	}
> =20
>  	power_range =3D pid_controller(tz, control_temp, max_allocatable_power);
> =20
> -	divvy_up_power(weighted_req_power, max_power, num_actors,
> +	divvy_up_power(tz, weighted_req_power, max_power, num_actors,
>  		       total_weighted_req_power, power_range, granted_power,
> -		       extra_actor_power);
> +		       avail_room, spare_power, thermal_actor);
> =20
>  	total_granted_power =3D 0;
>  	i =3D 0;
> @@ -444,6 +570,7 @@ static int allocate_power(struct thermal_zone_device =
*tz,
>  				      control_temp - tz->temperature);
> =20
>  	kfree(req_power);
> +	kfree(thermal_actor);
>  unlock:
>  	mutex_unlock(&tz->lock);
> =20


Overall, I see what you are doing. But I am still not really convinced
we need this extra complexity unless you provide me with some use case
(with power/thermal data) that shows this is really needed. I am just
trying to understand if this is a corner case and we sacrificing the
regular cases, or if this is really improving overall.

Besides, you need a better way to categorize your actors. Hacking
hard-coded in the governor does not seam to scale.

> --=20
> 1.9.1
>=20

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJQDBAAoJEA6VkvSQfF5T0eAQAIHdyN0+gm09VUuJkxLlB5gT
2l8fsZfsC0od6Hq5rZ+3eMtRQIT00DufumXr7O8g7GxaJqlH1hm5WW/8+F4IBWXm
aS5kFsvmFil2+yjLi/rvW5sS5FIH5RlWrfIOSIDdRJsnLstCfdgs1OdvLeyOw4WB
ecsJaGWd0a854TDdWPk0XXBDhYIpYrkoSk7FvmJH9JDdwJ0marRHS80IRLmpRGpI
/rE9h/TuxLygn52BOvNG0wCEnn48qn98o/uBo5aGhtWHNjwIMtCs2DQfw3vvE92s
eGm9qp52vFnu+MSJA21cyxjPKuB7n499YlQ7dnEaHmCILB2A0DKjwg+NOf+vJjnx
KKf2JVVB+Gy1ambUgt4u85RlVqz9IjLzdHVGWFQYa5fTFjaHAKvj1twDN3ucmqp+
6gwy6G/AqcqVuJ96YVfC+E2cdcTEgU/VObhSB7lRoC+SVHwRJnAGMdccI1VPx1pL
OuNdLgb2JFq3lgowAQA/Adc8yVqWSqtXnV8Tta6Yl3F9jSgkjquiZwT+xm+16LWh
ULuhEjwi3+ZpdALUbawvYf0SAMq+C0AXbkjdCGNdu/c54UI3C2vcH6UffEjK2qrV
XEJDbKXOPEIs4rsu4cJvyDoyQ9N3JvofOhwAMZZtSnVzRW1QAoDId04tvrhlMW8T
nl+mq+L3tFq5Om4h+FZo
=Ty5Q
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
