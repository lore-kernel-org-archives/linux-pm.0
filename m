From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] thermal: of: Introduce governor selection in dts
Date: Fri, 7 Aug 2015 11:31:21 +0100
Message-ID: <20150807103121.GC7646@leverpostej>
References: <CAM2ehZYXsqCoS9ygXNfPHxt9-b5cFxH_ovrgjvM-BfDO6REcUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAM2ehZYXsqCoS9ygXNfPHxt9-b5cFxH_ovrgjvM-BfDO6REcUg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chung-Yih Wang =?utf-8?B?KOeOi+W0h+aHvyk=?= <cywang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 07, 2015 at 08:09:39AM +0100, Chung-Yih Wang (=E7=8E=8B=E5=B4=
=87=E6=87=BF) wrote:
> As there could be more thermal zones on a system and
> more variety in thermal governors provided in kernel,
> this patch provides flexibility of governor selection
> for a thermal zone declared in device tree.
>=20
> Change-Id: Ie4a75d762709cbbe9f1806dae325d13f71982e78
> Signed-off-by: Chung-yih Wang <cywang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt |  9 +++++++++
>  drivers/thermal/of-thermal.c                          | 10 +++++++++=
+
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt
> b/Documentation/devicetree/bindings/thermal/thermal.txt
> index 8a49362..30a5d41 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -174,6 +174,13 @@ Optional property:
>                         2000mW, while on a 10'' tablet is around
>                         4500mW.
>=20
> +- thermal-governor-name:       The name of governor used to control =
the
> +                               thermal zone instead of the default o=
ne
> +                               specified in kernel config. For refer=
ence, if
> +                               default governor is step_wise, one co=
uld
> +                               select power_allocator for cpu_therma=
l zone
> +                               in dts.


This is not a hardware or system property, but rather a Linux
implementation detail.

This really shouldn't go in the DT.

Mark.

> +
>  Note: The delay properties are bound to the maximum dT/dt (temperatu=
re
>  derivative over time) in two situations for a thermal zone:
>  (i)  - when passive cooling is activated (polling-delay-passive); an=
d
> @@ -555,6 +562,8 @@ thermal-zones {
>=20
>                 sustainable-power =3D <2500>;
>=20
> +               thermal-governor-name =3D "power_allocator";
> +
>                 trips {
>                         /* Trips are based on resulting linear equati=
on */
>                         cpu_trip: cpu-trip {
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-therma=
l.c
> index b295b2b..45570ac 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -882,6 +882,7 @@ int __init of_parse_thermal_zones(void)
>         }
>=20
>         for_each_child_of_node(np, child) {
> +               const char *governor_name;
>                 struct thermal_zone_device *zone;
>                 struct thermal_zone_params *tzp;
>                 int i, mask =3D 0;
> @@ -909,6 +910,15 @@ int __init of_parse_thermal_zones(void)
>                         goto exit_free;
>                 }
>=20
> +               /* Select a preferred governor if declared */
> +               if (!of_property_read_string(child,
> +                                            "thermal-governor-name",
> +                                            &governor_name)) {
> +                       strncpy(tzp->governor_name,
> +                               governor_name,
> +                               sizeof(tzp->governor_name) - 1);
> +               }
> +
>                 /* No hwmon because there might be hwmon drivers regi=
stering */
>                 tzp->no_hwmon =3D true;
>=20
> --
> 2.1.2
>=20
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
