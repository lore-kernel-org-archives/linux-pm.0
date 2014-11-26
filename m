From: navneet kumar <navneetk@nvidia.com>
Subject: Re: [PATCH v2 3/4] thermal: of: Extend of-thermal to export table
 of trip points
Date: Wed, 26 Nov 2014 15:12:28 -0800
Message-ID: <54765E5C.4000901@nvidia.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com> <1416500488-7232-1-git-send-email-l.majewski@samsung.com> <1416500488-7232-4-git-send-email-l.majewski@samsung.com> <20141125203629.GA14292@developer> <20141126093510.4233ff7f@amdc2363> <20141126151828.GC3925@developer> <54763B66.90208@nvidia.com> <54764255.9040404@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54764255.9040404@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Mikko Perttunen <mperttunen@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, linux-kernel@vger.kernel.org, Caesar Wang <caesar.wang@rock-chips.com>
List-Id: linux-pm@vger.kernel.org



On 11/26/2014 01:12 PM, Guenter Roeck wrote:
> On 11/26/2014 12:43 PM, navneet kumar wrote:
>>
>> Hi Eduardo, Lukasz,
>>
>> [Combining my concerns as a single text blob here]
>>
>> I. Firstly, with the current patch
>>     1. is it really needed to duplicate the struct thermal_trip? Why
>> don=92t
>>     we get rid of the __thermal_trip and stay with the 'thermal_trip=
'
>> ? it
>>     is not a big change.
>>
>>     2. gtrips is not updated on "set_trip_temp" etc. actions via
>> sysfs. (am
>>     I missing something?).
>>
>> II. The other concern is more of a design question
>>     1. Do we intend to keep the of-thermal as a middle layer between=
 the
>>     thermal_core and the sensor device? OR, is the role of of-therma=
l
>> just
>>     to parse the DT and opt out ? currently of-thermal is somewhat a
>> hybrid
>>     of these as, in addition to parsing the dt, it holds on to the d=
ata
>>     related to trip points etc. etc.
>>
>>     2. assuming latter is true (OF is just a dt parser helper): we s=
hould
>>     not be adding more intelligence and dependencies linked to the O=
=46.
>>
>>     3. assuming former is true (OF is a well-defined middle layer):
>> All is
>>     good till the point OF maintains the trip points (which is a goo=
d
>> thing
>>     since, OF caches on to the data); BUT, if we expose this
>> information to
>>     the sensor device too (as this patch is doing),
>>
>>         3a. we violate the layering principle :-)
>>
>>         3b. more importantly, this is all just excessive logic that =
we
>>         put in which *could be useful* only if we intend to extend t=
he
>>         role of OF as a trip point management layer that does more t=
han
>>         just holding on to the data. This may include -
>>
>>             -> The sensor devices to know nothing about the
>>             trip_points, instead the sensor devices would work on
>>             "temperature thresholds" and OF would map sensor
>>             thresholds to the actual trip points as needed
>>             (configured from DT); while the sensor devices stick to
>>             using "thresholds".
>>
>>             -> Queuing from above, sensors, most of the time, only
>>             need to know a high and a low temp threshold; which
>>             essentially is a subset of the active/passive etc. trip
>>             points. Calculation of that based on the current temp,
>>             as of today is replicated across all the sensor drivers
>>             and can be hoisted up to the of-thermal.
>>
>=20
> Sorry, lost you here. What replicated calculation do you refer to ?
>=20
> Thanks,
> Guenter
>=20
Some sensors have an ability to generate interrupts based upon a config=
ured high
and low temp thresholds/values. Once any of these limits is crossed, th=
e sensor
hardware has to be reconfigured with a new set of such values.

I'll try to explain with an example -
consider trip points TP1, TP2, TP3, TP4 sorted as low to high; and the =
current=20
temp T1 such that -
TP2<T1<TP3

With the conditions as is, and assuming the interrupts have been config=
ured, an
interrupt will trigger if T1 goes below TP2 or exceeds TP3.

Now, say, T1 crosses TP3, the sensor hardware generates an interrupt (a=
voids polling=20
on the zone temp). Furthermore, we require that the new limits for the =
interrupts
be TP3 and TP4 for 'low' and 'high' thresholds interrupts
respectively, such that an interrupt will be fired when temp goes below=
 TP3 or
exceeds TP4.

Above case is when the temp crosses a set of High-low. The same situati=
on may
occur when a trip point temp is changed from sysfs, in which case, the =
thresholds
for configuring the interrupts may have to be reconfigured.

