From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: Fix: Bind Cooling Device Weight
Date: Tue, 6 Jan 2015 14:37:03 -0400
Message-ID: <20150106183701.GA11119@developer>
References: <5492C634.5030604@arm.com>
 <20141218134334.GA6276@developer>
 <54930473.2060901@arm.com>
 <1419218610.19619.10.camel@rzhang1-toshiba>
 <5498488A.6080209@arm.com>
 <20150105213106.GB31536@developer>
 <54AC0F7C.9060606@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:45706 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191AbbAFShL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 13:37:11 -0500
Received: by mail-vc0-f171.google.com with SMTP id hy4so9266718vcb.16
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2015 10:37:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54AC0F7C.9060606@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kapileshwar Singh <kapileshwar.singh@arm.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Javi Merino <Javi.Merino@arm.com>, Punit Agrawal <Punit.Agrawal@arm.com>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello KP,

On Tue, Jan 06, 2015 at 04:38:20PM +0000, Kapileshwar Singh wrote:
> Thanks for looking into this Eduardo!
>=20
> The patch (appended) aims at accomplishing the following:
>=20
>     * populate the thermal_zone_parameters and tbps correctly in of-therm=
al
>     * provide a match callback for of-thermal
>     * Remove the of-thermal specific bind and unbind operations.
>=20
> I also see that in of-thermal.c:
>=20
> struct __thermal_bind_params {
>         struct device_node *cooling_device;
>=20
> The device_node is named as cooling_device which is a misnomer and would =
like to change it to (as a separate patch)
>=20
> struct __thermal_bind_params {
>         struct device_node *cdev_node;
>=20
> Cheers!
> KP
>=20
> Possible Patch:

Can you please resend this patch separately? Just asking because it got
the same encoding issue that Javi had. Maybe, discussing with him to do
the same fix for you, the you resend it.=20

It is a bit annoying to review your patches with encoding scrambled, as
most of the scripting we have is not useful. Besides, we cannot apply
it.

>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index e032b9bf4085..04bd5f5a806c 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -138,60 +138,6 @@ static int of_thermal_get_trend(struct thermal_zone_=
device *tz, int trip,
>  	return 0;
>  }
> =20
> -static int of_thermal_bind(struct thermal_zone_device *thermal,
> -			   struct thermal_cooling_device *cdev)
> -{
> -	struct __thermal_zone *data =3D thermal->devdata;
> -	int i;
> -
> -	if (!data || IS_ERR(data))
> -		return -ENODEV;
> -
> -	/* find where to bind */
> -	for (i =3D 0; i < data->num_tbps; i++) {
> -		struct __thermal_bind_params *tbp =3D data->tbps + i;
> -
> -		if (tbp->cooling_device =3D=3D cdev->np) {
> -			int ret;
> -
> -			ret =3D thermal_zone_bind_cooling_device(thermal,
> -						tbp->trip_id, cdev,
> -						tbp->max,
> -						tbp->min);
> -			if (ret)
> -				return ret;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static int of_thermal_unbind(struct thermal_zone_device *thermal,
> -			     struct thermal_cooling_device *cdev)
> -{
> -	struct __thermal_zone *data =3D thermal->devdata;
> -	int i;
> -
> -	if (!data || IS_ERR(data))
> -		return -ENODEV;
> -
> -	/* find where to unbind */
> -	for (i =3D 0; i < data->num_tbps; i++) {
> -		struct __thermal_bind_params *tbp =3D data->tbps + i;
> -
> -		if (tbp->cooling_device =3D=3D cdev->np) {
> -			int ret;
> -
> -			ret =3D thermal_zone_unbind_cooling_device(thermal,
> -						tbp->trip_id, cdev);
> -			if (ret)
> -				return ret;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>  static int of_thermal_get_mode(struct thermal_zone_device *tz,
>  			       enum thermal_device_mode *mode)
>  {
> @@ -314,9 +260,6 @@ static struct thermal_zone_device_ops of_thermal_ops =
=3D {
>  	.get_trip_hyst =3D of_thermal_get_trip_hyst,
>  	.set_trip_hyst =3D of_thermal_set_trip_hyst,
>  	.get_crit_temp =3D of_thermal_get_crit_temp,
> -
> -	.bind =3D of_thermal_bind,
> -	.unbind =3D of_thermal_unbind,
>  };
> =20
>  /***   sensor API   ***/
> @@ -553,6 +496,109 @@ static int thermal_of_populate_bind_params(struct d=
evice_node *np,
>  	return ret;
>  }
> =20
> +int of_thermal_match_bind_param(struct thermal_zone_device *tz,
> +				struct thermal_cooling_device *cdev)
> +{
> +	struct __thermal_zone *data =3D tz->devdata;
> +	int i;
> +
> +	if (!data || IS_ERR(data))
> +		return -ENODEV;
> +
> +	for (i =3D 0; i < data->num_tbps; i++) {
> +		struct __thermal_bind_params *__tbp =3D data->tbps + i;
> +
> +		if (__tbp->cooling_device =3D=3D cdev->np)
> +			return 0;
> +	}
> +
> +	return -1;

Please, use kernel error codes.

> +}
> +
> +static unsigned long* thermal_of_build_trip_limits(struct __thermal_zone=
 *__tz)
> +{
> +
> +	struct __thermal_bind_params *__tbp =3D __tz->tbps;
> +	unsigned long *limits;
> +	int i;
> +
> +	limits =3D kcalloc(2 * __tz->ntrips, sizeof(*limits), GFP_KERNEL);
> +	if (!limits)
> +		return ERR_PTR(ENOMEM);
> +
> +	for (i =3D 0; i < __tz->num_tbps; i++) {
> +		limits[ __tbp->trip_id * 2 ] =3D __tbp[i].min;
> +		limits[ __tbp->trip_id * 2 + 1] =3D __tbp[i].max;

Did I miss something or are you always assigning to the same index of
limits?

> +	}
> +
> +	return limits;
> +}
> +
> +static struct thermal_zone_params* of_thermal_populate_tzp(struct __ther=
mal_zone *__tz)
> +{
> +	struct thermal_zone_params *tzp;
> +	struct __thermal_bind_params *__tbp =3D __tz->tbps;
> +	struct thermal_bind_params *tbp;
> +	unsigned long *limits =3D NULL;
> +	int err;
> +	int i;
> +
> +	tzp =3D kzalloc(sizeof(*tzp), GFP_KERNEL);
> +	if (!tzp)
> +		return ERR_PTR(ENOMEM);
> +
> +	if (!__tbp || !__tz->num_tbps) {
> +		err =3D ENODEV;
> +		goto free_tzp;
> +	}
> +
> +	tbp =3D kcalloc(__tz->num_tbps, sizeof(*tbp), GFP_KERNEL);
> +	if (!tbp) {
> +		err =3D ENOMEM;
> +		goto free_tzp;
> +	}
> +
> +	/* We have a number of trips in tz */
> +	for (i =3D 0; i < __tz->num_tbps; i++) {
> +		if (limits)
> +			limits =3D kmemdup(&limits, 2 * __tz->ntrips * sizeof(*limits), GFP_K=
ERNEL);

Why is this required?

> +		else
> +			limits =3D thermal_of_build_trip_limits(__tz);
> +
> +		if (IS_ERR(limits)) {
> +			err =3D ENOMEM;
> +			goto free_tbp;
> +		}
> +
> +		tbp[i].weight =3D __tbp[i].usage;
> +		tbp[i].binding_limits =3D limits;
> +		tbp[i].match =3D of_thermal_match_bind_param;
> +	}
> +
> +	tzp->tbp =3D tbp;
> +	tzp->num_tbps =3D __tz->num_tbps;
> +
> +	/* No hwmon because there might be hwmon drivers registering */
> +	tzp->no_hwmon =3D true;
> +
> +	return tzp;
> +
> +	/* Error handling code */
> +	free_tbp:

it is common to have labels in the first column.

> +		/* Free all the correctly allocated binding_limits */
> +		for (i =3D 0; i < __tz->num_tbps; i++) {
> +			if (tbp[i].binding_limits)
> +				kfree(tbp[i].binding_limits);
> +		}
> +
> +		/* Free the binding parameters */
> +		kfree(tbp);
> +
> +	free_tzp:

ditto.

> +		kfree(tzp);
> +		return ERR_PTR(err);

Remember to free the resources also in the of_thermal_destroy_zones().

> +}
> +
>  /**
>   * It maps 'enum thermal_trip_type' found in include/linux/thermal.h
>   * into the device tree binding of 'trip', property type.
> @@ -812,15 +858,14 @@ int __init of_parse_thermal_zones(void)
>  		if (!ops)
>  			goto exit_free;
> =20
> -		tzp =3D kzalloc(sizeof(*tzp), GFP_KERNEL);
> -		if (!tzp) {
> +
> +		tzp =3D of_thermal_populate_tzp(tz);
> +
> +		if (IS_ERR(tzp)) {
>  			kfree(ops);
>  			goto exit_free;
>  		}
> =20
> -		/* No hwmon because there might be hwmon drivers registering */
> -		tzp->no_hwmon =3D true;
> -
>  		if (!of_property_read_u32(child, "sustainable-power", &prop))
>  			tzp->sustainable_power =3D prop;
>  =20




you may want to base your code on public trees, unless you want to make
this one part of Javi's series.

>=20
> On 05/01/15 21:31, Eduardo Valentin wrote:
> > On Mon, Dec 22, 2014 at 04:36:26PM +0000, Kapileshwar Singh wrote:
> >> Many thanks for looking through this! Had a few observations regarding
> >> the same:
> >> On 22/12/14 03:23, Zhang Rui wrote:
> >>> On Thu, 2014-12-18 at 16:44 +0000, Kapileshwar Singh wrote:
> >>>> Thanks for Reviewing this!
> >>>>
> >>>> On 18/12/14 13:43, Eduardo Valentin wrote:
> >>>>> On Thu, Dec 18, 2014 at 12:19:00PM +0000, Kapileshwar Singh wrote:
> >>>>>> The Problem:
> >>>>>>
> >>>>>> In the current code, the weight of the cooling device, which is re=
ad as
> >>>>>> contribution from the device tree in of-thermal.c as:
> >>>>>>
> >>>>>>
> >>>>>>         ret =3D of_property_read_u32(np, "contribution", &prop);
> >>>>>>         if (ret =3D=3D 0)
> >>>>>>                 __tbp->usage =3D prop;
> >>>>>>
> >>>>>> This is only stored in the private devicedata as:
> >>>>>>
> >>>>>>         ((__thernal_zone *)cdev->devdata)->__tbp->usage
> >>>>>>
> >>>>>> As of-thermal.c specifies its "bind" operation and does not popula=
te
> >>>>>> tzd->tzp->tbp, this causes an erroneous access in the fair-share
> >>>>>> governor when it tries to access the weight:
> >>>>>>
> >>>>>> instance->target =3D get_target_state(tz, cdev,
> >>>>>>                                         tzp->tbp[i].weight,
> >>>>>> cur_trip_level);
> >>>>>>
> >>>>>>
> >>>>>> The Proposed solution:
> >>>>>>
> >>>>>> The proposed solution has the following changes:
> >>>>>>
> >>>>>>  1. Passing the weight as an argument to thermal_zone_bind_cooling=
_device
> >>>>>>
> >>>>>>  2. Storing the weight in the thermal_instance data structure crea=
ted in
> >>>>>> the thermal_zone_bind_cooling_device function
> >>>>>>
> >>>>>>  3. Changing the accesses in the governor accordingly.
> >>>>> Shouldn't we simply:
> >>>>> 1. In of-thermal, populate tzd->tzp->tbp by passing a tbp with corr=
ect
> >>>>> tbp's in the registration call:
> >>>>>     zone =3D thermal_zone_device_register(child->name, tz->ntrips,
> >>>>>                                             0,
> >>>>>                                             tz,
> >>>>>                                             ops,
> >>>>> /* This guy needs to be filled properly */  tzp,
> >>>>>                                             tz->passive_delay,
> >>>>>                                             tz->polling_delay);
> >>>> The reason why I think this might not work is because we do not have=
 the cooling device information (pointer) when we register the thermal zone=
 device.
> >>>>
> >>> and I think that is why .match() callback in struct thermal_bind_para=
ms
> >>> is introduced.
> >> of-thermal defines a bind function and stores the binding information =
in
> >> a private data structure.
> >>
> >> Looking at the code where a cooling device is bound
> >> there seem to be two options:
> >>
> >> 1. There is a bind operation defined that figures out a set of bind
> >> parameters and the cooling device associated with them (ops->bind)
> >>    and calls back into thermal_zone_bind_cooling_device.
> >>
> >> 2. Or there can be bind parameters (tbp) defined that specify a match
> >> operation to match the cooling device to the thermal zone device.
> >>
> >> 1 and 2 being mutually exclusive as follows (in thermal-core.c: bind_tz
> >> and bind_cdev:
> >>
> >>                 if (pos->ops->bind) {
> >>                         ret =3D pos->ops->bind(pos, cdev);
> >>                         if (ret)
> >>                                 print_bind_err_msg(pos, cdev, ret);
> >>                         continue;
> >>                 }
> >>
> >>                 tzp =3D pos->tzp;
> >>                 if (!tzp || !tzp->tbp)
> >>                         continue;
> >>
> >>                 for (i =3D 0; i < tzp->num_tbps; i++) {
> >>                         if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
> >>                                 continue;
> >>                         if (tzp->tbp[i].match(pos, cdev))
> >>                                 continue;
> >>                         tzp->tbp[i].cdev =3D cdev;
> >>                         __bind(pos, tzp->tbp[i].trip_mask, cdev,
> >>                                tzp->tbp[i].binding_limits);
> >>                 }
> >>
> >> the match function wont be called if a tz->ops->bind is defined.
> > The above description is a correct understanding. You are right.
> >
> >> The fix suggested above would involve the removal of the
> >> __thermal_zone and __thermal_bind_params private data structures and
> >> also removing the bind operation from of-thermal.c.
> >> Would that be a direction we would like to proceed in?
> > well, we would need to see the code to answer that :-) But sounds like a
> > sane idea, yes.
> >
> >> I also think since thermal_instance is populated by
> >> thermal_zone_bind_cooling_device and represents a "bound" configuration
> >> for both the branches (ops->bind and .match()) it could make sense to
> >> add weight as a part of the thermal_instance as something
> >> that is a part of the "bound" configuration.
> >>
> > here we jump into a different subject. Why would the weight be instance
> > specific and not platform specific (as currently coded)?
> >
> >
> >> I do realize that I could be completely wrong here and would appreciate
> >> if you can point me towards the right direction.
> >>
> > there is no issue, the right direction is open discussion, as we are
> > doing already.
> >
> >> Regards,
> >> KP
> >>
> >>
> >> thanks, rui
> >>>>> 2. Add a proper check in the governor to avoid accessing thermal zo=
nes
> >>>>> with missing data.
> >>>>>
> >>>>> I know there is a check in place:
> >>>>>         if (!tz->tzp || !tz->tzp->tbp)
> >>>>>               return -EINVAL;
> >>>>>
> >>>>> which based in your description seams to be failing. Here, I need m=
ore
> >>>>> info from your side describing what exactly you are seeing. Can you
> >>>>> please post the kernel log when the failure happens? Does it output=
 a
> >>>>> kernel segfault or is the governor simply not working?
> >>>> There is no crash as such, it is more of a semantic failure where th=
e weight being read from the device tree is not passed to the bind paramete=
rs.
> >>>>
> >>>> Cheers!
> >>>> KP
> >>>>
> >>>>
> >>>>> I would expect, with the current code, the governor be silent and
> >>>>> non-functional, which needs to be fixed too.
> >>>>>>  I am not sure of what default value should be assigned to the wei=
ght
> >>>>>> member in the instance data structure and would like to leave this=
 open
> >>>>>> to discussion.
> >>>>>>
> >>>>>> Suggested Patch (Not Signed off):
> >>>>>>
> >>>>>> diff --git a/drivers/thermal/db8500_thermal.c
> >>>>>> b/drivers/thermal/db8500_thermal.c
> >>>>>> index 1e3b3bf9f993..e3ccc2218eb3 100644
> >>>>>> --- a/drivers/thermal/db8500_thermal.c
> >>>>>> +++ b/drivers/thermal/db8500_thermal.c
> >>>>>> @@ -76,7 +76,7 @@ static int db8500_cdev_bind(struct thermal_zone_=
device
> >>>>>> *thermal,
> >>>>>>          upper =3D lower =3D i > max_state ? max_state : i;
> >>>>>>
> >>>>>>          ret =3D thermal_zone_bind_cooling_device(thermal, i, cdev,
> >>>>>> -            upper, lower);
> >>>>>> +            upper, lower, THERMAL_WEIGHT_DEFAULT);
> >>>>>>
> >>>>> I think spreading such parameter, which is known to be part of tbp,=
 is
> >>>>> not a good thing to do. Can we avoid that?
> >>>>>
> >>>>>
> >>>>> Cheers, Eduardo
> >>>>>>          dev_info(&cdev->device, "%s bind to %d: %d-%s\n", cdev->t=
ype,
> >>>>>>              i, ret, ret ? "fail" : "succeed");
> >>>>>> diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_s=
hare.c
> >>>>>> index 6e0a3fbfae86..c3b25187b467 100644
> >>>>>> --- a/drivers/thermal/fair_share.c
> >>>>>> +++ b/drivers/thermal/fair_share.c
> >>>>>> @@ -109,7 +109,7 @@ static int fair_share_throttle(struct
> >>>>>> thermal_zone_device *tz, int trip)
> >>>>>>              continue;
> >>>>>>
> >>>>>>          instance->target =3D get_target_state(tz, cdev,
> >>>>>> -                    tzp->tbp[i].weight, cur_trip_level);
> >>>>>> +                    instance->weight, cur_trip_level);
> >>>>>>
> >>>>>>          instance->cdev->updated =3D false;
> >>>>>>          thermal_cdev_update(cdev);
> >>>>>> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_t=
hermal.c
> >>>>>> index 5a1f1070b702..74d0c9951eef 100644
> >>>>>> --- a/drivers/thermal/imx_thermal.c
> >>>>>> +++ b/drivers/thermal/imx_thermal.c
> >>>>>> @@ -307,7 +307,8 @@ static int imx_bind(struct thermal_zone_device=
 *tz,
> >>>>>>
> >>>>>>      ret =3D thermal_zone_bind_cooling_device(tz, IMX_TRIP_PASSIVE=
, cdev,
> >>>>>>                             THERMAL_NO_LIMIT,
> >>>>>> -                           THERMAL_NO_LIMIT);
> >>>>>> +                           THERMAL_NO_LIMIT
> >>>>>> +                           THERMAL_WEIGHT_DEFAULT);
> >>>>>>      if (ret) {
> >>>>>>          dev_err(&tz->device,
> >>>>>>              "binding zone %s with cdev %s failed:%d\n",
> >>>>>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-the=
rmal.c
> >>>>>> index e032b9bf4085..cf4036cbb671 100644
> >>>>>> --- a/drivers/thermal/of-thermal.c
> >>>>>> +++ b/drivers/thermal/of-thermal.c
> >>>>>> @@ -157,7 +157,8 @@ static int of_thermal_bind(struct
> >>>>>> thermal_zone_device *thermal,
> >>>>>>              ret =3D thermal_zone_bind_cooling_device(thermal,
> >>>>>>                          tbp->trip_id, cdev,
> >>>>>>                          tbp->max,
> >>>>>> -                        tbp->min);
> >>>>>> +                        tbp->min,
> >>>>>> +                        tbp->usage);
> >>>>>>              if (ret)
> >>>>>>                  return ret;
> >>>>>>          }
> >>>>>> diff --git a/drivers/thermal/samsung/exynos_thermal_common.c
> >>>>>> b/drivers/thermal/samsung/exynos_thermal_common.c
> >>>>>> index b6be572704a4..d653798b519f 100644
> >>>>>> --- a/drivers/thermal/samsung/exynos_thermal_common.c
> >>>>>> +++ b/drivers/thermal/samsung/exynos_thermal_common.c
> >>>>>> @@ -163,7 +163,7 @@ static int exynos_bind(struct thermal_zone_dev=
ice
> >>>>>> *thermal,
> >>>>>>          case MONITOR_ZONE:
> >>>>>>          case WARN_ZONE:
> >>>>>>              if (thermal_zone_bind_cooling_device(thermal, i, cdev,
> >>>>>> -                                level, 0)) {
> >>>>>> +                                level, 0, THERMAL_WEIGHT_DEFAULT)=
) {
> >>>>>>                  dev_err(data->dev,
> >>>>>>                      "error unbinding cdev inst=3D%d\n", i);
> >>>>>>                  ret =3D -EINVAL;
> >>>>>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/ther=
mal_core.c
> >>>>>> index 4921e084c20b..199866864ef1 100644
> >>>>>> --- a/drivers/thermal/thermal_core.c
> >>>>>> +++ b/drivers/thermal/thermal_core.c
> >>>>>> @@ -277,7 +277,8 @@ static void print_bind_err_msg(struct
> >>>>>> thermal_zone_device *tz,
> >>>>>>
> >>>>>>  static void __bind(struct thermal_zone_device *tz, int mask,
> >>>>>>              struct thermal_cooling_device *cdev,
> >>>>>> -            unsigned long *limits)
> >>>>>> +            unsigned long *limits,
> >>>>>> +            unsigned int weight)
> >>>>>>  {
> >>>>>>      int i, ret;
> >>>>>>
> >>>>>> @@ -292,7 +293,8 @@ static void __bind(struct thermal_zone_device =
*tz,
> >>>>>> int mask,
> >>>>>>                  upper =3D limits[i * 2 + 1];
> >>>>>>              }
> >>>>>>              ret =3D thermal_zone_bind_cooling_device(tz, i, cdev,
> >>>>>> -                                   upper, lower);
> >>>>>> +                                   upper, lower,
> >>>>>> +                                   weight);
> >>>>>>              if (ret)
> >>>>>>                  print_bind_err_msg(tz, cdev, ret);
> >>>>>>          }
> >>>>>> @@ -339,7 +341,8 @@ static void bind_cdev(struct thermal_cooling_d=
evice
> >>>>>> *cdev)
> >>>>>>                  continue;
> >>>>>>              tzp->tbp[i].cdev =3D cdev;
> >>>>>>              __bind(pos, tzp->tbp[i].trip_mask, cdev,
> >>>>>> -                   tzp->tbp[i].binding_limits);
> >>>>>> +                   tzp->tbp[i].binding_limits,
> >>>>>> +                   tzp->tbp[i].weight);
> >>>>>>          }
> >>>>>>      }
> >>>>>>
> >>>>>> @@ -378,7 +381,8 @@ static void bind_tz(struct thermal_zone_device=
 *tz)
> >>>>>>                  continue;
> >>>>>>              tzp->tbp[i].cdev =3D pos;
> >>>>>>              __bind(tz, tzp->tbp[i].trip_mask, pos,
> >>>>>> -                   tzp->tbp[i].binding_limits);
> >>>>>> +                   tzp->tbp[i].binding_limits,
> >>>>>> +                   tzp->tbp[i].weight);
> >>>>>>          }
> >>>>>>      }
> >>>>>>  exit:
> >>>>>> @@ -770,7 +774,8 @@ passive_store(struct device *dev, struct
> >>>>>> device_attribute *attr,
> >>>>>>                  thermal_zone_bind_cooling_device(tz,
> >>>>>>                          THERMAL_TRIPS_NONE, cdev,
> >>>>>>                          THERMAL_NO_LIMIT,
> >>>>>> -                        THERMAL_NO_LIMIT);
> >>>>>> +                        THERMAL_NO_LIMIT,
> >>>>>> +                        THERMAL_WEIGHT_DEFAULT);
> >>>>>>          }
> >>>>>>          mutex_unlock(&thermal_list_lock);
> >>>>>>          if (!tz->passive_delay)
> >>>>>> @@ -1009,7 +1014,9 @@ thermal_cooling_device_trip_point_show(struct
> >>>>>> device *dev,
> >>>>>>   * @lower:    the Minimum cooling state can be used for this trip=
 point.
> >>>>>>   *        THERMAL_NO_LIMIT means no lower limit,
> >>>>>>   *        and the cooling device can be in cooling state 0.
> >>>>>> - *
> >>>>>> + * @weight:    The weight of the cooling device to be bound to the
> >>>>>> +        thermal zone. THERMAL_WEIGHT_DEFAULT for default value
> >>>>>> +
> >>>>>>   * This interface function bind a thermal cooling device to the c=
ertain
> >>>>>> trip
> >>>>>>   * point of a thermal zone device.
> >>>>>>   * This function is usually called in the thermal zone device .bi=
nd
> >>>>>> callback.
> >>>>>> @@ -1019,7 +1026,8 @@ thermal_cooling_device_trip_point_show(struct
> >>>>>> device *dev,
> >>>>>>  int thermal_zone_bind_cooling_device(struct thermal_zone_device *=
tz,
> >>>>>>                       int trip,
> >>>>>>                       struct thermal_cooling_device *cdev,
> >>>>>> -                     unsigned long upper, unsigned long lower)
> >>>>>> +                     unsigned long upper, unsigned long lower,
> >>>>>> +                     unsigned int weight)
> >>>>>>  {
> >>>>>>      struct thermal_instance *dev;
> >>>>>>      struct thermal_instance *pos;
> >>>>>> @@ -1062,6 +1070,7 @@ int thermal_zone_bind_cooling_device(struct
> >>>>>> thermal_zone_device *tz,
> >>>>>>      dev->upper =3D upper;
> >>>>>>      dev->lower =3D lower;
> >>>>>>      dev->target =3D THERMAL_NO_TARGET;
> >>>>>> +    dev->weight =3D weight;
> >>>>>>
> >>>>>>      result =3D get_idr(&tz->idr, &tz->lock, &dev->id);
> >>>>>>      if (result)
> >>>>>> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/ther=
mal_core.h
> >>>>>> index b907be823527..1c61abe7801f 100644
> >>>>>> --- a/drivers/thermal/thermal_core.h
> >>>>>> +++ b/drivers/thermal/thermal_core.h
> >>>>>> @@ -48,6 +48,7 @@ struct thermal_instance {
> >>>>>>      struct device_attribute attr;
> >>>>>>      struct list_head tz_node; /* node in tz->thermal_instances */
> >>>>>>      struct list_head cdev_node; /* node in cdev->thermal_instance=
s */
> >>>>>> +    unsigned int weight; /* The weight of the cooling device */
> >>>>>>  };
> >>>>>>
> >>>>>>  int thermal_register_governor(struct thermal_governor *);
> >>>>>> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> >>>>>> b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> >>>>>> index 9eec26dc0448..772549ec9bd8 100644
> >>>>>> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> >>>>>> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> >>>>>> @@ -147,7 +147,8 @@ static int ti_thermal_bind(struct
> >>>>>> thermal_zone_device *thermal,
> >>>>>>      return thermal_zone_bind_cooling_device(thermal, 0, cdev,
> >>>>>>      /* bind with min and max states defined by cpu_cooling */
> >>>>>>                          THERMAL_NO_LIMIT,
> >>>>>> -                        THERMAL_NO_LIMIT);
> >>>>>> +                        THERMAL_NO_LIMIT,
> >>>>>> +                        THERMAL_WEIGHT_DEFAULT);
> >>>>>>  }
> >>>>>>
> >>>>>>  /* Unbind callback functions for thermal zone */
> >>>>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> >>>>>> index fc4fdcbbdecc..674795ba0900 100644
> >>>>>> --- a/include/linux/thermal.h
> >>>>>> +++ b/include/linux/thermal.h
> >>>>>> @@ -40,6 +40,9 @@
> >>>>>>  /* No upper/lower limit requirement */
> >>>>>>  #define THERMAL_NO_LIMIT    ((u32)~0)
> >>>>>>
> >>>>>> +/* Default weight of a bound cooling device */
> >>>>>> +#define THERMAL_WEIGHT_DEFAULT 1
> >>>>>> +
> >>>>>>  /* Unit conversion macros */
> >>>>>>  #define KELVIN_TO_CELSIUS(t)    (long)(((long)t-2732 >=3D 0) ?   =
 \
> >>>>>>                  ((long)t-2732+5)/10 : ((long)t-2732-5)/10)
> >>>>>> @@ -375,7 +378,8 @@ void thermal_zone_device_unregister(struct
> >>>>>> thermal_zone_device *);
> >>>>>>
> >>>>>>  int thermal_zone_bind_cooling_device(struct thermal_zone_device *=
, int,
> >>>>>>                       struct thermal_cooling_device *,
> >>>>>> -                     unsigned long, unsigned long);
> >>>>>> +                     unsigned long, unsigned long,
> >>>>>> +                     unsigned int);
> >>>>>>  int thermal_zone_unbind_cooling_device(struct thermal_zone_device=
 *, int,
> >>>>>>                         struct thermal_cooling_device *);
> >>>>>>  void thermal_zone_device_update(struct thermal_zone_device *);
> >>>>>>
> >>>>>>
> >>>
> >>
>=20
>=20

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrCtEAAoJEMLUO4d9pOJW3kMH/30glreBaqSSysf+KCx47SUk
WKVbZncIIaY9JVtOqYPTuFcRbbOwCi6h2dnQlGNaZd4dKipt9ihO4RqXFLsqjVyn
J2YZGGfKlZlzSHVW53hU15xA9kokZNRWt+9TgwtNkzdbxZvPVaKrErSm0Ip9dAo8
DQWwIJwjSr5rSYWRmmklk8Gon8ysnCOGbpPaKW6bPgkjb6qZRJ+n09NGhbhuz5NF
lXlodxPz3dfj6clLKvERQP5LlQSZQ/eE4K/KiylUpK7+QQ3DaEDKHNdqfYi11CDv
CffZUoOB0lE694WTYzpFoIbtuCiGS+JcfGV5SNSDM+dswRqjD4TafoI1vQmPF1g=
=SzSx
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
