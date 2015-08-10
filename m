From: =?UTF-8?B?Q2h1bmctWWloIFdhbmcgKOeOi+W0h+aHvyk=?=
	<cywang@google.com>
Subject: Re: [PATCH] thermal: of: Introduce governor selection in dts
Date: Mon, 10 Aug 2015 16:00:49 +0800
Message-ID: <CAM2ehZYy3SNKhXvF0XyQsoPFab2JqrVq3wLKadPVxBsVG3E7jw@mail.gmail.com>
References: <CAM2ehZYXsqCoS9ygXNfPHxt9-b5cFxH_ovrgjvM-BfDO6REcUg@mail.gmail.com>
 <20150807103121.GC7646@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150807103121.GC7646@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, javi.merino@arm.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

This patch was originally introduced when we made power_allocator the
default governor where we had issues in binding a thermal zone w/o
parameters to. Then we came out this facility for binding a specific
governor to a thermal zone in dts instead of the default governor.
Javi seems like this idea much.

On Fri, Aug 7, 2015 at 6:31 PM, Mark Rutland <mark.rutland@arm.com> wro=
te:
> On Fri, Aug 07, 2015 at 08:09:39AM +0100, Chung-Yih Wang (=E7=8E=8B=E5=
=B4=87=E6=87=BF) wrote:
>> As there could be more thermal zones on a system and
>> more variety in thermal governors provided in kernel,
>> this patch provides flexibility of governor selection
>> for a thermal zone declared in device tree.
>>
>> Change-Id: Ie4a75d762709cbbe9f1806dae325d13f71982e78
>> Signed-off-by: Chung-yih Wang <cywang@chromium.org>
>> ---
>>  Documentation/devicetree/bindings/thermal/thermal.txt |  9 ++++++++=
+
>>  drivers/thermal/of-thermal.c                          | 10 ++++++++=
++
>>  2 files changed, 19 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt
>> b/Documentation/devicetree/bindings/thermal/thermal.txt
>> index 8a49362..30a5d41 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
>> @@ -174,6 +174,13 @@ Optional property:
>>                         2000mW, while on a 10'' tablet is around
>>                         4500mW.
>>
>> +- thermal-governor-name:       The name of governor used to control=
 the
>> +                               thermal zone instead of the default =
one
>> +                               specified in kernel config. For refe=
rence, if
>> +                               default governor is step_wise, one c=
ould
>> +                               select power_allocator for cpu_therm=
al zone
>> +                               in dts.
>
>
> This is not a hardware or system property, but rather a Linux
> implementation detail.
>
> This really shouldn't go in the DT.
>
> Mark.
>
>> +
>>  Note: The delay properties are bound to the maximum dT/dt (temperat=
ure
>>  derivative over time) in two situations for a thermal zone:
>>  (i)  - when passive cooling is activated (polling-delay-passive); a=
nd
>> @@ -555,6 +562,8 @@ thermal-zones {
>>
>>                 sustainable-power =3D <2500>;
>>
>> +               thermal-governor-name =3D "power_allocator";
>> +
>>                 trips {
>>                         /* Trips are based on resulting linear equat=
ion */
>>                         cpu_trip: cpu-trip {
>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-therm=
al.c
>> index b295b2b..45570ac 100644
>> --- a/drivers/thermal/of-thermal.c
>> +++ b/drivers/thermal/of-thermal.c
>> @@ -882,6 +882,7 @@ int __init of_parse_thermal_zones(void)
>>         }
>>
>>         for_each_child_of_node(np, child) {
>> +               const char *governor_name;
>>                 struct thermal_zone_device *zone;
>>                 struct thermal_zone_params *tzp;
>>                 int i, mask =3D 0;
>> @@ -909,6 +910,15 @@ int __init of_parse_thermal_zones(void)
>>                         goto exit_free;
>>                 }
>>
>> +               /* Select a preferred governor if declared */
>> +               if (!of_property_read_string(child,
>> +                                            "thermal-governor-name"=
,
>> +                                            &governor_name)) {
>> +                       strncpy(tzp->governor_name,
>> +                               governor_name,
>> +                               sizeof(tzp->governor_name) - 1);
>> +               }
>> +
>>                 /* No hwmon because there might be hwmon drivers reg=
istering */
>>                 tzp->no_hwmon =3D true;
>>
>> --
>> 2.1.2
>>