Today, the sensors find the high-low thresholds by -
1. querying the temp from the thermal_zone
2. traversing the trip points (which may have been cached locally by th=
e sensor),
   and figuring out the high/low temperature thresholds.=20

These above steps aka 'replicated calculation'.

Whatever the case may be, the real question is the role and scope of of=
-thermal.


>> Seems like this is the opportune time to make a call about the role =
of
>> of-thermal?
>>
>> On 11/26/2014 07:18 AM, Eduardo Valentin wrote:
>>> * PGP Signed by an unknown key
>>>
>>> Hello,
>>>
>>> On Wed, Nov 26, 2014 at 09:35:10AM +0100, Lukasz Majewski wrote:
>>>> Hi Eduardo,
>>>>
>>>>> Hello Lukasz,
>>>>>
>>>>> On Thu, Nov 20, 2014 at 05:21:27PM +0100, Lukasz Majewski wrote:
>>>>>> This patch extends the of-thermal.c to export copy of trip point=
s
>>>>>> for a given thermal zone.
>>>>>>
>>>>>> Thermal drivers should use of_thermal_get_trip_points() method t=
o
>>>>>> get pointer to table of thermal trip points.
>>>>>>
>>>>>> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>>>>>> ---
>>>>>> Changes for v2:
>>>>>> - New patch - as suggested by Eduardo Valentin
>>>>>> ---
>>>>>>   drivers/thermal/of-thermal.c   | 33
>>>>>> +++++++++++++++++++++++++++++++++ drivers/thermal/thermal_core.h=
 |
>>>>>> 7 +++++++ include/linux/thermal.h        | 14 ++++++++++++++
>>>>>>   3 files changed, 54 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/thermal/of-thermal.c
>>>>>> b/drivers/thermal/of-thermal.c index 336af7f..33921c5 100644
>>>>>> --- a/drivers/thermal/of-thermal.c
>>>>>> +++ b/drivers/thermal/of-thermal.c
>>>>>> @@ -89,6 +89,7 @@ struct __thermal_zone {
>>>>>>       /* trip data */
>>>>>>       int ntrips;
>>>>>>       struct __thermal_trip *trips;
>>>>>> +    struct thermal_trip *gtrips;
>> Do we really need this duplication ?
>>>>>>
>>>>>>       /* cooling binding data */
>>>>>>       int num_tbps;
>>>>>> @@ -152,6 +153,27 @@ bool of_thermal_is_trip_en(struct
>>>>>> thermal_zone_device *tz, int trip) return true;
>>>>>>   }
>>>>>>
>>>>>> +/**
>>>>>> + * of_thermal_get_trip_points - function to get access to a
>>>>>> globally exported
>>>>>> + *                trip points
>>>>>> + *
>>>>>> + * @tz:    pointer to a thermal zone
>>>>>> + *
>>>>>> + * This function provides a pointer to the copy of trip points
>>>>>> table
>>>>>> + *
>>>>>> + * Return: pointer to trip points table, NULL otherwise
>>>>>> + */
>>>>>> +const struct thermal_trip * const
>>>>>> +of_thermal_get_trip_points(struct thermal_zone_device *tz)
>>>>>> +{
>>>>>> +    struct __thermal_zone *data =3D tz->devdata;
>>>>>> +
>>>>>> +    if (!data)
>>>>>> +        return NULL;
>>>>>> +
>>>>>> +    return data->gtrips;
>>>>>> +}
>>>>>> +
>>>>>
>>>>> EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
>>>>
>>>> Ok.
>>>>
>>>>>
>>>>>>   static int of_thermal_get_trend(struct thermal_zone_device *tz=
,
>>>>>> int trip, enum thermal_trend *trend)
>>>>>>   {
>>>>>> @@ -767,6 +789,16 @@ thermal_of_build_thermal_zone(struct
>>>>>> device_node *np) goto free_tbps;
>>>>>>       }
>>>>>>
>>>>>> +    tz->gtrips =3D kcalloc(tz->ntrips, sizeof(*tz->gtrips),
>>>>>> GFP_KERNEL);
>>>>>> +    if (!tz->gtrips) {
>>>>>> +        ret =3D -ENOMEM;
>>>>>> +        goto free_tbps;
>>>>>> +    }
>>>>>> +
>>>>>> +    for (i =3D 0; i < tz->ntrips; i++)
>>>>>> +        memcpy(&(tz->gtrips[i]),
>>>>>> &(tz->trips[i].temperature),
>>>>>> +               sizeof(*tz->gtrips));
>>>>>> +
>>>>>>   finish:
>>>>>>       of_node_put(child);
>>>>>>       tz->mode =3D THERMAL_DEVICE_DISABLED;
>>>>>> @@ -793,6 +825,7 @@ static inline void of_thermal_free_zone(stru=
ct
>>>>>> __thermal_zone *tz) {
>>>>>>       int i;
>>>>>>
>>>>>> +    kfree(tz->gtrips);
>>>>>>       for (i =3D 0; i < tz->num_tbps; i++)
>>>>>>           of_node_put(tz->tbps[i].cooling_device);
>>>>>>       kfree(tz->tbps);
>> Couldn't find the code that updates *gtrips as a result of
>> set_trip_temp via
>> sysfs.
>>
>>>>>> diff --git a/drivers/thermal/thermal_core.h
>>>>>> b/drivers/thermal/thermal_core.h index 466208c..a9580ca 100644
>>>>>> --- a/drivers/thermal/thermal_core.h
>>>>>> +++ b/drivers/thermal/thermal_core.h
>>>>>> @@ -91,6 +91,8 @@ int of_parse_thermal_zones(void);
>>>>>>   void of_thermal_destroy_zones(void);
>>>>>>   int of_thermal_get_ntrips(struct thermal_zone_device *);
>>>>>>   bool of_thermal_is_trip_en(struct thermal_zone_device *, int);
>>>>>> +const struct thermal_trip * const
>>>>>> +of_thermal_get_trip_points(struct thermal_zone_device *);
>>>>>>   #else
>>>>>>   static inline int of_parse_thermal_zones(void) { return 0; }
>>>>>>   static inline void of_thermal_destroy_zones(void) { }
>>>>>> @@ -102,6 +104,11 @@ static inline bool
>>>>>> of_thermal_is_trip_en(struct thermal_zone_device *, int) {
>>>>>
>>>>> This produces compilation error when CONFIG_THERMAL_OF is not set=
=2E
>>>>> Name the parameters to fix.
>>>>
>>>> As all the other cases, I will fix that.
>>>>
>>>>>
>>>>>>       return 0;
>>>>>>   }
>>>>>> +static inline const struct thermal_trip * const
>>>>>> +of_thermal_get_trip_points(struct thermal_zone_device *)
>>>>>> +{
>>>>>> +    return NULL;
>>>>>> +}
>>>>>>   #endif
>>>>>>
>>>>>>   #endif /* __THERMAL_CORE_H__ */
>>>>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>>>>> index 5bc28a7..88d7249 100644
>>>>>> --- a/include/linux/thermal.h
>>>>>> +++ b/include/linux/thermal.h
>>>>>> @@ -303,6 +303,20 @@ struct thermal_zone_of_device_ops {
>>>>>>       int (*get_trend)(void *, long *);
>>>>>>   };
>>>>>>
>>>>>> +/**
>>>>>> + * struct thermal_trip - Structure representing themal trip poi=
nts
>>>>>> exported from
>>>>>> + *                       of-thermal
>>>>>> + *
>>>>>
>>>>> The only problem I have with this name is that would look like it=
 is
>>>>> in use in all thermal framework, which is not really the case. Bu=
t I
>>>>> do think having a type here is a good thing. So, not sure :-)
>>>>
>>>> It can stay to be struct thermal_trip or we can rename it to
>>>> struct of_thermal_trip.
>>>>
>>>> I'm fine with both names.
>>>
>>> Leave it as 'thermal_trip'.
>>>
>>>>
>>>>>
>>>>>> + * @temperature:    trip point temperature
>>>>>> + * @hysteresis:        trip point hysteresis
>>>>>> + * @type:        trip point type
>>>>>> + */
>>>>>> +struct thermal_trip {
>>>>>> +    unsigned long int temperature;
>>>>>> +    unsigned long int hysteresis;
>>>>>> +    enum thermal_trip_type type;
>>>>>> +};
>>>>>> +
>>>>>>   /* Function declarations */
>>>>>>   #ifdef CONFIG_THERMAL_OF
>>>>>>   struct thermal_zone_device *
>>>>>> --=20
>>>>>> 2.0.0.rc2
>>>>>>
>>>>
>>>>
>>>>
>>>> --=20
>>>> Best regards,
>>>>
>>>> Lukasz Majewski
>>>>
>>>> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
>>>
>>> * Unknown Key
>>> * 0x7DA4E256
>>>
>>
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
